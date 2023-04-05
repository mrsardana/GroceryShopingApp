import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocerry_shopping_app/providers.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import '../utils/shared_service.dart';
import 'lock_page.dart';

class MyAccount extends ConsumerStatefulWidget {
  const MyAccount({super.key});

  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends ConsumerState<MyAccount> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool isAsyncCallProcess = false;
  String? fullName;
  String? password;
  String? email;
  String? address;
  String? phone;
  bool hidePassword = true;
  @override
  void initState() {
    super.initState();
    getLoginDetails();
  }

  @override
  Future<void> getLoginDetails() async {
    var loginDetails = await SharedService.loginDetails();
    fullName = loginDetails?.data.fullName.toString();
    email = loginDetails?.data.email.toString();
    password = loginDetails?.data.token.toString();
    address = loginDetails?.data.address.toString();
    phone = loginDetails?.data.phone.toString();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SharedService.isLoggedIn(),
      builder: (BuildContext context, AsyncSnapshot<bool> loginModel) {
        if (loginModel.hasData) {
          getLoginDetails();
          if (loginModel.data!) {
            return Scaffold(
              backgroundColor: Colors.grey[200],
              body: ProgressHUD(
                child: Form(
                  key: globalKey,
                  child: _registerUI(context),
                ),
                inAsyncCall: isAsyncCallProcess,
                opacity: .3,
                key: UniqueKey(),
              ),
            );

            ///
            // Scaffold(
            //   appBar: AppBar(
            //     title: const Text("My Account"),
            //     automaticallyImplyLeading: false,
            //   ),
            //   body: Container(
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         const Text("My Account details to be do"),
            //         ElevatedButton(
            //             onPressed: () {
            //               SharedService.logout(context);
            //             },
            //             child: const Text("Logout"))
            //       ],
            //     ),
            //   ),
            // );
            ////
          } else {
            return const LockedPage();
          }
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _registerUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 60,
              ),
              Stack(
                children: [
                  Container(
                    height: 300,
                    child: Center(
                      child: Image.asset(
                        'lib/assets/myaccount.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(
                        height: 300,
                      ),
                      Container(
                        width: double.infinity,
                        child: const Text(
                          "My Account",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 34,
                              color: Color.fromARGB(255, 23, 155, 69)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              FormHelper.inputFieldWidget(
                context,
                "fullName",
                "Full Name",
                (onValidateVal) {
                  if (onValidateVal.isEmpty) {
                    return "* Required";
                  }
                  return null;
                },
                (onSavedVal) {
                  fullName = onSavedVal.toString().trim();
                },
                initialValue: fullName!,
                isReadonly: true,
                showPrefixIcon: true,
                prefixIcon: const Icon(Icons.face),
                borderRadius: 25,
                contentPadding: 15,
                fontSize: 14,
                prefixIconPaddingLeft: 10,
                borderColor: Colors.grey.shade400,
                borderFocusColor: Colors.grey.shade400,
                prefixIconColor: const Color.fromARGB(255, 23, 155, 69),
                textColor: Colors.black,
                hintColor: const Color.fromARGB(255, 23, 155, 69),
                backgroundColor: Colors.grey.shade400,
              ),
              const SizedBox(
                height: 10,
              ),
              FormHelper.inputFieldWidget(
                context,
                "email",
                "E-Mail",
                (onValidateVal) {
                  if (onValidateVal.isEmpty) {
                    return "* Required";
                  }
                  bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(onValidateVal);

                  if (!emailValid) {
                    return "Invalid E-Mail";
                  }
                  return null;
                },
                (onSavedVal) {
                  email = onSavedVal.toString().trim();
                },
                initialValue: email!,
                isReadonly: true,
                showPrefixIcon: true,
                prefixIcon: const Icon(Icons.email_outlined),
                borderRadius: 25,
                contentPadding: 15,
                fontSize: 14,
                prefixIconPaddingLeft: 10,
                borderColor: Colors.grey.shade400,
                borderFocusColor: Colors.grey.shade400,
                prefixIconColor: const Color.fromARGB(255, 23, 155, 69),
                textColor: Colors.black,
                hintColor: const Color.fromARGB(255, 23, 155, 69),
                backgroundColor: Colors.grey.shade400,
              ),
              const SizedBox(
                height: 10,
              ),
              FormHelper.inputFieldWidget(
                context,
                "password",
                "Password",
                (onValidateVal) {
                  if (onValidateVal.isEmpty) {
                    return "* Required";
                  }
                  return null;
                },
                (onSavedVal) {
                  password = onSavedVal.toString().trim();
                },
                initialValue: password!,
                isReadonly: true,
                showPrefixIcon: true,
                prefixIcon: const Icon(Icons.lock_outline),
                borderRadius: 25,
                contentPadding: 15,
                fontSize: 14,
                prefixIconPaddingLeft: 10,
                borderColor: Colors.grey.shade400,
                borderFocusColor: Colors.grey.shade400,
                prefixIconColor: const Color.fromARGB(255, 23, 155, 69),
                textColor: Colors.black,
                hintColor: const Color.fromARGB(255, 23, 155, 69),
                backgroundColor: Colors.grey.shade400,
                obscureText: hidePassword,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      hidePassword = !hidePassword;
                    });
                  },
                  icon: Icon(
                      hidePassword ? Icons.visibility_off : Icons.visibility),
                ),
                onChange: (val) {
                  password = val;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              FormHelper.inputFieldWidget(
                context,
                "address",
                "Address",
                (onValidateVal) {
                  if (onValidateVal.isEmpty) {
                    return "* Required";
                  }
                  return null;
                },
                (onSavedVal) {
                  address = onSavedVal.toString().trim();
                },
                initialValue: address!,
                isReadonly: true,
                showPrefixIcon: true,
                prefixIcon: const Icon(Icons.home_outlined),
                borderRadius: 25,
                contentPadding: 15,
                fontSize: 14,
                prefixIconPaddingLeft: 10,
                borderColor: Colors.grey.shade400,
                borderFocusColor: Colors.grey.shade400,
                prefixIconColor: const Color.fromARGB(255, 23, 155, 69),
                textColor: Colors.black,
                hintColor: const Color.fromARGB(255, 23, 155, 69),
                backgroundColor: Colors.grey.shade400,
              ),
              const SizedBox(
                height: 10,
              ),
              FormHelper.inputFieldWidget(
                context,
                "phone",
                "Mobile Phone",
                (onValidateVal) {
                  if (onValidateVal.isEmpty) {
                    return "* Required";
                  }
                  bool phoneValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(onValidateVal);

                  if (!phoneValid) {
                    return "Invalid Phone Number";
                  }
                  return null;
                },
                (onSavedVal) {
                  phone = onSavedVal.toString().trim();
                },
                initialValue: phone!,
                isReadonly: true,
                isNumeric: true,
                showPrefixIcon: true,
                prefixIcon: const Icon(Icons.phone),
                borderRadius: 25,
                contentPadding: 15,
                fontSize: 14,
                prefixIconPaddingLeft: 10,
                borderColor: Colors.grey.shade400,
                borderFocusColor: Colors.grey.shade400,
                prefixIconColor: const Color.fromARGB(255, 23, 155, 69),
                textColor: Colors.black,
                hintColor: const Color.fromARGB(255, 23, 155, 69),
                backgroundColor: Colors.grey.shade400,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    SharedService.logout(context);
                    ref.invalidate(cartItemsProvider);
                  },
                  child: const Text("Logout"))
            ],
          )
        ],
      ),
    );
  }
}
