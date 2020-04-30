import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:gogrocy/core/models/sign_up_arguments.dart';
import 'package:gogrocy/core/services/navigation_service.dart';
import 'package:gogrocy/core/services/shared_prefs.dart';
import 'package:gogrocy/service_locator.dart';

class AuthenticationService {
  final firebaseInstance = FirebaseAuth.instance;
  String verificationId;

  final SharedPrefsService _sharedPrefsService = locator<SharedPrefsService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future verifyPhoneNumber(
      BuildContext context, String phoneNumber, String countryCode) async {
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential credential) async {
      print('Verification Complete');
      await signInWithNumber(context, credential);
      print("FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF");
      _navigationService.navigateTo('awesome',
          arguments: SignUpArguments(phoneNumber, countryCode));
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException exception) {
      print("VFAIL " + exception.message);
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
          phoneNumber: countryCode + " " + phoneNumber,
          timeout: Duration(seconds: 10),
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: phoneCodeSent,
          codeAutoRetrievalTimeout: retrievalTimeout);
      FirebaseUser currentUser = await firebaseInstance.currentUser();
      print(currentUser.uid + "    " + currentUser.phoneNumber);
      return currentUser != null;
    } catch (e) {
      print(e.message);
      return e.message;
    }
  }

  Future signInWithNumber(
      BuildContext context, AuthCredential credential) async {
    try {
      FirebaseUser user =
          (await firebaseInstance.signInWithCredential(credential)).user;
      FirebaseUser currentUser = await firebaseInstance.currentUser();
      assert(user.uid == currentUser.uid);
      return currentUser != null;
    } catch (exception) {
      print(exception.message);
    }
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

  Future<FirebaseUser> hasFirebaseUser() async {
    var user = await firebaseInstance.currentUser();
    if (user != null)
      return user;
    else
      return null;
  }

  Future<bool> isUserLoggedIn() async {
    var loggedIn = await _sharedPrefsService.hasUser();
    print(loggedIn);
    if (loggedIn) {
      return true;
    } else {
      return false;
    }
  }
}
