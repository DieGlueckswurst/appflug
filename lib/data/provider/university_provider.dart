import 'package:appflug/data/classes/university.dart';
import 'package:flutter/material.dart';

class UniversityProvider extends ChangeNotifier {
  List<University>? currentUniversities;

  setUniversities(List<University> universities) {
    currentUniversities = universities;
    notifyListeners();
  }

  reset() {
    currentUniversities = null;
    notifyListeners();
  }
}
