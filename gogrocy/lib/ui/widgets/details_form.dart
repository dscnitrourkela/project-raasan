import 'package:flutter/material.dart';
import 'package:gogrocy/core/services/navigation_service.dart';
import 'package:gogrocy/core/viewModels/animations_model.dart';
import 'package:gogrocy/service_locator.dart';
import 'package:provider/provider.dart';

class DetailsForm extends StatefulWidget {
  final womanScaleController;

  DetailsForm(this.womanScaleController);

  @override
  _DetailsFormState createState() => _DetailsFormState();
}

class _DetailsFormState extends State<DetailsForm> {
  final NavigationService navigationService = locator<NavigationService>();
  @override
  Widget build(BuildContext context) {
    return Provider<AnimationsModel>(
      create: (context) =>
          AnimationsModel(controller: widget.womanScaleController),
      child: Consumer<AnimationsModel>(
        builder: (context, model, child) => FadeTransition(
          opacity: model.formFadeAnimation,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('What do we call you?'),
              SizedBox(
                height: 10.0,
              ),
              SizedBox(
                width: 350.0,
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'Name',
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text('Where do you live?'),
              SizedBox(
                height: 10.0,
              ),
              SizedBox(
                width: 350.0,
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'House/ Flat Number',
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              SizedBox(
                width: 350.0,
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'Street Number',
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Create password.',
                style: TextStyle(fontSize: 14.0),
              ),
              SizedBox(
                height: 10.0,
              ),
              SizedBox(
                width: 350.0,
                child: TextFormField(
                  obscureText: true,
                  cursorColor: Colors.green,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'Enter password',
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              Padding(
                padding: const EdgeInsets.only(left: 130.0),
                child: SizedBox(
                  width: 120.0,
                  height: 40.0,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    color: Colors.black,
                    child: Text(
                      'Done',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              FlatButton(
                  onPressed: () {
                    navigationService.navigateTo('home');
                  },
                  child: Text('SKIP')),
            ],
          ),
        ),
      ),
    );
  }
}
