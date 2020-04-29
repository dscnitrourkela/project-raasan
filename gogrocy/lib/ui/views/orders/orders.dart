import 'package:flutter/material.dart';
import 'package:gogrocy/core/enums/viewstate.dart';
import 'package:gogrocy/core/models/Orders.dart';
import 'package:gogrocy/core/models/order_details_arguments.dart';
import 'package:gogrocy/core/services/navigation_service.dart';
import 'package:gogrocy/core/viewModels/orderLis_model.dart';
import 'package:gogrocy/service_locator.dart';
import 'package:gogrocy/ui/views/base_view.dart';
import 'package:gogrocy/ui/widgets/appbar.dart';
import 'package:gogrocy/ui/shared/colors.dart' as colors;

class OrderView extends StatelessWidget {

  final NavigationService _navigationService = locator<NavigationService>();


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: TopAppBar(),
        body: BaseView<OrderViewModel>(
          onModelReady: (model) {
            model.getOrders();
          },
          builder: (context, model, child) {
            if (model.state == ViewState.Busy)
              return Center(
                child: CircularProgressIndicator(),
              );
            else {
              if (model.orders.empty)
                return Text("There are no orders available");
              else
                return Padding(
                  padding: const EdgeInsets.only(left: 16,right: 16,top: 16),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: <Widget>[
                            Image.asset("assets/images/orders.png"),
                            Padding(
                              padding: const EdgeInsets.only(left:8.0),
                              child: Text("Orders",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                            )
                          ],
                        ),
                      ),
                  Expanded(
                    child: ListView.separated(
                    itemCount: model.orders.result.bills.length,
                        separatorBuilder: (context, index) {
                          return Divider();
                        },
                        itemBuilder: (context, index) {
                          String time =
                              model.orders.result.bills[index].details[0].orderDate;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Order number " +
                                          model.orders.result.bills[index].billId,
                                      style: TextStyle(
                                          fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                    Text("Order placed on " +
                                        getDate(time) +
                                        " " +
                                        getMonth(time) +
                                        " " +
                                        getYear(time)),
                                    Text("Grand total " +
                                        totalCost(model
                                            .orders.result.bills[index].details)),
                                    Text(model
                                        .orders.result.bills[index].details.length
                                        .toString() +
                                        "  items")
                                  ],
                                ),
                                RawMaterialButton(
                                  elevation: 0.0,
                                  onPressed: () {
                                    _navigationService.navigateTo('orderDetails',arguments: OrderDetailsArguments(orders: model.orders,index: index));

                                  },
                                  fillColor: colors.VIEW_ALL_BUTTON_BACKGROUND,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Details',
                                      style: TextStyle(
                                          color: colors.VIEW_ALL_BUTTON_TEXT,
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                  )
                    ],
                  ),
                );
            }
          },
        ),
      ),
    );
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
}
