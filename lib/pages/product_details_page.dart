import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocerry_shopping_app/components/widget_col_expand.dart';
import 'package:grocerry_shopping_app/components/widget_custom_stepper.dart';
import 'package:grocerry_shopping_app/config.dart';
import 'package:grocerry_shopping_app/models/product.dart';
import 'package:grocerry_shopping_app/providers.dart';

class ProductDetailsPage extends ConsumerStatefulWidget {
  const ProductDetailsPage({super.key});

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends ConsumerState<ProductDetailsPage> {
  String productId = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Details"),
      ),
      body: SingleChildScrollView(
        child: _productDetails(ref),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    final Map? arguments = ModalRoute.of(context)!.settings.arguments as Map;

    if (arguments != null) {
      productId = arguments["productId"];
    }
    super.didChangeDependencies();
  }

  Widget _productDetails(WidgetRef ref) {
    final details = ref.watch(productDetailsProvider(productId));
    return details.when(
      data: (model) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_productDetailsUI(model!)],
        );
      },
      error: (_, __) => const Center(
        child: Text("error"),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _productDetailsUI(Product model) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: model.calculateDiscount > 0,
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  color: Colors.green,
                ),
                child: Text(
                  "${model.calculateDiscount}% OFF",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          Visibility(
            visible: model.calculateDiscount <= 0,
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
          SizedBox(
            child: Image.network(model.fullImagePath, fit: BoxFit.fitHeight),
            height: 200,
            width: MediaQuery.of(context).size.width,
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              model.productName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "${Config.currency}${model.productPrice.toString()}",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 20,
                      color: model.calculateDiscount > 0
                          ? Colors.red
                          : Colors.black,
                      fontWeight: FontWeight.bold,
                      decoration: model.calculateDiscount > 0
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                  Text(
                    (model.calculateDiscount > 0)
                        ? " ${model.productSalePrice.toString()}"
                        : "",
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Text(
                  "SHARE",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                  ),
                ),
                label: const Icon(
                  Icons.share,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ],
          ),
          Text(
            "Availability: ${model.stockStatus}",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              "Product Code: ${model.productSKU}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomStepper(
                lowerLimit: 1,
                upperLimit: 20,
                stepValue: 1,
                iconSize: 22,
                value: 1,
                onChanged: (value) {},
              ),
              TextButton.icon(
                onPressed: () {},
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 23, 155, 69))),
                icon: const Icon(
                  Icons.shopping_cart_rounded,
                  color: Colors.white,
                ),
                label: const Text(
                  "Add to Cart",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          CollapseExpand(
              title: "SHORT DESCRIPTION",
              content: model.productShortDescription),
          CollapseExpand(
              title: "PRODUCT DESCRIPTION", content: model.productDescription),
        ],
      ),
    );
  }
}
