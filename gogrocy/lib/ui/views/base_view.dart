import 'dart:async';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:gogrocy/core/enums/connectivity_status.dart';
import 'package:gogrocy/core/services/connectivity_service.dart';
import 'package:gogrocy/core/viewModels/base_model.dart';
import 'package:gogrocy/ui/widgets/snackbars/custom_snackbar.dart';
import 'package:provider/provider.dart';

import 'package:gogrocy/service_locator.dart';

class BaseView<T extends BaseModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T model, Widget child) builder;
  final Function(T) onModelReady;

  BaseView({this.builder, this.onModelReady});

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseModel> extends State<BaseView<T>> {
  T model = locator<T>();

  bool isDisposed = false;

  StreamController<ConnectivityStatus> _connectivityStatusController =
      ConnectivityService().connectionStatusController;

  Flushbar _onlineFlush = onlineSnackBar();
  Flushbar _offlineFlush = offlineSnackBar();

  @override
  void initState() {
    super.initState();
    _connectivityStatusController.stream.listen((ConnectivityStatus status) {
      switch (status) {
        case ConnectivityStatus.WiFi:
          if (_offlineFlush.isShowing()) {
            _offlineFlush.dismiss();
            _onlineFlush.show(context);
          }
          break;
        case ConnectivityStatus.Cellular:
          if (_offlineFlush.isShowing()) {
            _offlineFlush.dismiss();
            _onlineFlush.show(context);
          }
          break;
        case ConnectivityStatus.Offline:
          if (!_offlineFlush.isShowing()) _offlineFlush.show(context);
          break;
      }
    });
    if (!isDisposed) if (widget.onModelReady != null) {
      widget.onModelReady(model);
    }
  }

  @override
  void dispose() {
    _connectivityStatusController.close();
    model.dispose();
    isDisposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (context) => model,
      child: Consumer<T>(
        builder: widget.builder,
      ),
    );
  }
}
