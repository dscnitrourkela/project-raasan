import 'package:flutter/material.dart';
import 'package:gogrocy/core/models/orders.dart';
import 'package:gogrocy/ui/shared/constants.dart' as constants;
import 'package:gogrocy/ui/shared/colors.dart' as colors;

class OrderedProductList extends StatelessWidget {
  final String baseImgUrl =
      "https://res.cloudinary.com/gogrocy/image/upload/v1/";
  final List<Details> model;

  OrderedProductList(this.model);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print(model.length);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: model.length,
          itemBuilder: (context, index) {
            int eachItemCost = int.parse(model[index].price);
            int quantityOrdered = int.parse(model[index].orderQty);
            int totalCost = eachItemCost * quantityOrdered;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    flex: 4,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black26),
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      width: constants.CartConfig.imageWidth,
                      height: constants.CartConfig.imageHeight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          child: Image(
                            image: NetworkImage(
                                'https://res.cloudinary.com/gogrocy/image/upload/v1/' +
                                    model[index].image),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
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
                                  color: colors.primaryColor)),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Text("Qty " + quantityOrdered.toString()),
                          ),
                          orderStatus(int.parse(model[index].status))
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Align(
                        alignment: Alignment.topRight,
                        child: Column(
                          children: <Widget>[
                            Text(
                              '₹ $totalCost',
                              style: TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w500,
                                  color: colors.primaryColor),
                              textAlign: TextAlign.right,
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            );
          }),
    );
  }

  Widget orderStatus(int statusCode) {
    if (statusCode == 0) {
      return Text(
        "Approval pending",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 14, color: Colors.orange),
      );
    } else if (statusCode == 1) {
      return Text(
        "Order approved",
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: colors.primaryColor),
      );
    } else {
      return Text(
        "Order declined",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 14, color: Colors.red),
      );
    }
  }
}
