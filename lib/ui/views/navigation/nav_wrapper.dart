import 'package:appflug/shared_utils/layout_service.dart';
import 'package:appflug/ui/views/faq/faq_view.dart';
import 'package:appflug/ui/views/home/home.dart';
import 'package:appflug/ui/views/navigation/utils.dart';
import 'package:appflug/ui/views/profile/profile_view.dart';
import 'package:appflug/ui/views/university/university_view.dart';
import 'package:flutter/material.dart';

import 'app_bar.dart';
import 'bottom_nav_bar.dart';

class NavWrapper extends StatefulWidget {
  @override
  _NavWrapperState createState() => _NavWrapperState();
}

class _NavWrapperState extends State<NavWrapper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LayoutService.isDesktop(context)
          ? AppBarForWeb(
              context: context,
            )
          : null,
      body: IndexedStack(
        children: [
          HomeView(),
          UniversityView(),
          FaqView(),
          SettingsView(),
        ],
        index: _getSelectedViewIndex(context),
      ),
      bottomNavigationBar:
          LayoutService.isMobile(context) ? BottomNavBar() : null,
    );
  }

  int _getSelectedViewIndex(BuildContext context) {
    return NavBarService.getSelectedViewIndex(context);
  }
}
