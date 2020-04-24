import 'package:flutter/material.dart';
import 'package:gogrocy/ui/views/home/carousel.dart';
import 'package:gogrocy/ui/views/home/category_list.dart';
import 'package:gogrocy/ui/views/home/grid_list.dart';
import 'package:gogrocy/ui/views/home/indicator.dart';
import 'package:gogrocy/ui/shared/constants.dart' as constants;
import 'package:gogrocy/ui/shared/colors.dart' as colors;


class Home extends StatelessWidget {
  final PageController controller = new PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Carousel(controller),
          Indicator(controller),
          Padding(
            padding: EdgeInsets.only(
                top: constants.HomePageConfig.lookingForPaddingTop,
                bottom: constants.HomePageConfig.lookingForPaddingBottom),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "What are you looking for?",
                      style: TextStyle(
                          fontFamily: 'Gilroy',
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.15),
                      child: Container(
                        width: constants.screenWidth * 0.52,
                        child: Text(
                          "Choose from the widest selection of local produce",
                          style: TextStyle(
                              fontFamily: 'Gilroy',
                              fontSize: 13,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    )
                  ],
                ),
                RawMaterialButton(
                  elevation: 0.0,
                  onPressed: () {},
                  fillColor: colors.VIEW_ALL_BUTTON_BACKGROUND,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: SizedBox(
                    width: constants.HomePageConfig.viewAllButtonWidth,
                    height: constants.HomePageConfig.viewAllButtonHeight,
                    child: Center(
                      child: Text(
                        'View All',
                        style: TextStyle(
                            color: colors.VIEW_ALL_BUTTON_TEXT,
                            fontSize: 13.0,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          CategoryList(),
          GridList(),
        ],
      ),
      //bottomNavigationBar: BottomNavBar(),
    );
  }
}
