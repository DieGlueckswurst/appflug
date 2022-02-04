import 'package:appflug/data/classes/application.dart';
import 'package:appflug/data/classes/document.dart';
import 'package:appflug/data/classes/student.dart';
import 'package:appflug/routes/view_for_empl.dart';
import 'package:appflug/shared_utils/application_service.dart';
import 'package:appflug/ui/empl/views/application_overview/application_overview.dart';
import 'package:appflug/ui/empl/views/document_detail/document_detail_view.dart';
import 'package:appflug/ui/empl/views/home/home_view.dart';
import 'package:appflug/ui/empl/views/wrapper/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class WrapperViewForEmpl extends StatefulWidget {
  @override
  _WrapperViewForEmplState createState() => _WrapperViewForEmplState();
}

class _WrapperViewForEmplState extends State<WrapperViewForEmpl> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarForEmpl(
        context: context,
      ),
      body: FutureBuilder(
        future: ApplicationService.initApplicationsData(
          context,
        ),
        builder: (context, snapshot) {
          return HeroControllerScope(
            controller: MaterialApp.createMaterialHeroController(),
            child: Navigator(
              initialRoute: ViewsForEmpl.home,
              onGenerateRoute: (RouteSettings settings) {
                WidgetBuilder builder;
                switch (settings.name) {
                  case ViewsForEmpl.home:
                    builder = (BuildContext context) => HomeViewForEmpl();
                    break;
                  case ViewsForEmpl.applicationOverview:
                    Application application = settings.arguments as Application;
                    builder = (BuildContext context) => ApplicationOverviewView(
                          application: application,
                        );
                    break;
                  case ViewsForEmpl.documentDetail:
                    List<Object> args = settings.arguments as List<Object>;
                    Document document = args[0] as Document;
                    Student student = args[1] as Student;

                    builder = (BuildContext context) => DocumentDetailView(
                          document: document,
                          student: student,
                        );
                    break;
                  default:
                    throw Exception('Invalid route: ${settings.name}');
                }
                return MaterialPageRoute(
                  builder: builder,
                  settings: settings,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
