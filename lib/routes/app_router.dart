import 'package:appflug/routes/views.dart';
import 'package:appflug/ui/views/birthplace/birthplace.dart';
import 'package:appflug/ui/views/course/course.dart';
import 'package:appflug/ui/views/email/email_view.dart';
import 'package:appflug/ui/views/language_test/language_test_view.dart';
import 'package:appflug/ui/views/letter_of_motivation/letter_of_motivation_view.dart';
import 'package:appflug/ui/views/login/login_view.dart';
import 'package:appflug/ui/views/matriculation_number/matriculation_number_view.dart';
import 'package:appflug/ui/views/navigation/nav_wrapper.dart';
import 'package:appflug/ui/views/passport/passport_view.dart';
import 'package:appflug/ui/views/preference_list/preference_list_view.dart';
import 'package:appflug/ui/views/sign_up/sign_up_view.dart';
import 'package:appflug/ui/views/start/start_view.dart';
import 'package:appflug/ui/views/transcript_of_records/transcript_of_records_view.dart';
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

      case Views.matriculationNumber:
        return MaterialPageRoute(
          builder: (context) => MatriculationNumberView(),
        );

      case Views.birthplace:
        return MaterialPageRoute(
          builder: (context) => BirthplaceView(),
        );

      case Views.course:
        return MaterialPageRoute(
          builder: (context) => CourseView(),
        );

      case Views.languageTest:
        return MaterialPageRoute(
          builder: (context) => LanguageTestView(),
        );

      case Views.letterOfMotivation:
        return MaterialPageRoute(
          builder: (context) => LetterOfMotivationView(),
        );

      case Views.passport:
        return MaterialPageRoute(
          builder: (context) => PassportView(),
        );

      case Views.preferenceList:
        return MaterialPageRoute(
          builder: (context) => PreferenceListView(),
        );

      case Views.transcriptOfRecords:
        return MaterialPageRoute(
          builder: (context) => TranscriptOfRecordsView(),
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
