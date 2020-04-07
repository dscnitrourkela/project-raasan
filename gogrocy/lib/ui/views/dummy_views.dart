import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gogrocy/core/enums/viewstate.dart';
import 'package:gogrocy/core/viewModels/allProducts_model.dart';
import 'package:gogrocy/ui/views/base_view.dart';

class AllProductsView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BaseView<AllProductsModel>(
      onModelReady: (model)=>model.getAllProducts(),
      builder: (context,model,child)=>Scaffold(
        backgroundColor: Colors.white,
        body: model.state==ViewState.Busy?
        Center(child: CircularProgressIndicator())
        :ListView.builder(
            itemCount: model.allProducts.length,
            itemBuilder: (context,index){
              return Text(model.allProducts[index].name);
            }),
      ),
    );
  }


}