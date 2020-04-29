import 'package:flutter/material.dart';
import 'package:gogrocy/core/services/navigation_service.dart';
import 'package:gogrocy/service_locator.dart';
import 'package:simple_search_bar/simple_search_bar.dart';

class SearchView extends StatelessWidget {

  final AppBarController appBarController = AppBarController();


  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: SearchAppBar(
        primary: Theme.of(context).primaryColor,
        appBarController: appBarController,
        // You could load the bar with search already active
        autoSelected: true,
        searchHint: "Pesquise aqui...",
        mainTextColor: Colors.white,
        onChange: (String value) {
          //Your function to filter list. It should interact with
          //the Stream that generate the final list
        },
        //Will show when SEARCH MODE wasn't active
        mainAppBar: AppBar(
          title: Text("Yout Bar Title"),
          actions: <Widget>[
            InkWell(
              child: Icon(
                Icons.search,
              ),
              onTap: () {
                //This is where You change to SEARCH MODE. To hide, just
                //add FALSE as value on the stream
                appBarController.stream.add(true);
              },
            ),
          ],
        ),
      ),
    ));
  }
}
