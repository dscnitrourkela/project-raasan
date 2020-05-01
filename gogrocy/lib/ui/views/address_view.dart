import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gogrocy/core/enums/viewstate.dart';
import 'package:gogrocy/core/viewModels/address_view_model.dart';
import 'package:gogrocy/ui/shared/colors.dart';
import 'package:gogrocy/ui/shared/constants.dart' as constants;
import 'package:gogrocy/ui/views/address_form.dart';
import 'package:gogrocy/ui/views/base_view.dart';
import 'package:gogrocy/ui/widgets/appbars/secondary_appbar.dart';

class AddressView extends StatefulWidget {
  @override
  _AddressViewState createState() => _AddressViewState();
}

class _AddressViewState extends State<AddressView> {
  GlobalKey<ScaffoldState> addressScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BaseView<AddressViewModel>(
      onModelReady: (model) {
        model.getAddresses();
      },
      builder: (context, model, child) => model.state == ViewState.Busy
          ? Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : WillPopScope(
              onWillPop: () async {
                Navigator.of(context).pop();
                return false;
              },
              child: SafeArea(
                child: Scaffold(
                  appBar: SecondaryAppBar('Your Addresses'),
                  floatingActionButton: OpenContainer(
                      transitionType: ContainerTransitionType.fadeThrough,
                      openColor: Colors.transparent,
                      closedShape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0))),
                      closedColor: primaryColor,
                      closedElevation: 6.0,
                      closedBuilder: (context, action) {
                        return SizedBox(
                          height: 50.0,
                          width: 50.0,
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        );
                      },
                      openBuilder: (context, action) => AddressForm()),
                  body: ListView.builder(
                    itemCount: model.addressList.length,
                    itemBuilder: (BuildContext context, int index) => Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0 * constants.scaleRatio,
                          vertical: 10.0 * constants.scaleRatio),
                      child: Card(
                        elevation: 4.0,
                        color: Colors.white,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading: model.addressList[index].isPrimary != '0'
                                  ? Icon(
                                      Icons.star,
                                      color: primaryColor,
                                    )
                                  : null,
                              title: Text(model.addressList[index].locality),
                              subtitle: Text(
                                  '${model.addressList[index].city}, ${model.addressList[index].state}'),
                            ),
                            /*ButtonBar(
                              children: <Widget>[
                                FlatButton(
                                  child: const Text('MAKE PRIMARY'),
                                  onPressed: () {
                                    */ /* ... */ /*
                                  },
                                ),
                                FlatButton(
                                  child: const Text('REMOVE'),
                                  onPressed: () {
                                    */ /* ... */ /*
                                  },
                                ),
                              ],
                            ),*/
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}

class AddAddressFloatingActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {},
    );
  }
}
