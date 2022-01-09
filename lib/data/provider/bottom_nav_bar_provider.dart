import 'package:appflug/enums/views.dart';
import 'package:flutter/material.dart';

class BottomNavBarProvider extends ChangeNotifier {
  View selectedView = View.home;

  setSelectedView(View view) {
    selectedView = view;
    notifyListeners();
  }
}
