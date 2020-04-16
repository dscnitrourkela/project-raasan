import 'package:flutter/material.dart';
import 'package:gogrocy/ui/shared/constants.dart' as constants;
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Indicator extends StatelessWidget {
  final PageController controller;

  Indicator(this.controller);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(top: constants.HomePageConfig.indicatorPaddingTop),
      child: Center(
        child: SmoothPageIndicator(
            controller: controller,
            count: 3,
            effect: ExpandingDotsEffect(
              expansionFactor: constants.HomePageConfig.carouselIndicatorFactor,
              spacing: 8.0,
              radius: 4.0,
              dotWidth: constants.HomePageConfig.carouselIndicatorWidth,
              dotHeight: constants.HomePageConfig.carouselIndicatorHeight,
              paintStyle: PaintingStyle.fill,
              strokeWidth: 1.5,
              dotColor: Color.fromRGBO(95, 210, 0, 0.3),
              activeDotColor: Color.fromRGBO(95, 210, 0, 1),
            )),
      ),
    );
  }
}
