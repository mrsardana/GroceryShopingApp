import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocerry_shopping_app/components/product_card.dart';
import 'package:grocerry_shopping_app/models/fav_product.dart';
import 'package:grocerry_shopping_app/pages/lock_page.dart';
import 'package:grocerry_shopping_app/providers.dart';
import 'package:grocerry_shopping_app/utils/shared_service.dart';
import 'package:grocerry_shopping_app/models/fav.dart';
import 'package:grocerry_shopping_app/widgets/widget_fav_item.dart';

class Favourite extends ConsumerStatefulWidget {
  const Favourite({super.key});

  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends ConsumerState<Favourite> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SharedService.isLoggedIn(),
      builder: (BuildContext context, AsyncSnapshot<bool> loginModel) {
        if (loginModel.hasData) {
          if (loginModel.data!) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Favourite"),
                automaticallyImplyLeading: false,
              ),
              body: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: _favList(ref),
                      flex: 1,
                    )
                  ],
                ),
              ),
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

  Widget _buildFavItems(List<FavProduct> favProducts, WidgetRef ref) {
    return Container(
      // height: 315,
      alignment: Alignment.centerLeft,
      child: GridView.count(
        crossAxisCount: 2,
        children: List.generate(favProducts.length, (index) {
          return FavItemWidget(
            model: favProducts[index],
            onItemRemove: (FavProduct model) {
              final favViewModel = ref.read(favItemsProvider.notifier);
              favViewModel.removeFavItem(model.product.productId);
            },
          );
        }),
      ),
    );
    // ListView.builder(
    //   shrinkWrap: true,
    //   physics: const ClampingScrollPhysics(),
    //   scrollDirection: Axis.vertical,
    //   itemCount: favProducts.length,
    //   itemBuilder: (context, index) {
    //     return FavItemWidget(
    //       model: favProducts[index],
    //       onItemRemove: (FavProduct model) {
    //         final favViewModel = ref.read(favItemsProvider.notifier);
    //         favViewModel.removeFavItem(model.product.productId);
    //       },
    //     );
    //   },
    // );
  }

  Widget _favList(WidgetRef ref) {
    final favState = ref.watch(favItemsProvider);
    if (favState.favModel == null) {
      return const LinearProgressIndicator();
    }

    if (favState.favModel!.products.isEmpty) {
      return const Center(
        child: Text("No Favourite Products"),
      );
    }
    return _buildFavItems(favState.favModel!.products, ref);
  }
}
