import 'package:appflug/routes/views.dart';
import 'package:appflug/ui/views/email/email_view.dart';
import 'package:appflug/ui/views/sign_up/sign_up_view.dart';
import 'package:appflug/ui/views/start/start_view.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Views.start:
        return MaterialPageRoute(
          builder: (context) => const StartView(),
        );

      case Views.email:
        return MaterialPageRoute(
          builder: (context) => EmailView(),
        );

      case Views.signUp:
        String email = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => SignUpView(
            email: email,
          ),
        );

      case Views.login:
        return MaterialPageRoute(
          builder: (context) => EmailView(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text(
                'No route defined for ${settings.name}',
              ),
            ),
          ),
        );
    }
  }
}
