import 'package:flutter/material.dart';
import 'package:gogrocy/ui/shared/constants.dart' as constants;

class TitleText extends StatelessWidget {
  const TitleText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: constants.screenHeight * 0.05),
      child: Center(
          child: Text(
        'GOGROCY',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'Gilroy',
          fontSize: constants.LoginConfig.titleTextSize,
          fontWeight: FontWeight.bold,
        ),
      )),
    );
  }
}
