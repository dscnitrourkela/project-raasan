import 'package:flutter/material.dart';
import 'package:gogrocy/core/services/bottom_appbar_provider.dart';
import 'package:gogrocy/ui/shared/constants.dart' as constants;
import 'package:gogrocy/ui/views/view_carousel.dart';
import 'package:gogrocy/ui/widgets/appbars/main_appbar.dart';
import 'package:gogrocy/ui/widgets/bottom_navbar.dart';
import 'package:provider/provider.dart';

class HomePageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    constants.mediaQueryData = MediaQuery.of(context);
    return ChangeNotifierProvider<BottomNavBarProvider>(
        create: (BuildContext context) => BottomNavBarProvider(),
        child: Consumer<BottomNavBarProvider>(builder: (context, counter, _) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: MainAppBar(),
              body: ViewCarousel(),
              bottomNavigationBar: BottomNavBar(),
            ),
          );
        }));
  }
}
