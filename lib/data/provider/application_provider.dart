import 'package:appflug/data/classes/application.dart';
import 'package:flutter/material.dart';

class ApplicationProvider extends ChangeNotifier {
  List<Application>? applications;

  setApplications(List<Application> _applications) {
    applications = _applications;
    notifyListeners();
  }
}
