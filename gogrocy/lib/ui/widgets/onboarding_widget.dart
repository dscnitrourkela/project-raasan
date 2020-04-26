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
        itemCount: 3,
        itemBuilder: (context, position) {
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment(-2.0, 0.0),
                  child: Image.asset(
                    'assets/images/woman.png',
                    width: constants.OnBoardingConfig.illustrationWidth,
                    height: constants.OnBoardingConfig.illustrationHeight,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 0.021 * constants.screenHeight),
                  child: SizedBox(
                    width: 203 * (2.550/2.002),
                    height: 40.0 * (2.550/2.002),
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
