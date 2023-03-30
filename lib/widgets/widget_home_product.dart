import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocerry_shopping_app/components/product_card.dart';
import 'package:grocerry_shopping_app/models/category.dart';
import 'package:grocerry_shopping_app/models/pagination.dart';
import 'package:grocerry_shopping_app/models/product.dart';
import 'package:grocerry_shopping_app/models/product_filter.dart';
import 'package:grocerry_shopping_app/providers.dart';

class HomeProductsWidget extends ConsumerWidget {
  const HomeProductsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.grey[100],
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Padding(
              padding: EdgeInsets.only(left: 16, top: 5),
              child: Text(
                "Top 10 Products",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        _productList(ref),
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: _productList(ref),
        // ),
      ]),
    );
  }

  Widget _productList(WidgetRef ref) {
    final products = ref.watch(
      homeProductProvider(
        ProductFilterModel(
          paginationModel: PaginationModel(page: 1, pageSize: 10),
        ),
      ),
    );
    return products.when(
      data: (list) {
        return _buildProductList(list!);
      },
      error: (_, __) {
        return const Center(child: Text("ERROR"));
      },
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildProductList(List<Product> products) {
    return Container(
      height: 315,
      alignment: Alignment.centerLeft,
      child: GridView.count(
        crossAxisCount: 2,
        children: List.generate(products.length, (index) {
          return ProductCard(
            model: products[index],
          );
        }),
      ),
      // child: ListView.builder(
      //   physics: ClampingScrollPhysics(),
      //   scrollDirection: Axis.horizontal,
      //   itemCount: products.length,
      //   itemBuilder: (context, index) {
      //     var data = products[index];
      //     return GestureDetector(
      //       onTap: () {
      //         Navigator.of(context).pushNamed(
      //           "/product-details",
      //           arguments: {'productId': data.productId},
      //         );
      //       },
      //       child: ProductCard(
      //         model: data,
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
