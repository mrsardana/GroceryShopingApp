import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocerry_shopping_app/api/api_service.dart';
import 'package:grocerry_shopping_app/application/notifier/cart_notifier.dart';
import 'package:grocerry_shopping_app/application/notifier/fav_notifier.dart';
import 'package:grocerry_shopping_app/application/notifier/products_filter_notifier.dart';
import 'package:grocerry_shopping_app/application/notifier/products_notifier.dart';
import 'package:grocerry_shopping_app/application/state/cart_state.dart';
import 'package:grocerry_shopping_app/application/state/fav_state.dart';
import 'package:grocerry_shopping_app/application/state/product_state.dart';
import 'package:grocerry_shopping_app/models/category.dart';
import 'package:grocerry_shopping_app/models/pagination.dart';
import 'package:grocerry_shopping_app/models/product.dart';
import 'package:grocerry_shopping_app/models/product_filter.dart';
import 'package:grocerry_shopping_app/models/slider.dart';

final categoriesProvider =
    FutureProvider.family<List<Category>?, PaginationModel>(
  (ref, paginationModel) {
    final apiRepository = ref.watch(apiService);
    return apiRepository.getCategories(
      paginationModel.page,
      paginationModel.pageSize,
    );
  },
);
final homeProductProvider =
    FutureProvider.family<List<Product>?, ProductFilterModel>(
  (ref, productFilterModel) {
    final apiRepository = ref.watch(apiService);

    return apiRepository.getProducts(productFilterModel);
  },
);

final productsFilterProvider =
    StateNotifierProvider<ProductsFilterNotifier, ProductFilterModel>(
  (ref) => ProductsFilterNotifier(),
);

final productsNotifierProvider =
    StateNotifierProvider<ProductsNotifier, ProductsState>(
  (ref) => ProductsNotifier(
    ref.watch(apiService),
    ref.watch(productsFilterProvider),
  ),
);

final slidersProvider =
    FutureProvider.family<List<SliderModel>?, PaginationModel>(
  (ref, paginationModel) {
    final sliderRepo = ref.watch(apiService);
    return sliderRepo.getSliders(
        paginationModel.page, paginationModel.pageSize);
  },
);

final productDetailsProvider = FutureProvider.family<Product?, String>(
  (ref, productId) {
    final apiRepository = ref.watch(apiService);
    return apiRepository.getProductDetails(productId);
  },
);

final cartItemsProvider = StateNotifierProvider<CartNotifier, CartState>(
  (ref) => CartNotifier(
    ref.watch(apiService),
  ),
);

final favItemsProvider = StateNotifierProvider<FavNotifier, FavState>(
  (ref) => FavNotifier(
    ref.watch(apiService),
  ),
);
