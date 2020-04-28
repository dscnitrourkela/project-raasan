import 'package:flutter/material.dart';
import 'package:gogrocy/core/enums/viewstate.dart';
import 'package:gogrocy/core/models/Address.dart';
import 'package:gogrocy/core/models/Detail.dart';
import 'package:gogrocy/core/models/Orders.dart';
import 'package:gogrocy/core/viewModels/orderLis_model.dart';
import 'package:gogrocy/ui/views/base_view.dart';
import 'package:gogrocy/ui/widgets/appbar.dart';
class OrderView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: TopAppBar(),
        body: BaseView<OrderViewModel>(
          onModelReady: (model){
            model.getOrders();
          },
          builder: (context,model,child){
            if(model.state==ViewState.Busy)
              return Center(child: CircularProgressIndicator(),);
            else
              return Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text("Orders")
                    ],
                  ),
                  ListView.separated(

                      itemBuilder: (context,index){
                        Orders details=model.orders;
                        return Column(
                          children: <Widget>[
                            Text(details.result.bills[index].billId)
                          ],
                        );
                      }, separatorBuilder: (context, index){
                        return Divider();
                  }, itemCount: model.orders.result.bills[0].details.length)
                ],
              );
          },
        ),
      ),
    );
  }
}
