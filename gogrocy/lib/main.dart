import 'package:flutter/material.dart';
import 'package:gogrocy/ui/shared/constants.dart' as constants;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GoGrocy',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'GoGrocy'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    constants.mediaQueryData = MediaQuery.of(context);
    print(constants.LoginSizeConfig.loginIllustrationWidth.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text(
          'GOGROCY',
          style: Theme.of(context).textTheme.display1,
        ),
      ),
    );
  }
}
