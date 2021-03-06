import 'package:appflug/enums/views.dart';
import 'package:flutter/material.dart';

class NavBarProvider extends ChangeNotifier {
  NavBarView selectedView = NavBarView.home;

  setSelectedView(NavBarView view) {
    selectedView = view;
    notifyListeners();
  }
}
