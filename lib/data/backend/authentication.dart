// ignore_for_file: avoid_print

import 'package:appflug/data/backend/base.dart';
import 'package:appflug/data/backend/student.dart';
import 'package:appflug/enums/status_option.dart';
import 'package:appflug/shared_utils/alert_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => FirebaseAuth.instance.currentUser;

  static bool isLoggedIn() {
    return _firebaseAuth.currentUser != null;
  }

  static Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      AlertService.showSnackBar(
        title: 'Hopla, hier ist etwas schiefgelaufen...',
        description: e.message ?? 'Unbekannter Fehler',
        isSuccess: false,
      );
      return false;
    }
  }

  static Future<bool> signUp({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await BackendService().createUserInDatabase(
        uid: _firebaseAuth.currentUser!.uid,
        statusOption: StatusOption.stud,
        email: email,
      );

      return true;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      AlertService.showSnackBar(
        title: 'Hopla, hier ist etwas schiefgelaufen...',
        description: e.message ?? 'Unbekannter Fehler',
        isSuccess: false,
      );
      return false;
    } on FirebaseException catch (e) {
      print(e.message);
      AlertService.showSnackBar(
        title: 'Hopla, hier ist etwas schiefgelaufen...',
        description: e.message ?? 'Unbekannter Fehler',
        isSuccess: false,
      );
      return false;
    }
  }

  static Future<bool> checkIfEmailIsAlreadyInUse({
    required String email,
  }) async {
    try {
      final list = await _firebaseAuth.fetchSignInMethodsForEmail(
        email,
      );
      if (list.isNotEmpty) {
        // Return true because there is an existing
        // user using the email address
        return true;
      } else {
        return false;
      }
    } on FirebaseAuthException catch (e) {
      AlertService.showSnackBar(
        title: 'Hopla, hier ist etwas schiefgelaufen...',
        description: e.message ?? 'Unbekannter Fehler',
        isSuccess: false,
      );
      return true;
    }
  }

  static Future<bool> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return true;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      AlertService.showSnackBar(
        title: 'Hopla, hier ist etwas schiefgelaufen...',
        description: e.message ?? 'Unbekannter Fehler',
        isSuccess: false,
      );
      return false;
    }
  }

  static Future<bool> sendPasswordResetEmail({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return false;
    }
  }
}
