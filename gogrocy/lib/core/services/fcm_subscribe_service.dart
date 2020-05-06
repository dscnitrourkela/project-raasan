import 'package:firebase_messaging/firebase_messaging.dart';

class FCMSubscription{

  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();

  void fcmSubscribe(String city) {
    firebaseMessaging.subscribeToTopic(city);
  }

  void fcmUnSubscribe(String city) {
    firebaseMessaging.unsubscribeFromTopic(city);
  }

}