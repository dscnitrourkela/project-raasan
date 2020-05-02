import 'package:flutter/material.dart';
import 'package:gogrocy/core/viewModels/startup_view_model.dart';
import 'package:gogrocy/ui/shared/constants.dart' as constants;
import 'package:gogrocy/ui/views/base_view.dart';
import 'package:gogrocy/ui/widgets/text_widgets.dart';
import 'package:gogrocy/core/services/firebase_messaging_service.dart';

class StartupView extends StatefulWidget {
  @override
  _StartupViewState createState() => _StartupViewState();
}

class _StartupViewState extends State<StartupView> {
  FirebaseMessagingService _firebaseMessagingService =
      FirebaseMessagingService();

  @override
  void initState() {
    super.initState();
    _firebaseMessagingService.getToken();
    _firebaseMessagingService.initializeNotifications(context);
  }

  @override
  Widget build(BuildContext context) {
    constants.mediaQueryData = MediaQuery.of(context);
    print(constants.screenWidth);
    print(constants.screenHeight);
    print(constants.mediaQueryData.devicePixelRatio);
    return BaseView<StartupViewModel>(
      onModelReady: (model) => model.handleStartUpLogic(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Hero(
                child: TitleText(),
                tag: 'GoGrocy',
              ),
              LinearProgressIndicator(
                value: null,
                backgroundColor: Colors.grey,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
