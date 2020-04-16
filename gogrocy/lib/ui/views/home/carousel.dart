import 'package:flutter/material.dart';
import 'package:gogrocy/ui/shared/constants.dart' as constants;

class Carousel extends StatelessWidget {
  final PageController controller;
  final List<String> assetLocations = [
    'assets/images/carousel_1.png',
    'assets/images/carousel_2.png',
    'assets/images/carousel_3.png'
  ];

  Carousel(this.controller);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        controller: controller,
        itemCount: assetLocations.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Image(
                image: AssetImage(assetLocations[index]), fit: BoxFit.contain),
          );
        },
      ),
      height: constants.HomePageConfig.carouselHeight,
    );
  }
}
