import 'package:flutter/material.dart';
import 'package:gogrocy/core/services/bottom_appbar_provider.dart';
import 'package:gogrocy/ui/views/home/home.dart';
import 'package:provider/provider.dart';

class ViewCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BottomNavBarProvider>(context);
    PageController controller =
        PageController(initialPage: provider.currentIndex);
    Provider.of<BottomNavBarProvider>(context, listen: true);
    provider.addListener(() {
      controller.animateToPage(provider.currentIndex,
          duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    });
    return PageView(
      children: <Widget>[
        Home(),
        Home(),
        Home(),
      ],
      physics: NeverScrollableScrollPhysics(),
      controller: controller,
      onPageChanged: (index) {
        provider.currentIndex = index;
      },
    );
  }
}
