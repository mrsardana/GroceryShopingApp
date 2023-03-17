import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:grocerry_shopping_app/api/api_service.dart';
import 'package:http/http.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

import '../config.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  static final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool isAsyncCallProcess = false;
  String? fullName;
  String? password;
  String? confirmPassword;
  String? email;
  String? address;
  String? phone;
  bool hidePassword = true;
  bool hideConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
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
              Stack(
                children: [
                  Center(
                    child: Image.asset(
                      'lib/assets/il_background.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(
                        height: 325,
                      ),
                      Container(
                        width: double.infinity,
                        child: const Text(
                          "Register",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 34,
                              color: Color.fromARGB(255, 23, 155, 69)),
                        ),
                      ),
                      const Text(
                        "Create a new account",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 19,
                            color: Color.fromARGB(255, 119, 124, 121)),
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
                "confirmPassword",
                "Confirm Password",
                (onValidateVal) {
                  if (onValidateVal.isEmpty) {
                    return "* Required";
                  }
                  if (onValidateVal != password) {
                    return "Confirm Password not matched";
                  }
                  return null;
                },
                (onSavedVal) {
                  confirmPassword = onSavedVal.toString().trim();
                },
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
                obscureText: hideConfirmPassword,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      hideConfirmPassword = !hideConfirmPassword;
                    });
                  },
                  icon: Icon(hideConfirmPassword
                      ? Icons.visibility_off
                      : Icons.visibility),
                ),
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
                  return null;
                },
                (onSavedVal) {
                  phone = onSavedVal.toString().trim();
                },
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
              const SizedBox(
                height: 10,
              ),
              Center(
                child: FormHelper.submitButton(
                  "Signup",
                  () {
                    if (validateSave()) {
                      // API Request
                      setState(() {
                        isAsyncCallProcess = true;
                      });
                      APIService.registerUser(
                              fullName!, email!, password!, address!, phone!)
                          .then(
                        (response) => {
                          setState(() {
                            isAsyncCallProcess = false;
                          }),
                          if (response)
                            {
                              FormHelper.showSimpleAlertDialog(
                                  context,
                                  Config.appName,
                                  "Registration completed successfully",
                                  "Ok", () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                  "/login",
                                  (route) => false,
                                );
                              }),
                              globalKey.currentState?.reset(),
                            }
                          else
                            {
                              FormHelper.showSimpleAlertDialog(
                                  context,
                                  Config.appName,
                                  "This Email already registered",
                                  "Ok", () {
                                Navigator.of(context).pop();
                              })
                            }
                        },
                      );
                    }
                  },
                  btnColor: const Color.fromARGB(255, 23, 155, 69),
                  borderColor: const Color.fromARGB(255, 23, 155, 69),
                  borderRadius: 25,
                  width: 250,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                        color: Color.fromARGB(255, 119, 124, 121),
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(text: "Already have an account?"),
                      TextSpan(
                        text: " Login",
                        style: const TextStyle(
                          color: Color.fromARGB(255, 23, 155, 69),
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              "/login",
                              (route) => false,
                            );
                          },
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  bool validateSave() {
    final form = globalKey.currentState;

    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}
