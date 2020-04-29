import 'package:flutter/material.dart';
import 'package:gogrocy/core/models/Orders.dart';
import 'package:gogrocy/ui/views/orders/order_bill.dart';
import 'package:gogrocy/ui/views/orders/ordered_product_list.dart';
import 'package:gogrocy/ui/widgets/appbar.dart';
import 'package:gogrocy/ui/shared/colors.dart' as colors;

class OrderDetailsView extends StatelessWidget {
  Orders orders;
  int index;

  OrderDetailsView({this.orders, this.index});

  @override
  Widget build(BuildContext context) {
    String time = orders.result.bills[index].details[0].orderDate;
    return SafeArea(
        child: Scaffold(
      appBar: TopAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            orderStatus(int.parse(orders.result.bills[index].details[0].status)),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Order number " + orders.result.bills[index].billId,
                        style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text("Order placed on " +
                          getDate(time) +
                          " " +
                          getMonth(time) +
                          " " +
                          getYear(time)),
                      Text("Grand total " +
                          totalCost(orders.result.bills[index].details)),
                      Text(orders.result.bills[index].details.length.toString() +
                          "  items")
                    ],
                  ),
                ],
              ),
            ),
            OrderedProductList(orders.result.bills[index].details),
            OrderBill(orders.result.bills[index].details)
          ],
        ),
      ),
    ));
  }

  String getDate(String time) {
    return time.substring(8, 10);
  }

  String getMonth(String time) {
    String monthNo = time.substring(5, 7);
    print(monthNo);
    switch (monthNo) {
      case "01":
        return "January";
      case "02":
        return "February";
      case "03":
        return "March";
      case "04":
        return "April";
      case "05":
        return "May";
      case "06":
        return "June";
      case "07":
        return "July";
      case "08":
        return "August";
      case "09":
        return "September";
      case "10":
        return "October";
      case "11":
        return "November";
      case "12":
        return "December";
      default:
        return "Invalid month";
    }
  }

  String getYear(String time) {
    return time.substring(0, 4);
  }

  String totalCost(List<Details> list) {
    double totalCost = 0;
    for (int i = 0; i < list.length; i++) {
      totalCost += double.parse(list[i].price) * double.parse(list[i].orderQty);
    }
    totalCost = totalCost > 499 ? totalCost : totalCost + 20;
    return "₹ " + totalCost.toString();
  }

  Widget orderStatus(int statusCode){
    if(statusCode==0){
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 16),
        child: (Row(
          children: <Widget>[
            Icon(
              Icons.access_time,
              color: Colors.orange,
              size: 50,
            ),
            Text("   Your order is not approved yet",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)
          ],
        )),
      );
    }
    if(statusCode==1){
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 16),
        child: (Row(
          children: <Widget>[
            Icon(
              Icons.check,
              color: colors.PRIMARY_COLOR,
              size: 50,
            ),
            Text("   Your order is approved",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)
          ],
        )),
      );
    }
    if(statusCode==-1){
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 16),
        child: (Row(
          children: <Widget>[
            Icon(
              Icons.error,
              color: Colors.red,
              size: 50,
            ),
            Text("   Your order has been declined",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)
          ],
        )),
      );
    }
  }
}
