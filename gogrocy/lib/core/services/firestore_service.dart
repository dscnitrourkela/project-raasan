import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:gogrocy/core/services/firebase_messaging_service.dart';

class FireStoreService {
  static void addUser(
      {@required String phoneNumber, @required String countryCode}) async {
    var token = await FirebaseMessagingService.fcmInstance.getToken();
    await FirebaseMessagingService.fcmInstance.subscribeToTopic('GoGrocy');
    String documentName = countryCode + "_" + phoneNumber;
    Map<String, dynamic> data = {"token": token};
    var docReference =
        Firestore.instance.collection('users').document(documentName);
    var snapshot = await docReference.get();
    if (snapshot.exists) {
      if (snapshot.data["token"] != token) {
        Firestore.instance
            .collection('users')
            .document(documentName)
            .setData(data);
      } else {
        docReference.setData(data);
      }
    } else {
      docReference.setData(data);
    }
  }
}
