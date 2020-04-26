import 'package:flutter/material.dart';
import 'package:gogrocy/core/models/product.dart';
import 'package:gogrocy/core/viewModels/product_detail_model.dart';
import 'package:gogrocy/ui/shared/constants.dart' as constants;
import 'package:gogrocy/ui/views/base_view.dart';
import 'package:gogrocy/ui/widgets/appbar.dart';
import 'package:gogrocy/ui/widgets/vertical_spaces.dart';

class ProductDetailView extends StatelessWidget {
  final Product product;

  ProductDetailView(this.product);

  @override
  Widget build(BuildContext context) {
    return BaseView<ProductDetailModel>(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: TopAppBar(),
          body: ListView(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.arrow_back_ios),
                title: Text(product.name),
                subtitle: Text(product.category),
                trailing: Text('₹ ' + product.price),
              ),
              VerticalSpaces.small20,
              FittedBox(
                fit: BoxFit.cover,
                child: Image(
                  image: NetworkImage(
                      'https://res.cloudinary.com/gogrocy/image/upload/v1/' +
                          product.image),
                ),
              ),
              VerticalSpaces.small10,
              SizedBox(
                width: 267 * constants.scaleRatio,
                height: constants.scaleRatio,
                child: Text(
                  product.description,
                  style: TextStyle(fontSize: 16 * constants.scaleRatio),
                ),
              ),
              VerticalSpaces.small10,
              Text('₹ ' + product.price),
              Center(
                child: SizedBox(
                  width: constants.SignUpConfig.raisedButtonWidth,
                  height: constants.SignUpConfig.raisedButtonHeight,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    color: Colors.black,
                    child: Text(
                      'Add to Cart',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () async {
                      var success = await model.addToCart(product.id);
                      if (success) {
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text('Added to Cart')));
                      } else {
                        Scaffold.of(context)
                            .showSnackBar(SnackBar(content: Text('ERROR')));
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
