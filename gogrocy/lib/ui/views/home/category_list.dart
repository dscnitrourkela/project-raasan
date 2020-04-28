import 'package:flutter/material.dart';
import 'package:gogrocy/ui/shared/constants.dart' as constants;
import 'package:gogrocy/ui/shared/colors.dart' as colors;

class CategoryList extends StatelessWidget {
  final List<String> categoryTitle = [
    "Pulses",
    "Groceries",
    "Packed Foods",
    "Toiletries"
  ];

  final List<String> assetPaths = [
    "assets/images/pulses.png",
    "assets/images/grocery.png",
    "assets/images/packed.png",
    "assets/images/toiletries.png"
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: constants.HomePageConfig.categoryListHeight,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: categoryTitle.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: constants.HomePageConfig.categoryListWidth,
                height: constants.HomePageConfig.categoryListHeight,
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        child: Container(
                          width: constants.HomePageConfig.categoryBoxWidth,
                          height: constants.HomePageConfig.categoryBoxHeight,
                          color: colors.categoryListBox,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          categoryTitle[index],
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Align(
                        alignment: Alignment(0,-1),
                        child: SizedBox(
                          height: constants.HomePageConfig.categoryImageHeight,
                          width: constants.HomePageConfig.categoryImageWidth,
                          child: Image(
                            image: AssetImage(assetPaths[index]),
                            fit: BoxFit.contain,
                          ),
                        ))
                  ],
                ),
              ),
            );
          }),
    );
  }
}
