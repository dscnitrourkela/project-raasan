import 'package:flutter/material.dart';
import 'package:gogrocy/core/enums/viewstate.dart';
import 'package:gogrocy/core/services/navigation_service.dart';
import 'package:gogrocy/core/viewModels/allProducts_model.dart';
import 'package:gogrocy/service_locator.dart';
import 'package:gogrocy/ui/views/base_view.dart';
import 'package:gogrocy/ui/shared/constants.dart' as constants;

class GridList extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  final String baseImgUrl =
      "https://res.cloudinary.com/gogrocy/image/upload/v1/";
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return BaseView<AllProductsModel>(
      onModelReady: (model) {
        if (model.hasConnection) model.getAllProducts();
      },
      builder: (context, model, child) => GridView.builder(
          itemCount: 100,
          shrinkWrap: true,
          controller: _scrollController,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 1, crossAxisSpacing: 8.0),
          itemBuilder: (context, index) {
            // ignore: missing_return
            if (model.state == ViewState.Busy)
              return SizedBox(
                  width: 20.0,
                  height: 20.0,
                  child: Center(child: CircularProgressIndicator()));
            else {
              return InkWell(
                onTap: () {
                  _navigationService.navigateTo('product',
                      arguments: model.allProducts[index]);
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
                            child: SizedBox(
                              height:
                                  constants.HomePageConfig.productGridHeight *
                                      4 /
                                      6,
                              child: Image(
                                image: NetworkImage(
                                    'https://res.cloudinary.com/gogrocy/image/upload/v1/' +
                                        model.allProducts[index].image),
                                fit: BoxFit.fitWidth,
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
                                          left: 4, top: 4, bottom: 4),
                                      child: Text(
                                        model.allProducts[index].name,
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w500),
                                        maxLines: 2,
                                      ),
                                    )),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 4, top: 4, bottom: 4),
                                    child: Text(
                                      '₹' + model.allProducts[index].price,
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
            }
          }),
    );
  }
}
