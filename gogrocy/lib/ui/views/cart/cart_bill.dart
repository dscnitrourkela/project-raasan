import 'package:flutter/material.dart';
import 'package:gogrocy/core/models/cart_list.dart';
import 'package:gogrocy/ui/shared/colors.dart' as colors;

class CartBill extends StatelessWidget {

  CartDataModel cartList;
  CartBill(this.cartList);

  @override
  Widget build(BuildContext context) {
    int delivery=cartList.sum>499?0:20;
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
                    itemCount: cartList.cart.length,
                    itemBuilder: (context,index){
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(cartList.cart[index].name),
                          Text("Rs "+(int.parse(cartList.cart[index].quantityOrdered)*int.parse(cartList.cart[index].price)).toString(),style: TextStyle(fontWeight: FontWeight.bold),),
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
                        Text("Rs "+ cartList.sum.toString(),style: TextStyle(fontWeight: FontWeight.bold),)
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
                        Text("Rs "+(cartList.sum+delivery).toString(),style:TextStyle(fontWeight: FontWeight.bold),)
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
}
