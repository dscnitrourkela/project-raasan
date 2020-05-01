import 'package:flutter/material.dart';
import 'package:gogrocy/core/models/ProductsByCity.dart';
import 'package:gogrocy/service_locator.dart';
import 'package:gogrocy/ui/shared/constants.dart' as constants;
import 'package:gogrocy/core/services/navigation_service.dart';

class CategoryProductList extends StatelessWidget {
  final NavigationService _navigationService = locator<NavigationService>();
  final List<Result> productList;

  CategoryProductList(this.productList);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
          itemCount: productList.length,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 1, crossAxisSpacing: 2),
          itemBuilder: (context, index) {
            // ignore: missing_return
            return InkWell(
              onTap: () {
                _navigationService.navigateTo('product',
                    arguments: productList[index]);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Column(
                    children: <Widget>[
                      Flexible(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 8, left: 8, right: 8),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.0)),
                              child: Container(
                                color: Colors.black12,
                                height:
                                    constants.HomePageConfig.productGridHeight *
                                        4 /
                                        6,
                                width: double.maxFinite,
                                child: Image(
                                  image: NetworkImage(
                                      'https://res.cloudinary.com/gogrocy/image/upload/v1/' +
                                          productList[index].image),
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                          )),
                      Flexible(
                        flex: 2,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Flexible(
                                  flex: 8,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, top: 4, bottom: 4),
                                    child: Text(
                                      productList[index].name,
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w500),
                                      maxLines: 2,
                                    ),
                                  )),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, top: 4, bottom: 4),
                                  child: Text(
                                    '₹' + productList[index].price,
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        color: Color(0xff5FD900),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                flex: 7,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
