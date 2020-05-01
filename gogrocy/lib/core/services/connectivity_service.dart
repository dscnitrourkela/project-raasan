import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:gogrocy/core/enums/connectivity_status.dart';

class ConnectivityService {
  StreamController<ConnectivityStatus> _connectionStatusController;

  ConnectivityService() {
    _connectionStatusController = StreamController<ConnectivityStatus>();
    _initNetworkStatusListener();
  }

  StreamController<ConnectivityStatus> get connectionStatusController =>
      _connectionStatusController;

  void _initNetworkStatusListener() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _connectionStatusController.add(_getStatusFromResult(result));
    });
  }

  ConnectivityStatus _getStatusFromResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        return ConnectivityStatus.WiFi;
      case ConnectivityResult.mobile:
        return ConnectivityStatus.Cellular;
      case ConnectivityResult.none:
        return ConnectivityStatus.Offline;
    }
  }

  void disposeStream() {
    _connectionStatusController.close();
  }
}
