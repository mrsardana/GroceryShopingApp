import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocerry_shopping_app/components/product_card.dart';
import 'package:grocerry_shopping_app/models/pagination.dart';
import 'package:grocerry_shopping_app/models/product_filter.dart';
import 'package:grocerry_shopping_app/models/product_sort.dart';
import 'package:grocerry_shopping_app/providers.dart';

import '../models/product.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  String? categoryId;
  String? categoryName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName!),
      ),
      body: Container(
        color: Colors.grey[300],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ProductFilters(
              categoryId: categoryId,
              categoryName: categoryName,
            ),
            Flexible(
              flex: 1,
              child: _ProductList(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    final Map? arguments = ModalRoute.of(context)!.settings.arguments as Map;

    if (arguments != null) {
      categoryName = arguments['categoryName'];
      categoryId = arguments['categoryId'];
    }

    super.didChangeDependencies();
  }
}

class _ProductFilters extends ConsumerWidget {
  final _searchQuery = TextEditingController();
  final _sortByOptions = [
    ProductSortModel(value: "createdAt", label: "Latest"),
    ProductSortModel(value: "-productPrice", label: "Price: High to Low"),
    ProductSortModel(value: "productPrice", label: "Price: Low to High"),
  ];

  _ProductFilters({
    Key? key,
    this.categoryName,
    this.categoryId,
  });

  final String? categoryName;
  final String? categoryId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterProvider = ref.watch(productsFilterProvider);
    _onSearchChange(String query) {
      if (query.isNotEmpty) {
        ProductFilterModel filterModel = ProductFilterModel(
            paginationModel: PaginationModel(
              page: 0,
              pageSize: 10,
            ),
            productName: query.toString(),
            categoryId: categoryId);
        ref.read(productsFilterProvider.notifier).setProductFilter(filterModel);
        ref.read(productsNotifierProvider.notifier).getProducts();
      } else {
        ProductFilterModel filterModel = ProductFilterModel(
            paginationModel: PaginationModel(
              page: 0,
              pageSize: 10,
            ),
            categoryId: categoryId);
        ref.read(productsFilterProvider.notifier).setProductFilter(filterModel);
        ref.read(productsNotifierProvider.notifier).getProducts();
      }
    }

    return Container(
      height: 68,
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: TextField(
                  onChanged: (value) {
                    _onSearchChange(value);
                  },
                  controller: _searchQuery,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: "Search",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    fillColor: const Color.fromARGB(255, 245, 245, 248),
                    filled: true,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                ),
                child: PopupMenuButton(
                  onSelected: (sortBy) {
                    ProductFilterModel filterModel = ProductFilterModel(
                      paginationModel: PaginationModel(
                        page: 0,
                        pageSize: 10,
                      ),
                      categoryId: filterProvider.categoryId,
                      sortBy: sortBy.toString(),
                    );
                    ref
                        .read(productsFilterProvider.notifier)
                        .setProductFilter(filterModel);
                    ref.read(productsNotifierProvider.notifier).getProducts();
                  },
                  initialValue: filterProvider.sortBy,
                  itemBuilder: (BuildContext context) {
                    return _sortByOptions
                        .map(
                          (item) => PopupMenuItem(
                            value: item.value,
                            child: InkWell(
                              child: Text(item.label!),
                            ),
                          ),
                        )
                        .toList();
                  },
                  icon: const Icon(Icons.filter_list_alt),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class _ProductList extends ConsumerWidget {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productState = ref.watch(productsNotifierProvider);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        final productsViewModel = ref.read(productsNotifierProvider.notifier);
        final productState = ref.watch(productsNotifierProvider);

        if (productState.hasNext) {
          productsViewModel.getProducts();
        }
      }
    });

    if (productState.products.isEmpty) {
      if (!productState.hasNext && !productState.isLoading) {
        return const Center(
          child: Text(
            ("No Products"),
          ),
        );
      }
      return const LinearProgressIndicator();
    }
    return RefreshIndicator(
      onRefresh: () async {
        ref.read(productsNotifierProvider.notifier).getProducts();
      },
      child: Column(
        children: [
          Flexible(
            flex: 1,
            child: GridView.count(
              crossAxisCount: 2,
              controller: _scrollController,
              children: List.generate(productState.products.length, (index) {
                return ProductCard(
                  model: productState.products[index],
                );
              }),
            ),
          ),
          Visibility(
            visible: productState.isLoading && productState.products.isNotEmpty,
            child: const SizedBox(
              height: 35,
              width: 35,
              child: CircularProgressIndicator(),
            ),
          )
        ],
      ),
    );
  }
}
