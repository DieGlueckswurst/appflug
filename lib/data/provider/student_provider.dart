import 'package:appflug/data/classes/student.dart';
import 'package:flutter/material.dart';

class StudentProvider extends ChangeNotifier {
  Student? currentStudent;

  setStudent(Student student) {
    currentStudent = student;
    notifyListeners();
  }
}
