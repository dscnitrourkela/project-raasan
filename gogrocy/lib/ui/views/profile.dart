import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gogrocy/core/models/cart_list.dart';
import 'package:gogrocy/core/services/authentication_service.dart';
import 'package:gogrocy/core/services/navigation_service.dart';
import 'package:gogrocy/core/services/shared_prefs.dart';
import 'package:gogrocy/core/viewModels/cart_view_model.dart';
import 'package:gogrocy/service_locator.dart';
import 'package:gogrocy/ui/views/base_view.dart';
import 'package:gogrocy/ui/views/cart/cart.dart';
import 'package:gogrocy/ui/shared/colors.dart' as colors;

class Account extends StatelessWidget {
  final _navigationService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();
  final _sharedPrefService = locator<SharedPrefsService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BaseView<CartViewModel>(
        onModelReady: (model) {
          model.getCartList(productId: null, quantity: null);
        },
        builder: (context, model, child) {
          return ListView(
            children:
                //CartHeader(model: model.cartList,),
                ListTile.divideTiles(context: context, tiles: [
              options(
                  icon: Icon(
                    Icons.info_outline,
                    color: Colors.black,
                  ),
                  title: 'About',
                  route: 'about'),
              options(
                  icon: Icon(
                    Icons.home,
                    color: Colors.black,
                  ),
                  title: "Addresses",
                  route: 'address'),
              options(
                  icon: Image.asset('assets/images/orders.png'),
                  title: "Orders",
                  route: 'orders'),
              options(
                  icon: Icon(
                    Icons.account_box,
                    color: Colors.black,
                  ),
                  title: 'Privacy Policy',
                  route: 'web'),
              options(
                icon: Icon(
                  Icons.exit_to_app,
                  color: Colors.black,
                ),
                title: 'Logout',
                route: 'login',
              ),
            ]).toList(),
          );
        },
      ),
    );
  }

  Widget options({Widget icon, String title, String route}) {
    return ListTile(
      onTap: () async {
        if (route == 'login') {
          FirebaseUser user = await _authenticationService.hasFirebaseUser();
          if (user != null) {
            await FirebaseAuth.instance.signOut();
            await _sharedPrefService.setLoggedIn(false);
            _navigationService.goBack();
            _navigationService.navigateTo(route);
          } else {
            await _sharedPrefService.setLoggedIn(false);
            _navigationService.goBack();
            _navigationService.navigateTo(route);
          }
        } else if (route == 'web') {
          _navigationService.navigateTo(route,
              arguments: 'https://gogrocy.in/privacy_policy');
        } else {
          _navigationService.navigateTo(route);
        }
      },
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: Colors.black,
      ),
      leading: icon,
      title: Text(title),
    );
    /*Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0 * constants.scaleRatio),
      child: Card(
        color: Colors.white,
        elevation: 4.0,
        child: ListTile(
          onTap: (){
            _navigationService.navigateTo(route);
          },
          trailing: Icon(Icons.arrow_forward_ios),
          leading: Image.asset(icon),
          title: Text('Order History'),
        ),
      ),
    );*/
  }
}
