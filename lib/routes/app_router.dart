import 'package:appflug/data/classes/document.dart';
import 'package:appflug/enums/courses.dart';
import 'package:appflug/enums/status_option.dart';
import 'package:appflug/routes/views.dart';
import 'package:appflug/ui/views/account/account_view.dart';
import 'package:appflug/ui/views/authentication/authentication_view.dart';
import 'package:appflug/ui/views/birthplace/birthplace.dart';
import 'package:appflug/ui/views/change_email/change_email_view.dart';
import 'package:appflug/ui/views/change_password/change_password_view.dart';
import 'package:appflug/ui/views/course/course.dart';
import 'package:appflug/ui/views/delete_account/delete_account_view.dart';
import 'package:appflug/ui/views/document/document_view.dart';
import 'package:appflug/ui/views/documents/documents_view.dart';
import 'package:appflug/ui/views/email/email_view.dart';
import 'package:appflug/ui/views/login/login_view.dart';
import 'package:appflug/ui/views/matriculation_number/matriculation_number_view.dart';
import 'package:appflug/ui/views/navigation/nav_wrapper.dart';
import 'package:appflug/ui/views/personal_data/personal_data_view.dart';
import 'package:appflug/ui/views/preference_list/preference_list_view.dart';
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
        List<Object> args = settings.arguments as List<Object>;
        String email = args[0] as String;
        return MaterialPageRoute(
          builder: (context) => SignUpView(
            email: email,
          ),
        );

      case Views.login:
        List<Object> args = settings.arguments as List<Object>;
        String email = args[0] as String;
        StatusOption statusOption = args[1] as StatusOption;
        return MaterialPageRoute(
          builder: (context) => LoginView(
            email: email,
            statusOption: statusOption,
          ),
        );

      case Views.home:
        return MaterialPageRoute(
          builder: (context) => NavWrapper(),
        );

      case Views.matriculationNumber:
        String? matriculationNumberString = settings.arguments as String?;
        return MaterialPageRoute(
          builder: (context) => MatriculationNumberView(
            initMatriculationNumber: matriculationNumberString,
          ),
        );

      case Views.birthplace:
        String? birthplace = settings.arguments as String?;
        return MaterialPageRoute(
          builder: (context) => BirthplaceView(
            initBirthplace: birthplace,
          ),
        );

      case Views.course:
        Course? course = settings.arguments as Course?;
        return MaterialPageRoute(
          builder: (context) => CourseView(
            initCourse: course,
          ),
        );

      case Views.languageTest:
        Document document = settings.arguments as Document;

        return MaterialPageRoute(
          builder: (context) => DocumentView(
            document: document,
          ),
        );

      case Views.letterOfMotivation:
        Document document = settings.arguments as Document;

        return MaterialPageRoute(
          builder: (context) => DocumentView(
            document: document,
          ),
        );

      case Views.passport:
        Document document = settings.arguments as Document;

        return MaterialPageRoute(
          builder: (context) => DocumentView(
            document: document,
          ),
        );

      case Views.transcriptOfRecords:
        Document document = settings.arguments as Document;

        return MaterialPageRoute(
          builder: (context) => DocumentView(
            document: document,
          ),
        );

      case Views.preferenceList:
        return MaterialPageRoute(
          builder: (context) => PreferenceListView(),
        );

      case Views.documents:
        return MaterialPageRoute(
          builder: (context) => DocumentsView(),
        );

      case Views.personalData:
        return MaterialPageRoute(
          builder: (context) => PersonalDataView(),
        );

      case Views.account:
        return MaterialPageRoute(
          builder: (context) => AccountView(),
        );

      case Views.changePassword:
        return MaterialPageRoute(
          builder: (context) => ChangePasswordView(),
        );

      case Views.deleteAccount:
        return MaterialPageRoute(
          builder: (context) => DeleteAccountView(),
        );

      case Views.authentication:
        String viewToNavigateTo = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => AuthenticationView(
            viewToNavigateTo: viewToNavigateTo,
          ),
        );

      case Views.changeEmail:
        return MaterialPageRoute(
          builder: (context) => ChangeEmailView(),
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
