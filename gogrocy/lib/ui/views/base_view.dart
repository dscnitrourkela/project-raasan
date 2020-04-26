import 'package:flutter/material.dart';
import 'package:gogrocy/core/viewModels/base_model.dart';
import 'package:provider/provider.dart';

import '../../service_locator.dart';

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

  @override
  void initState() {
    super.initState();
    if(!isDisposed)
    if (widget.onModelReady != null) {
      widget.onModelReady(model);
    }
  }


  @override
  void dispose() {
    model.dispose();
    isDisposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
        create: (context) => model,
        child: Consumer<T>(builder: widget.builder));
  }
}
