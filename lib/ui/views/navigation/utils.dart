import 'package:appflug/data/provider/bottom_nav_bar_provider.dart';
import 'package:appflug/enums/views.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavBarService {
  static Map<NavBarView, int> viewsMapWithIndex = {
    NavBarView.home: 0,
    NavBarView.university: 1,
    NavBarView.faq: 2,
    NavBarView.settings: 3,
  };

  static NavBarView getSelectedView(BuildContext context) {
    return Provider.of<BottomNavBarProvider>(context).selectedView;
  }

  static int getSelectedViewIndex(BuildContext context) {
    return viewsMapWithIndex[
        Provider.of<BottomNavBarProvider>(context).selectedView]!;
  }

  static void setSelectedView({
    required BuildContext context,
    required NavBarView viewToSelect,
  }) {
    Provider.of<BottomNavBarProvider>(
      context,
      listen: false,
    ).setSelectedView(viewToSelect);
  }
}
