import 'package:flutter/material.dart';
import 'package:gogrocy/core/enums/viewstate.dart';
import 'package:gogrocy/core/viewModels/allProducts_model.dart';
import 'package:gogrocy/ui/views/base_view.dart';
import 'package:gogrocy/ui/shared/constants.dart' as constants;

class GridList extends StatelessWidget {
  final ScrollController _scrollController = new ScrollController();
  final String baseImgUrl =
      "https://res.cloudinary.com/gogrocy/image/upload/v1/";

  @override
  Widget build(BuildContext context) {
    return BaseView<AllProductsModel>(
      onModelReady: (model) {
        model.getAllProducts();
      },
      builder: (context, model, child) => GridView.builder(
          itemCount: 10,
          shrinkWrap: true,
          controller: _scrollController,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 1, crossAxisSpacing: 8.0),
          itemBuilder: (context, index) {
            // ignore: missing_return
            if (model.state == ViewState.Idle) if (model.state ==
                ViewState.Busy)
              return CircularProgressIndicator();
            else
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: constants.HomePageConfig.productGridWidth,
                  height: constants.HomePageConfig.productGridHeight,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Column(
                    children: <Widget>[
                      Flexible(
                          flex: 4,
                          child: Image(
                            image: NetworkImage(
                                'https://res.cloudinary.com/gogrocy/image/upload/v1/' +
                                    model.allProducts[index + 1].image),
                            fit: BoxFit.fitWidth,
                          )),
                      Flexible(
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Flexible(
                                flex: 7,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    model.allProducts[index + 1].name,
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '₹' + model.allProducts[index + 1].price,
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      color: Color(0xff5FD900),
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              flex: 3,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
          }),
    );
  }
}
