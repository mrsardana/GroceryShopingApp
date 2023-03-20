import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocerry_shopping_app/models/pagination.dart';
import 'package:grocerry_shopping_app/models/slider.dart';
import 'package:grocerry_shopping_app/providers.dart';

class HomeSliderWidget extends ConsumerWidget {
  const HomeSliderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Color.fromARGB(255, 206, 212, 208),
      child: _sliderList(ref),
    );
  }

  Widget _sliderList(WidgetRef ref) {
    final sliders = ref.watch(
      slidersProvider(
        PaginationModel(
          page: 1,
          pageSize: 10,
        ),
      ),
    );
    return sliders.when(
      data: (list) {
        return imageCarousel(list!);
      },
      error: (_, __) => const Center(
        child: Text("error"),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget imageCarousel(
    List<SliderModel> sliderList,
  ) {
    return CarouselSlider(
      items: sliderList.map((model) {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(model.fullImagePath),
              fit: BoxFit.contain,
            ),
          ),
        );
      }).toList(),
      options: CarouselOptions(
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 1.99,
        autoPlayCurve: Curves.decelerate,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: const Duration(microseconds: 800),
        viewportFraction: 0.8,
      ),
    );
  }
}
