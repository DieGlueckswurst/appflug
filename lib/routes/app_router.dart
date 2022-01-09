import 'package:appflug/routes/views.dart';
import 'package:appflug/ui/views/email/email_view.dart';
import 'package:appflug/ui/views/login/login_view.dart';
import 'package:appflug/ui/views/navigation/nav_wrapper.dart';
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
        String email = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => LoginView(
            email: email,
          ),
        );

      case Views.home:
        return MaterialPageRoute(
          builder: (context) => NavWrapper(),
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
