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
                    width: constants.LoginConfig.loginIllustrationWidth,
                    height: constants.LoginConfig.loginIllustrationHeight,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 18.0),
                  child: SizedBox(
                    width: 300.0,
                    child: Text(
                      'The widest selection of home essentials just a few taps away',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        height: 1.13,
                        fontSize: 20.0,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
