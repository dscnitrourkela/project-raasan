import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:gogrocy/core/enums/connectivity_status.dart';
import 'package:gogrocy/core/enums/viewstate.dart';
import 'package:gogrocy/core/services/connectivity_service.dart';

class BaseModel extends ChangeNotifier {
  ViewState _state = ViewState.Idle;

  ViewState get state => _state;

  StreamController<ConnectivityStatus> _connectivityStatusController =
      ConnectivityService().connectionStatusController;
  Stream<ConnectivityStatus> connectivityStatus =
      ConnectivityService().connectionStatusController.stream;
  bool hasConnection = true;

  BaseModel() {
    connectivityStatus.listen((ConnectivityStatus status) {
      switch (status) {
        case ConnectivityStatus.WiFi:
          this.hasConnection = true;
          print(hasConnection);
          notifyListeners();
          break;
        case ConnectivityStatus.Cellular:
          this.hasConnection = true;
          notifyListeners();
          break;
        case ConnectivityStatus.Offline:
          this.hasConnection = false;
          notifyListeners();
          break;
      }
    });
  }

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _connectivityStatusController.close();
    super.dispose();
  }
}
