import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:grocerry_shopping_app/api/api_service.dart';
import 'package:grocerry_shopping_app/config.dart';
import 'package:grocerry_shopping_app/pages/home_page.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isAsyncCallProcess = false;
  static final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool hidePassword = true;
  bool isRemember = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: ProgressHUD(
        child: Form(
          key: globalKey,
          child: _loginUI(),
        ),
        inAsyncCall: isAsyncCallProcess,
        opacity: 0.3,
        key: UniqueKey(),
      ),
    );
  }

  Widget _loginUI() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
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
                      "Welcome Back",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 34,
                          color: Color.fromARGB(255, 23, 155, 69)),
                    ),
                  ),
                  const Text(
                    "Login to your account",
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
            height: 25,
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
            height: 25,
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
            prefixIcon: const Icon(Icons.lock_open_outlined),
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
              icon:
                  Icon(hidePassword ? Icons.visibility_off : Icons.visibility),
            ),
            onChange: (val) {
              password = val;
            },
          ),
          const SizedBox(
            height: 25,
          ),
          Center(
            child: FormHelper.submitButton(
              "Login",
              () {
                if (validateAndSave()) {
                  // API call
                  setState(() {
                    isAsyncCallProcess = true;
                  });
                  APIService.loginUser(email!, password!).then(
                    (response) {
                      setState(() {
                        isAsyncCallProcess = false;
                      });
                      if (response) {
                        FormHelper.showSimpleAlertDialog(
                          context,
                          Config.appName,
                          "Login successfully",
                          "Ok",
                          () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              "/home",
                              (route) => false,
                            );
                          },
                        );
                      } else {
                        FormHelper.showSimpleAlertDialog(context,
                            Config.appName, "Invalid Email/Password", "Ok", () {
                          Navigator.of(context).pop();
                        });
                      }
                    },
                  );
                }
              },
              btnColor: const Color.fromARGB(255, 23, 155, 69),
              borderColor: const Color.fromARGB(255, 23, 155, 69),
              borderRadius: 25,
              width: 280,
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
                  const TextSpan(text: "Don't have an account? "),
                  TextSpan(
                    text: "Signup",
                    style: const TextStyle(
                      color: Color.fromARGB(255, 23, 155, 69),
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          "/regiseter",
                          (route) => false,
                        );
                      },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  bool validateAndSave() {
    final form = globalKey.currentState;

    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}
