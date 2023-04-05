import 'package:flutter/material.dart';
import 'package:grocerry_shopping_app/config.dart';
import 'package:grocerry_shopping_app/models/fav_product.dart';
import 'package:grocerry_shopping_app/models/product.dart';

class FavItemWidget extends StatefulWidget {
  const FavItemWidget({
    Key? key,
    required this.model,
    this.onItemRemove,
  }) : super(key: key);

  final FavProduct model;
  final Function? onItemRemove;

  @override
  State<FavItemWidget> createState() => _FavItemWidgetState();
}

class _FavItemWidgetState extends State<FavItemWidget> {
  @override
  Widget build(BuildContext context) {
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
                visible: widget.model.product.calculateDiscount > 0,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Colors.green,
                    ),
                    child: Text(
                      "${widget.model.product.calculateDiscount}% OFF",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: widget.model.product.calculateDiscount <= 0,
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
                    widget.model.product.fullImagePath,
                    fit: BoxFit.cover,
                  ),
                  height: 100,
                  // width: MediaQuery.of(context).size.width,
                ),
                onTap: () {},
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 10),
                child: Text(
                  widget.model.product.productName,
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
                            "${Config.currency}${widget.model.product.productPrice.toString()}",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 12,
                              color: widget.model.product.calculateDiscount > 0
                                  ? Colors.red
                                  : Colors.black,
                              fontWeight: FontWeight.bold,
                              decoration:
                                  widget.model.product.calculateDiscount > 0
                                      ? TextDecoration.lineThrough
                                      : null,
                            ),
                          ),
                          Text(
                            (widget.model.product.calculateDiscount > 0)
                                ? " ${widget.model.product.productSalePrice.toString()}"
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
                      child: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 20,
                      ),
                      onTap: () {
                        widget.onItemRemove!(widget.model);
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
