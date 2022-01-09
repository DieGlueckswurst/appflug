import 'package:appflug/data/provider/bottom_nav_bar_provider.dart';
import 'package:appflug/enums/views.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavBarService {
  static Map<View, int> viewsMapWithIndex = {
    View.home: 0,
    View.university: 1,
    View.faq: 2,
    View.profile: 3,
  };

  static View getSelectedView(BuildContext context) {
    return Provider.of<BottomNavBarProvider>(context).selectedView;
  }

  static int getSelectedViewIndex(BuildContext context) {
    return viewsMapWithIndex[
        Provider.of<BottomNavBarProvider>(context).selectedView]!;
  }

  static void setSelectedView({
    required BuildContext context,
    required View viewToSelect,
  }) {
    Provider.of<BottomNavBarProvider>(
      context,
      listen: false,
    ).setSelectedView(viewToSelect);
  }
}
