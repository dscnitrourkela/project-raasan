import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingService {
  static final FirebaseMessaging fcmInstance = FirebaseMessaging();

  static Future<String> getToken() async {
    var token = await fcmInstance.getToken();
    return token;
  }
}
