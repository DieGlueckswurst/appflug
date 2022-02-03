import 'package:appflug/data/classes/document.dart';
import 'package:appflug/data/classes/student.dart';
import 'package:appflug/enums/application_status_option.dart';
import 'package:appflug/enums/courses.dart';
import 'package:appflug/enums/document_type.dart';
import 'package:flutter/material.dart';

class StudentProvider extends ChangeNotifier {
  Student? currentStudent;
  bool dataIsRetrieved = false;

  setStudent(Student? student) {
    currentStudent = student;
    notifyListeners();
  }

  setEmail(String email) {
    currentStudent?.email = email;
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

  setCourse(Course course) {
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

  setUniInPreferenceList({
    required String universityId,
    required String position,
  }) {
    currentStudent?.documents[DocumentType.preferenceList]!
        .preferenceList![position] = universityId;
    notifyListeners();
  }

  reorderUniInPreferenceList({
    required String oldUniversityId,
    required String oldPosition,
    required String newUniversityId,
    required String newPosition,
  }) {
    currentStudent?.documents[DocumentType.preferenceList]!
        .preferenceList![newPosition] = oldUniversityId;

    currentStudent?.documents[DocumentType.preferenceList]!
        .preferenceList![oldPosition] = newUniversityId;
    notifyListeners();
  }

  setDataIsRetrieved(bool isRetrieved) {
    dataIsRetrieved = isRetrieved;
    notifyListeners();
  }

  reset() {
    dataIsRetrieved = false;
    currentStudent = null;
    notifyListeners();
  }

  bool get profileIsComplete =>
      currentStudent?.matriculationNumber != null &&
      currentStudent?.birthplace != null &&
      currentStudent?.course != null;

  bool getAreDocumentsComplete() {
    for (Document doc in currentStudent!.documents.values.toList()) {
      if (doc.type == DocumentType.preferenceList) {
        if (doc.preferenceList!.containsValue('')) {
          return false;
        }
      } else {
        if (doc.downloadUrl == null) {
          return false;
        }
      }
    }
    return true;
  }
}
