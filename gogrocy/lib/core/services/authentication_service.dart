import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthenticationService {
  final firebaseInstance = FirebaseAuth.instance;
  String verificationId;

  Future verifyPhoneNumber(BuildContext context, String phoneNumber) async {
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential credential) {
      print('Verification Complete');
      signInWithNumber(context, credential);
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException exception) {
      print(exception.message);
    };

    final PhoneCodeSent phoneCodeSent =
        (String verificationId, [int forceResendingToken]) async {
      this.verificationId = verificationId;
      print('Code sent: $verificationId');
    };

    final PhoneCodeAutoRetrievalTimeout retrievalTimeout =
        (String verificationId) {
      print('Retrieval Timeout: $verificationId');
    };

    try {
      await firebaseInstance.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          timeout: Duration(seconds: 60),
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: phoneCodeSent,
          codeAutoRetrievalTimeout: retrievalTimeout);
      FirebaseUser currentUser = await firebaseInstance.currentUser();
      return currentUser != null;
    } catch (e) {
      return e.message;
    }
  }

  signInWithNumber(BuildContext context, AuthCredential credential) async {
    FirebaseUser user =
        (await firebaseInstance.signInWithCredential(credential)).user;
    FirebaseUser currentUser = await firebaseInstance.currentUser();
    assert(user.uid == currentUser.uid);
  }

  Future signInWithOtp(String verificationId, String otp) async {
    try {
      AuthCredential credential = PhoneAuthProvider.getCredential(
          verificationId: verificationId, smsCode: otp);
      FirebaseUser currentUser =
          (await firebaseInstance.signInWithCredential(credential)).user;
      return currentUser != null;
    } catch (e) {
      return e.message;
    }
  }

  Future<bool> isUserLoggedIn() async {
    var user = await firebaseInstance.currentUser();
    return user != null;
  }
}
