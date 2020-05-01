import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gogrocy/core/services/navigation_service.dart';
import 'package:gogrocy/core/services/shared_prefs.dart';
import 'package:gogrocy/service_locator.dart';
import 'package:gogrocy/ui/shared/constants.dart' as constants;

class SecondaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final SharedPrefsService sharedPrefsService = locator<SharedPrefsService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final String title;

  SecondaryAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    constants.mediaQueryData = MediaQuery.of(context);
    return Container(
        color: Colors.white,
        width: constants.screenWidth,
        height: constants.AppBarConfig.appBarHeight,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            Expanded(
              child: Container(
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(
                        fontFamily: 'Gilroy',
                        fontSize: constants.AppBarConfig.titleFontSize,
                        fontWeight: FontWeight.w900),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  @override
  Size get preferredSize => Size.fromHeight(100);
}
