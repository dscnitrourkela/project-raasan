import 'package:flutter/material.dart';
import 'package:gogrocy/core/enums/viewstate.dart';
import 'package:gogrocy/core/models/orders.dart';
import 'package:gogrocy/core/models/cart_list.dart';
import 'package:gogrocy/core/viewModels/cart_view_model.dart';
import 'package:gogrocy/ui/views/base_view.dart';
import 'package:gogrocy/ui/shared/constants.dart' as constants;
import 'package:gogrocy/ui/shared/colors.dart' as colors;
import 'package:gogrocy/ui/widgets/cart_counter.dart';

class OrderedProductList extends StatelessWidget {
  final String baseImgUrl =
      "https://res.cloudinary.com/gogrocy/image/upload/v1/";
  List<Details> model;

  OrderedProductList(this.model);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: model.length,
          itemBuilder: (context, index) {
            int eachItemCost = int.parse(model[index].price);
            int quantityOrdered =
            int.parse(model[index].orderQty);
            int totalCost = eachItemCost * quantityOrdered;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    flex: 3,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black26),
                          borderRadius:
                          BorderRadius.all(Radius.circular(10.0))),
                      width: constants.CartConfig.imageWidth,
                      height: constants.CartConfig.imageHeight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image(
                          image: NetworkImage(
                              'https://res.cloudinary.com/gogrocy/image/upload/v1/' +
                                  model[index].image),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(model[index].name,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 14.0)),
                          Text('₹' + model[index].price,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.0,
                                  color: colors.PRIMARY_COLOR)),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Text("Qty "+ quantityOrdered.toString()),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          '₹ $totalCost',
                          style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.w500,
                              color: colors.PRIMARY_COLOR),
                          textAlign: TextAlign.right,
                        )),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
