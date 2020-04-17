import 'package:flutter/material.dart';
import 'package:gogrocy/ui/shared/constants.dart' as constants;

class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    constants.mediaQueryData = MediaQuery.of(context);
    return Container(
        color: Colors.white,
        width: constants.screenWidth,
        height: constants.AppBarConfig.appBarHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              color: Colors.white,
              width: constants.screenWidth/3,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 1),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Products from",
                          style: TextStyle(
                              fontSize:
                                  constants.AppBarConfig.addressTitleFontSize,
                              color: Colors.green,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Sector 9",
                          style: TextStyle(
                              fontSize: constants.AppBarConfig.addressFontSize,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: constants.screenWidth/3,
              child: Center(
                child: Text(
                  "GOGROCY",
                  style: TextStyle(
                      fontFamily: 'Gilroy',
                      fontSize: constants.AppBarConfig.titleFontSize,
                      fontWeight: FontWeight.w900),
                ),
              ),
            ),
            Container(
              width: constants.screenWidth/3,
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(
                      right: constants.AppBarConfig.searchIconPaddingRight),
                  child: Icon(Icons.search),
                ),
              ),
            ),
          ],
        ));
  }

  @override
  Size get preferredSize => Size.fromHeight(100);
}
