import 'package:flutter/material.dart';
import 'package:gogrocy/ui/shared/constants.dart' as constants;
import 'package:gogrocy/ui/shared/colors.dart' as colors;

class CartCounter extends StatefulWidget {

  int maxQuantity;

  CartCounter ({ @required this.maxQuantity }): super();

  @override
  _CartCounterState createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {

  double buttonWidth=constants.CartConfig.counterWidth/3;
  double buttonHeight=constants.CartConfig.counterHeight;
  int selectedValue=1;

  @override
  Widget build(BuildContext context) {
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
                  if(selectedValue>1)
                  selectedValue--;
                });
              },
              child: Icon(Icons.remove,size: 16,)
            ),
          ),
          new Container(
            padding: EdgeInsets.all(4.0),
            child: new Text(
                selectedValue.toString(),

            ),
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
                  if(selectedValue<widget.maxQuantity)
                  selectedValue++;
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
