import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FirebaseMessagingService {
  static final FirebaseMessaging fcmInstance = FirebaseMessaging();

  Future<String> getToken() async {
    var token = await fcmInstance.getToken();
    print("Firebase Token is $token");
    return token;
  }

  void initializeNotifications(BuildContext context) {
    fcmInstance.configure(onMessage: (Map<String, dynamic> message) async {
      print('onMessage');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: ListTile(
            title: Text(message['notification']['title']),
            subtitle: Text(message['notification']['body']),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }, onLaunch: (Map<String, dynamic> message) async {
      print("onLaunch: $message");
    }, onResume: (Map<String, dynamic> message) async {
      print("onResume: $message");
    });
    fcmInstance.subscribeToTopic('pests');
    fcmInstance.subscribeToTopic('weather');
    print('FCM Configured!');
  }

  static void reSubscribeWeatherHandler() {
    fcmInstance.subscribeToTopic('weather');
  }

  static void reSubscribePestHandler() {
    fcmInstance.subscribeToTopic('pests');
  }

  static void unsubscribePestHandler() {
    fcmInstance.unsubscribeFromTopic('pests');
  }

  static void unsubscribeWeatherHandler() {
    fcmInstance.unsubscribeFromTopic('weather');
  }
}
