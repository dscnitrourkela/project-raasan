import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:gogrocy/core/services/fcm_subscribe_service.dart';
import 'package:gogrocy/core/services/firebase_messaging_service.dart';
import 'package:gogrocy/core/services/navigation_service.dart';
import 'package:gogrocy/core/services/shared_prefs.dart';
import 'package:gogrocy/core/viewModels/base_model.dart';
import 'package:gogrocy/service_locator.dart';
import 'package:gogrocy/ui/shared/colors.dart';
import 'package:gogrocy/ui/shared/constants.dart' as constants;
import 'package:gogrocy/ui/views/base_view.dart';
import 'package:gogrocy/ui/widgets/vertical_spaces.dart';

class CitySelectionView extends StatelessWidget {
  final _navigationService = locator<NavigationService>();
  final _sharedPrefsService = locator<SharedPrefsService>();

  @override
  Widget build(BuildContext context) {
    return BaseView<CitySelectionModel>(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: ListView(
            children: <Widget>[
              VerticalSpaces.small20,
              Center(
                child: Text(
                  'Select City',
                  style: TextStyle(fontSize: 0.049 * constants.screenWidth),
                ),
              ),
              RadioListTile(
                title: Text("Jeypore"),
                subtitle: Text("Odisha"),
                activeColor: primaryColor,
                onChanged: (value) {
                  model.setSelectedCityTile(value);
                },
                groupValue: model.selectedCityTile,
                value: 1,
              ),
              RadioListTile(
                title: Text("Sunabeda"),
                subtitle: Text("Odisha"),
                activeColor: primaryColor,
                onChanged: (value) {
                  model.setSelectedCityTile(value);
                },
                groupValue: model.selectedCityTile,
                value: 2,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 0.336 * constants.screenWidth,
                    vertical: 0.059 * constants.screenHeight),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  color: Colors.black,
                  child: Text(
                    'Done',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Gilroy',
                        fontSize: 0.039 * constants.screenWidth,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () async {
                    if (model.selectedCityTile == 0) {
                      Flushbar(
                        messageText: Text(
                          "Select a city",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500),
                        ),
                        flushbarStyle: FlushbarStyle.FLOATING,
                        duration: Duration(seconds: 2),
                        icon: Icon(
                          Icons.error_outline,
                          color: Colors.red,
                        ),
                        shouldIconPulse: false,
                        barBlur: 0.9,
                        margin: EdgeInsets.all(8.0),
                        borderRadius: 8.0,
                        backgroundColor: Colors.white,
                        boxShadows: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 5.0,
                          )
                        ],
                      ).show(context);
                    } else {
                      String city =
                          model.selectedCityTile == 1 ? "Jeypore" : "Sunabeda";
                      await _sharedPrefsService.setCity(city);
                      _navigationService.goBack();
                      _navigationService.navigateTo('home');
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CitySelectionModel extends BaseModel {
  int selectedCityTile = 0;

  setSelectedCityTile(int val) {
    selectedCityTile = val;
    notifyListeners();
  }
}
