import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocerry_shopping_app/main.dart';
import 'package:grocerry_shopping_app/providers.dart';
import '../utils/shared_service.dart';
import 'lock_page.dart';

class MyAccount extends ConsumerStatefulWidget {
  const MyAccount({super.key});

  @override
  _MyAccountState createState() => _MyAccountState();
}

class OptionsList {
  String optionTitle;
  String optionSubTitle;
  IconData optionIcon;
  Function onTap;

  OptionsList(
    this.optionIcon,
    this.optionTitle,
    this.optionSubTitle,
    this.onTap,
  );
}

class _MyAccountState extends ConsumerState<MyAccount> {
  List<OptionsList> options = <OptionsList>[];

  String? fullName;

  @override
  void initState() {
    getLoginDetails();
    super.initState();
    options.add(
      OptionsList(
        Icons.shopping_cart_outlined,
        "Orders",
        "Check my orders",
        () {
          navigatorKey.currentState?.pushNamedAndRemoveUntil(
            "/order",
            (route) => true,
          );
        },
      ),
    );
    options.add(
      OptionsList(
        Icons.account_box_rounded,
        "My Details",
        "Check my details",
        () {
          navigatorKey.currentState?.pushNamedAndRemoveUntil(
            "/my-details",
            (route) => true,
          );
        },
      ),
    );
    options.add(
      OptionsList(
        Icons.power_settings_new_outlined,
        "Sign Out",
        "Sign out from app",
        () {
          SharedService.logout(context);
          ref.invalidate(cartItemsProvider);
          ref.invalidate(favItemsProvider);
          ref.invalidate(orderProvider);
        },
      ),
    );
  }

  @override
  Future<void> getLoginDetails() async {
    var loginDetails = await SharedService.loginDetails();
    fullName = loginDetails?.data.fullName.toString();
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
              body: _listView(context),
            );
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

  Widget _listView(BuildContext context) {
    return ListView(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(15, 15, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome, $fullName",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        ListView(
          physics: const ScrollPhysics(),
          padding: const EdgeInsets.all(8.0),
          shrinkWrap: true,
          children: [
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: _buildRow(options[0], 1),
            ),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: _buildRow(options[1], 1),
            ),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: _buildRow(options[2], 2),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildRow(OptionsList optionsList, int val) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          child: Icon(
            optionsList.optionIcon,
            size: 30,
          ),
        ),
        onTap: () {
          return optionsList.onTap();
        },
        title: Text(
          optionsList.optionTitle,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            optionsList.optionSubTitle,
            style: TextStyle(
              color: val == 1 ? Colors.green : Colors.redAccent,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        trailing: Icon(Icons.keyboard_arrow_right),
      ),
    );
  }
}
