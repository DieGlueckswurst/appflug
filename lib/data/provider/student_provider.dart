import 'package:appflug/data/classes/student.dart';
import 'package:flutter/material.dart';

class StudentProvider extends ChangeNotifier {
  Student? currentStudent;

  setStudent(Student student) {
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
}
