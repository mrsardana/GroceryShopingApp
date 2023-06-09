import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocerry_shopping_app/config.dart';
import 'package:grocerry_shopping_app/models/fav.dart';
import 'package:grocerry_shopping_app/providers.dart';
import '../models/product.dart';

class ProductCard extends ConsumerStatefulWidget {
  final Product? model;
  const ProductCard({super.key, this.model});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends ConsumerState<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return _productCard(ref);
  }

  Widget _productCard(WidgetRef ref) {
    final favProvider = ref.watch(favItemsProvider);
    final favProduct = favProvider.favModel?.favItem;
    return Container(
      width: 150,
      decoration: const BoxDecoration(color: Colors.white),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Visibility(
                visible: widget.model!.calculateDiscount > 0,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Colors.green,
                    ),
                    child: Text(
                      "${widget.model!.calculateDiscount}% OFF",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: widget.model!.calculateDiscount <= 0,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    child: const Text(
                      "",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                child: SizedBox(
                  child: Image.network(
                    widget.model!.fullImagePath,
                    fit: BoxFit.cover,
                  ),
                  height: 100,
                  // width: MediaQuery.of(context).size.width,
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(
                    "/product-details",
                    arguments: {'productId': widget.model!.productId},
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 10),
                child: Text(
                  widget.model!.productName,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          Text(
                            "${Config.currency}${widget.model!.productPrice.toString()}",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 12,
                              color: widget.model!.calculateDiscount > 0
                                  ? Colors.red
                                  : Colors.black,
                              fontWeight: FontWeight.bold,
                              decoration: widget.model!.calculateDiscount > 0
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                          Text(
                            (widget.model!.calculateDiscount > 0)
                                ? " ${widget.model!.productSalePrice.toString()}"
                                : "",
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      child: Icon(
                        Icons.favorite,
                        color: favProduct != null
                            ? (favProduct.contains(widget.model!.productId))
                                ? Colors.red
                                : Colors.grey
                            : Colors.grey,
                        size: 20,
                      ),
                      onTap: () {
                        if (favProduct != null) {
                          if (favProduct.contains(widget.model!.productId)) {
                            final favViewModel =
                                ref.read(favItemsProvider.notifier);
                            favViewModel.removeFavItem(widget.model!.productId);
                          } else {
                            final favViewModel =
                                ref.read(favItemsProvider.notifier);
                            favViewModel.addFavItem(widget.model!.productId);
                          }
                        }
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
