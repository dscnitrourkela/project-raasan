import 'package:flutter/material.dart';
import 'package:gogrocy/core/enums/viewstate.dart';
import 'package:gogrocy/core/viewModels/allProducts_model.dart';
import 'package:gogrocy/ui/views/base_view.dart';
import 'package:gogrocy/ui/views/category/product_list.dart';
import 'package:gogrocy/ui/widgets/appbars/main_appbar.dart';

class AllProductsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: MainAppBar(),
          body: BaseView<AllProductsModel>(onModelReady: (model) {
            model.getAllProducts();
          }, builder: (context, model, child) {
            if (model.state == ViewState.Idle) {
              if (model.allProducts.result.length != 0) {
                return Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("All Products",
                          style: TextStyle(
                              fontSize: 21.0, fontWeight: FontWeight.w500)),
                    ),
                    CategoryProductList(model.allProducts.result)
                  ],
                );
              } else
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 80,
                        child: Image(
                            image: AssetImage('assets/images/no_products.png')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "No products are currently available",
                          style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                );
            } else
              return Center(
                child: CircularProgressIndicator(),
              );
          })),
    );
  }
}
