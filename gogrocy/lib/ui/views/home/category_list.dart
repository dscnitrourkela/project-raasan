import 'package:flutter/material.dart';
import 'package:gogrocy/ui/shared/constants.dart' as constants;

class CategoryList extends StatelessWidget {
  List<String> categoryTitle = [
    "Pulses",
    "Groceries",
    "Packed Foods",
    "Toiletries"
  ];

  List<String> assetPaths = [
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
                          width: constants.HomePageConfig.categotyBoxWidth,
                          height: constants.HomePageConfig.categoryBoxHeight,
                          color: Color.fromRGBO(196, 196, 196, 0.3),
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
                        alignment: Alignment(0, -3),
                        child: Image(
                            image: AssetImage(assetPaths[index]),
                        fit: BoxFit.contain,))
                  ],
                ),
              ),
            );
          }),
    );
  }
}
