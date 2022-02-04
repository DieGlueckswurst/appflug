// ignore_for_file: avoid_print

import 'package:appflug/data/backend/base.dart';
import 'package:appflug/data/backend/storage.dart';
import 'package:appflug/data/backend/student.dart';
import 'package:appflug/data/local_storage/local_storage_keys.dart';
import 'package:appflug/data/local_storage/local_storage_service.dart';
import 'package:appflug/data/provider/student_provider.dart';
import 'package:appflug/shared_utils/application_service.dart';
import 'package:appflug/shared_utils/student_service.dart';
import 'package:appflug/enums/status_option.dart';
import 'package:appflug/enums/views.dart';
import 'package:appflug/shared_utils/alert_service.dart';
import 'package:appflug/ui/views/navigation/utils.dart';
import 'package:appflug/ui/views/sign_up/utils/regex_map_with_descriptions_for_password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthenticationService {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static User? get currentUser => FirebaseAuth.instance.currentUser;

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
    } on FirebaseAuthException catch (error) {
      if (error.code == 'wrong-password') {
        AlertService.showSnackBar(
          title: 'Falsches Passwort',
          description:
              'Du kannst dein Passwort auch über den "Passwort vergessen"-Button zurücksetzen.',
          isSuccess: false,
        );
      } else {
        AlertService.showSnackBar(
          title: 'Fehler',
          description: error.message ?? 'Unbekannter Fehler',
          isSuccess: false,
        );
      }
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

  static Future<bool> signOut({
    BuildContext? context,
  }) async {
    try {
      await _firebaseAuth.signOut();

      if (context != null) {
        NavBarService.setSelectedView(
          context: context,
          viewToSelect: NavBarView.home,
        );
        Provider.of<StudentProvider>(context, listen: false).reset();

        ApplicationService.resetApplications(
          context: context,
        );
      }

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

  static Future signOutUserIfUserDeinstalledAndReinstalledApp() async {
    bool? isFirstStart = await LocalStorageService.getData(
      key: LocalStorageKeys.isFirstStart,
    );
    if (isFirstStart == null) {
      await signOut();
      await LocalStorageService.setBool(
        key: LocalStorageKeys.isFirstStart,
        value: false,
      );
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

  static Future<bool> reauthenticate({
    required String email,
    required String password,
  }) async {
    try {
      AuthCredential credentials =
          EmailAuthProvider.credential(email: email, password: password);
      var _ = await currentUser!.reauthenticateWithCredential(credentials);

      return true;
    } on FirebaseAuthException catch (error) {
      print(error.code);
      if (error.code == 'wrong-password') {
        AlertService.showSnackBar(
          title: 'Falsches Passwort',
          description:
              'Du kannst dein Passwort auch über den "Passwort vergessen"-Button zurücksetzen.',
          isSuccess: false,
        );
      } else {
        AlertService.showSnackBar(
          title: 'Fehler',
          description: error.message ?? 'Unbekannter Fehler',
          isSuccess: false,
        );
      }
      return false;
    }
  }

  static Future<bool> deleteUser(BuildContext context) async {
    try {
      await BackendStorageService.deleteUser(context);
      await BackendService().deleteUser();
      await currentUser!.delete();
      NavBarService.setSelectedView(
        context: context,
        viewToSelect: NavBarView.home,
      );
      Provider.of<StudentProvider>(context, listen: false).reset();

      return true;
    } on FirebaseException catch (error) {
      print(error.message);
      AlertService.showSnackBar(
        title: 'Fehler',
        description: error.message ?? 'Unbekannter Fehler',
        isSuccess: false,
      );
      return false;
    }
  }

  static Future<bool> changePassword(String newPassword) async {
    try {
      await currentUser!.updatePassword(
        newPassword,
      );
      return true;
    } on FirebaseAuthException catch (error) {
      AlertService.showSnackBar(
        title: 'Fehler',
        description: error.message ?? 'Unbekannter Fehler',
        isSuccess: false,
      );
      return false;
    }
  }

  static Future<bool> changeEmail(
    BuildContext context,
    String newEmail,
  ) async {
    try {
      await currentUser!.updateEmail(
        newEmail,
      );

      return await StudentService.setEmail(
        context: context,
        email: newEmail,
      );
    } on FirebaseAuthException catch (error) {
      AlertService.showSnackBar(
        title: 'Fehler',
        description: error.message ?? 'Unbekannter Fehler',
        isSuccess: false,
      );
      return false;
    }
  }

  static bool isValidPassword(String password) {
    return regexMapWithDescriptionsForPassword.keys.toList()[0].hasMatch(
              password,
            ) &&
        regexMapWithDescriptionsForPassword.keys.toList()[1].hasMatch(
              password,
            ) &&
        regexMapWithDescriptionsForPassword.keys.toList()[2].hasMatch(
              password,
            );
  }
}
