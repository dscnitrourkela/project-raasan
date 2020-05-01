import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class CustomSnackbar extends StatelessWidget {
  String message;
  IconData icon;
  BuildContext passedContext;
  Color iconColor;

  CustomSnackbar({this.message, this.icon, this.passedContext, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Flushbar(
      messageText: Text(
        message,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
      ),
      duration: Duration(seconds: 2),
      flushbarStyle: FlushbarStyle.FLOATING,
      icon: Icon(
        icon,
        color: iconColor,
      ),
      barBlur: 0.9,
      margin: EdgeInsets.all(8.0),
      borderRadius: 8.0,
      backgroundColor: Colors.white,
      boxShadows: [
        BoxShadow(
          color: Colors.grey,
          offset: Offset(0.0, 0.0),
          blurRadius: 5.0,
        )
      ],
    )..show(passedContext);
  }
}
