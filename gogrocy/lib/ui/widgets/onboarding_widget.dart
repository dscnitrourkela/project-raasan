import 'package:flutter/material.dart';
import 'package:gogrocy/ui/shared/constants.dart' as constants;

class OnBoardingWidget extends StatelessWidget {
  final PageController controller;

  OnBoardingWidget(this.controller);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView.builder(
        physics: BouncingScrollPhysics(),
        controller: controller,
        itemCount: 1,
        itemBuilder: (context, position) {
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment(-0.500, 0.0),
                  child: Image.asset(
                    'assets/images/woman.png',
                    width: constants.OnBoardingConfig.illustrationWidth,
                    height: constants.OnBoardingConfig.illustrationHeight,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 0.021 * constants.screenHeight),
                  child: SizedBox(
                    width: 0.493 * constants.screenWidth,
                    height: 0.049 * constants.screenHeight,
                    child: Text(
                      'The widest selection of home essentials just a few taps away',
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        height: 1.15,
                        fontSize: constants.OnBoardingConfig.footerTextSize,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
