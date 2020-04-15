import 'package:flutter/material.dart';
import 'package:gogrocy/core/viewModels/allProducts_model.dart';
import 'package:gogrocy/ui/views/base_view.dart';

class GridList extends StatelessWidget {

  ScrollController _scrollController=new ScrollController();


  @override
  Widget build(BuildContext context) {
    return BaseView<AllProductsModel>(
      onModelReady: (model){
        model.getAllProducts();
      },
      builder: (context,model, child)=>GridView.builder(
          itemCount: 10,
          controller: _scrollController,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
            crossAxisSpacing: 8.0
          ),
          itemBuilder: (context,index){
            return Container(
              width: 30.0,
                height: 30.0,
              color: Colors.blue,
            );
          }),
    );
  }
}
