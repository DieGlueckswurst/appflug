import 'package:appflug/data/classes/document.dart';
import 'package:appflug/data/classes/student.dart';
import 'package:appflug/enums/application_status_option.dart';
import 'package:flutter/material.dart';

class StudentProvider extends ChangeNotifier {
  Student? currentStudent;
  bool dataIsRetrieved = false;

  setStudent(Student? student) {
    currentStudent = student;
    notifyListeners();
  }

  setMatriculationNumber(int matriculationNumber) {
    currentStudent?.matriculationNumber = matriculationNumber;
    notifyListeners();
  }

  setBirthplace(String birthplace) {
    currentStudent?.birthplace = birthplace;
    notifyListeners();
  }

  setCourse(String course) {
    currentStudent?.course = course;
    notifyListeners();
  }

  setApplicationStatusOption(ApplicationStatusOption status) {
    currentStudent?.applicationStatus = status;
    notifyListeners();
  }

  setDocument(Document document) {
    currentStudent?.documents[document.type] = document;
    notifyListeners();
  }

  setDataIsRetrieved(bool isRetrieved) {
    dataIsRetrieved = isRetrieved;
    notifyListeners();
  }

  bool get profileIsComplete =>
      currentStudent?.matriculationNumber != null &&
      currentStudent?.birthplace != null &&
      currentStudent?.course != null;
}
