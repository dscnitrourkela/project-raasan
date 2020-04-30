import 'package:flutter/material.dart';
import 'package:gogrocy/ui/widgets/appbars/main_appbar.dart';
import 'package:gogrocy/ui/widgets/text_widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            color: Colors.black,
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
        body: WebView(
          initialUrl: 'https://gogrocy.in/privacy_policy',
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
