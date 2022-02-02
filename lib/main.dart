import 'package:appflug/data/backend/authentication.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;

import 'app.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: kIsWeb || Platform.isAndroid
        ? FirebaseOptions(
            apiKey: "AIzaSyBxriQI0B5XY6jhvBG4vZBlvig44EJ5J1E",
            appId: "1:555930958224:web:72d3389a096c37f9c15b15",
            messagingSenderId: "555930958224",
            projectId: "appflug",
            storageBucket: "appflug.appspot.com",
          )
        : null,
  );

  // very important step! Without this, after the user deinstalls the app and installs it again,
  // Firebase still thinks that the user is logged in so we have to check if it is the first app start (local storage)
  // and if so, sign out the user from Firebase so 'currentUser' is null.
  await AuthenticationService.signOutUserIfUserDeinstalledAndReinstalledApp();

  runApp(
    const App(),
  );
}
