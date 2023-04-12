import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocerry_shopping_app/config.dart';
import 'package:grocerry_shopping_app/models/cart.dart';
import 'package:grocerry_shopping_app/providers.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

class PaymentPage extends ConsumerStatefulWidget {
  const PaymentPage({super.key});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends ConsumerState<PaymentPage> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  String cardHolderName = "";
  String cardNumber = "";
  String cardExp = "";
  String cardCVC = "";
  @override
  Widget build(BuildContext context) {
    final orderPaymentModel = ref.watch(orderPaymentProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
      ),
      body: ProgressHUD(
        inAsyncCall: orderPaymentModel.isLoading,
        key: UniqueKey(),
        opacity: 0.3,
        child: Form(
          key: globalKey,
          child: _paymentUI(context, ref),
        ),
      ),
    );
  }

  _paymentUI(BuildContext context, WidgetRef ref) {
    final cartProvider = ref.watch(cartItemsProvider);

    if (cartProvider.cartModel != null) {
      return SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Total Amount",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "${Config.currency}${cartProvider.cartModel!.grandTodal.toStringAsFixed(2)}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.green,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            FormHelper.inputFieldWidgetWithLabel(
              context,
              "CardHolderName",
              "Card Holder",
              "Name on the Card",
              (onValidate) {
                if (onValidate.isEmpty) {
                  return "* Required";
                }
              },
              (onSaved) {
                cardHolderName = onSaved.toString().trim();
              },
              showPrefixIcon: true,
              prefixIcon: const Icon(Icons.face),
              borderRadius: 20,
              contentPadding: 10,
              labelFontSize: 18,
              fontSize: 16,
              paddingLeft: 5,
              paddingRight: 5,
              prefixIconPaddingLeft: 10,
              borderColor: Colors.grey.shade200,
              textColor: Colors.black,
              prefixIconColor: Colors.black,
              hintColor: Colors.black.withOpacity(.6),
              backgroundColor: Colors.grey.shade100,
              borderFocusColor: Colors.grey.shade200,
            ),
            const SizedBox(
              height: 15,
            ),
            FormHelper.inputFieldWidgetWithLabel(
              context,
              "CardNumber",
              "Card Number",
              "Card Number",
              (onValidate) {
                if (onValidate.isEmpty) {
                  return "* Required";
                }
              },
              (onSaved) {
                cardNumber = onSaved.toString().trim();
              },
              showPrefixIcon: true,
              prefixIcon: const Icon(Icons.credit_card),
              borderRadius: 20,
              contentPadding: 10,
              labelFontSize: 18,
              fontSize: 16,
              paddingLeft: 5,
              paddingRight: 5,
              prefixIconPaddingLeft: 10,
              borderColor: Colors.grey.shade200,
              textColor: Colors.black,
              prefixIconColor: Colors.black,
              hintColor: Colors.black.withOpacity(.6),
              backgroundColor: Colors.grey.shade100,
              borderFocusColor: Colors.grey.shade200,
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Flexible(
                  child: FormHelper.inputFieldWidgetWithLabel(
                    context,
                    "ValidExp",
                    "Valid Until",
                    "Month / Year",
                    (onValidate) {
                      if (onValidate.isEmpty) {
                        return "* Required";
                      }
                    },
                    (onSaved) {
                      cardExp = onSaved.toString().trim();
                    },
                    showPrefixIcon: true,
                    prefixIcon: const Icon(Icons.date_range),
                    borderRadius: 20,
                    contentPadding: 10,
                    labelFontSize: 18,
                    fontSize: 16,
                    paddingLeft: 5,
                    paddingRight: 5,
                    prefixIconPaddingLeft: 10,
                    borderColor: Colors.grey.shade200,
                    textColor: Colors.black,
                    prefixIconColor: Colors.black,
                    hintColor: Colors.black.withOpacity(.6),
                    backgroundColor: Colors.grey.shade100,
                    borderFocusColor: Colors.grey.shade200,
                  ),
                ),
                Flexible(
                  child: FormHelper.inputFieldWidgetWithLabel(
                    context,
                    "CVV",
                    "CVV",
                    "CVV",
                    (onValidate) {
                      if (onValidate.isEmpty) {
                        return "* Required";
                      }
                    },
                    (onSaved) {
                      cardCVC = onSaved.toString().trim();
                    },
                    showPrefixIcon: true,
                    prefixIcon: const Icon(Icons.password),
                    borderRadius: 20,
                    contentPadding: 10,
                    labelFontSize: 18,
                    fontSize: 16,
                    paddingLeft: 5,
                    paddingRight: 5,
                    prefixIconPaddingLeft: 10,
                    obscureText: true,
                    borderColor: Colors.grey.shade200,
                    textColor: Colors.black,
                    prefixIconColor: Colors.black,
                    hintColor: Colors.black.withOpacity(.6),
                    backgroundColor: Colors.grey.shade100,
                    borderFocusColor: Colors.grey.shade200,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Center(
              child: FormHelper.submitButton(
                "Proceed to Confirm",
                () async {
                  if (validateAndSave()) {
                    final orderPaymentModel =
                        ref.read(orderPaymentProvider.notifier);

                    await orderPaymentModel.processPayment(
                      cardHolderName,
                      cardNumber,
                      cardExp,
                      cardCVC,
                      cartProvider.cartModel!.grandTodal.toStringAsFixed(2),
                    );
                    final orderPaymentResponseModel =
                        ref.watch(orderPaymentProvider);

                    if (!orderPaymentResponseModel.isSuccess) {
                      FormHelper.showSimpleAlertDialog(
                        context,
                        Config.appName,
                        orderPaymentResponseModel.message,
                        "Ok",
                        () {
                          Navigator.of(context).pop();
                        },
                      );
                    } else {
                      // ref.invalidate(cartItemsProvider)
                      // ref.invalidate(orderProvider);
                      final orderModel = ref.watch(orderProvider.notifier);
                      final cartViewModel =
                          ref.read(cartItemsProvider.notifier);
                      cartViewModel.removeCartItem("productId", "empty_cart");
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          "/order-success", (route) => false);
                    }
                  }
                },
                btnColor: const Color.fromARGB(255, 23, 155, 69),
                borderColor: Colors.white,
                txtColor: Colors.white,
                borderRadius: 25,
                width: 250,
              ),
            )
          ],
        ),
      );
    }

    return const CircularProgressIndicator();
  }

  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
