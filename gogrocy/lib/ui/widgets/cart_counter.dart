import 'package:flutter/material.dart';
import 'package:gogrocy/core/enums/viewstate.dart';
import 'package:gogrocy/core/models/cart_list.dart';
import 'package:gogrocy/core/viewModels/cart_view_model.dart';
import 'package:gogrocy/ui/shared/constants.dart' as constants;
import 'package:gogrocy/ui/shared/colors.dart' as colors;

class CartCounter extends StatefulWidget {

  int maxQuantity;
  int orderedQuantity;
  CartViewModel model;
  int index;

  CartCounter ({ @required this.maxQuantity, @required this.orderedQuantity, @required this.model, @required this.index }): super();

  @override
  _CartCounterState createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {

  double buttonWidth=constants.CartConfig.counterWidth/3;
  double buttonHeight=constants.CartConfig.counterHeight;

  int count=0;

  @override
  Widget build(BuildContext context) {

    Cart cart=widget.model.cartList.cart[widget.index];
    int orderedQuanitity=int.parse(cart.quantity_ordered);
    return Container(
      padding: new EdgeInsets.all(4.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          new SizedBox(
            width: buttonWidth,
            height: buttonHeight,
            child: FlatButton(
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(3.0),
                  side: BorderSide(color:colors.CART_COUNTER_BACKGROUND)),
              color: colors.CART_COUNTER_BACKGROUND,
              textColor: Colors.black,
              padding: EdgeInsets.all(0.0),
              onPressed: () {
                setState(() {
                  print(orderedQuanitity+count);
                  if(orderedQuanitity+count>0){
                    count--;
                    print("Decreased by $count");
                    widget.model.getCartList(product_id: cart.product_id,quantity: count.toString());
                    count=0;
                  }

                });
              },
              child: Icon(Icons.remove,size: 16,)
            ),
          ),
          new Container(
            padding: EdgeInsets.all(4.0),
            child: widget.model.state==ViewState.Idle?Text(
              (orderedQuanitity+count).toString(),

            ):SizedBox(width:7,height: 7,child: Center(child: CircularProgressIndicator(strokeWidth: 1.5,)))
          ),
          new SizedBox(
            width: buttonWidth,
            height: buttonHeight,
            child: FlatButton(
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(3.0),
                  side: BorderSide(color:colors.CART_COUNTER_BACKGROUND)),
              color: colors.CART_COUNTER_BACKGROUND,
              textColor: Colors.black,
              padding: EdgeInsets.all(2.0),
              onPressed: () {
                setState(() {
                  if(orderedQuanitity+count<widget.maxQuantity){count++;
                  print("Increased by $count");
                  widget.model.getCartList(product_id: cart.product_id,quantity: count.toString());
                  count=0;
                  }

                });
              },
              child: Icon(Icons.add,size: 16,)
            ),
          ),
        ],
      ),
    );
  }
}
