import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:gogrocy/core/models/product.dart';
import 'package:gogrocy/core/viewModels/product_detail_model.dart';
import 'package:gogrocy/ui/shared/constants.dart' as constants;
import 'package:gogrocy/ui/views/base_view.dart';
import 'package:gogrocy/ui/widgets/appbar.dart';
import 'package:gogrocy/ui/widgets/vertical_spaces.dart';
import 'package:gogrocy/ui/shared/colors.dart' as colors;

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
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8, top: 4),
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 14,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              product.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 24),
                            ),
                            Text(
                              ((product.quantity != "2") ||
                                      (product.quantity != null)
                                  ? "In Stock"
                                  : "Not in stock"),
                              style: TextStyle(
                                  color: colors.PRIMARY_COLOR,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ],
                    ),
                    Text(
                      '₹ ' + product.price,
                      style: TextStyle(
                          color: colors.PRIMARY_COLOR,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                VerticalSpaces.small20,
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  child: SizedBox(
                    width: constants.screenWidth,
                    height: constants.screenHeight * 0.4,
                    child: Image(
                      image: NetworkImage(
                        'https://res.cloudinary.com/gogrocy/image/upload/v1/' +
                            product.image,
                      ),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  product.name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Text(
                  product.description,
                  style: TextStyle(),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: FlatButton.icon(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    color: colors.VIEW_ALL_BUTTON_BACKGROUND,
                    icon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.shopping_cart,
                        color: colors.PRIMARY_COLOR,
                      ),
                    ),
                    label: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Add to Cart',
                        style: TextStyle(
                            color: colors.PRIMARY_COLOR,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                    onPressed: () async {
                      var success = await model.addToCart(product.id);
                      if (success) {
                        Flushbar(
                          messageText: Text(
                            "Added to cart",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                          duration: Duration(seconds: 2),
                          flushbarStyle: FlushbarStyle.FLOATING,
                          icon: Icon(
                            Icons.check,
                            color: colors.PRIMARY_COLOR,
                          ),
                          barBlur: 0.9,
                          margin: EdgeInsets.all(8.0),
                          borderRadius: 8.0,
                          backgroundColor: Colors.white,
                          boxShadows: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 0.0),
                              blurRadius: 5.0,
                            )
                          ],
                        )..show(context);
                      } else {
                        Flushbar(
                          messageText: Text(
                            "Unable to add to cart",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                          duration: Duration(seconds: 2),
                          flushbarStyle: FlushbarStyle.FLOATING,
                          icon: Icon(
                            Icons.error,
                            color: Colors.red,
                          ),
                          barBlur: 0.9,
                          margin: EdgeInsets.all(8.0),
                          borderRadius: 8.0,
                          backgroundColor: Colors.white,
                          boxShadows: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 0.0),
                              blurRadius: 5.0,
                            )
                          ],
                        )..show(context);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
