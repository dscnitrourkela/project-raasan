import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final firebaseInstance = FirebaseAuth.instance;

  Future<void> verifyPhoneNumber(String phoneNumber) async {
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential credential) {
      print('Verification Complete');
      signInWithNumber(credential);
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException exception) {
      print(exception.message);
    };

    final PhoneCodeSent phoneCodeSent =
        (String verificationId, [int forceResendingToken]) async {
      print('Code sent: $verificationId');
    };

    final PhoneCodeAutoRetrievalTimeout retrievalTimeout =
        (String verificationId) {
      print('Retrieval Timeout: $verificationId');
    };

    await firebaseInstance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: phoneCodeSent,
        codeAutoRetrievalTimeout: retrievalTimeout);
  }

  void signInWithNumber(AuthCredential credential) {}
}
