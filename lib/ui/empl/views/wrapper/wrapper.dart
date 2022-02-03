import 'package:appflug/routes/view_for_empl.dart';
import 'package:appflug/ui/empl/views/application_overview/application_overview.dart';
import 'package:appflug/ui/empl/views/home/home_view.dart';
import 'package:appflug/ui/empl/views/wrapper/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class WrapperViewForEmpl extends StatefulWidget {
  @override
  _WrapperViewForEmplState createState() => _WrapperViewForEmplState();
}

class _WrapperViewForEmplState extends State<WrapperViewForEmpl> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarForEmpl(
        context: context,
      ),
      body: Navigator(
        key: _navigatorKey,
        initialRoute: ViewsForEmpl.home,
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case ViewsForEmpl.home:
              builder = (BuildContext context) => HomeViewForEmpl();
              break;
            case ViewsForEmpl.applicationOverview:
              builder = (BuildContext context) => ApplicationOverviewView();
              break;

            default:
              throw Exception('Invalid route: ${settings.name}');
          }
          // You can also return a PageRouteBuilder and
          // define custom transitions between pages
          return MaterialPageRoute(
            builder: builder,
            settings: settings,
          );
        },
      ),
    );
  }
}
