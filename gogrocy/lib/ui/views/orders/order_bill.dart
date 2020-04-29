import 'package:flutter/material.dart';
import 'package:gogrocy/core/models/Orders.dart';
import 'package:gogrocy/core/models/cart_list.dart';
import 'package:gogrocy/ui/shared/colors.dart' as colors;

class OrderBill extends StatelessWidget {

  List<Details> orders;
  OrderBill(this.orders);
  String sumTotal;
  String delivery;

  @override
  Widget build(BuildContext context) {
    String grandTotal=totalCost(orders);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        child: Container(
          color: colors.CART_COUNTER_BACKGROUND,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22,vertical: 22,),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Particulars",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),),
                    Text("Price",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 10,),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: orders.length,
                    itemBuilder: (context,index){
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(orders[index].name),
                          Text("Rs "+(int.parse(orders[index].orderQty)*int.parse(orders[index].price)).toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                        ],
                      );
                    }),
                SizedBox(height: 10,),
                Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Sum total"),
                        Text("Rs "+ sumTotal,style: TextStyle(fontWeight: FontWeight.bold),)
                      ],

                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Delivery charges"),
                        Text("Rs $delivery",style: TextStyle(fontWeight: FontWeight.bold),)
                      ],

                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Grand Total", ),
                        Text("Rs "+(grandTotal).toString(),style:TextStyle(fontWeight: FontWeight.bold),)
                      ],

                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String totalCost(List<Details> list) {
    double totalCost = 0;
    for (int i = 0; i < list.length; i++) {
      totalCost += double.parse(list[i].price) * double.parse(list[i].orderQty);
    }
    if(totalCost>499){
      delivery=0.toString();
      sumTotal=totalCost.toString();
    }
    else {
      totalCost+=20;
      sumTotal=totalCost.toString();
      delivery="20";
    }
    return "₹ " + totalCost.toString();
  }

}
