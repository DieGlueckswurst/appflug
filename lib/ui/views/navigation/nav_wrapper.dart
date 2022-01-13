import 'package:appflug/ui/views/faq/faq_view.dart';
import 'package:appflug/ui/views/home/home.dart';
import 'package:appflug/ui/views/navigation/utils.dart';
import 'package:appflug/ui/views/profile/profile_view.dart';
import 'package:appflug/ui/views/university/university_view.dart';
import 'package:flutter/material.dart';

import 'bottom_nav_bar.dart';

class NavWrapper extends StatefulWidget {
  @override
  _NavWrapperState createState() => _NavWrapperState();
}

class _NavWrapperState extends State<NavWrapper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: [
          HomeView(),
          UniversityView(),
          FaqView(),
          SettingsView(),
        ],
        index: _getSelectedViewIndex(context),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }

  int _getSelectedViewIndex(BuildContext context) {
    return BottomNavBarService.getSelectedViewIndex(context);
  }
}
