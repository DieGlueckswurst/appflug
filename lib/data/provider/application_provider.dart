import 'package:appflug/data/classes/application.dart';
import 'package:appflug/data/classes/document.dart';
import 'package:appflug/data/classes/student.dart';
import 'package:appflug/enums/document_type.dart';
import 'package:flutter/material.dart';

class ApplicationProvider extends ChangeNotifier {
  List<Application>? applications;

  setApplications(List<Application>? _applications) {
    applications = _applications;
    notifyListeners();
  }

  acceptDocument({
    required Student student,
    required Document document,
  }) {
    int indexOfStudent = applications!.indexWhere(
      (application) => application.student.uid == student.uid,
    );

    applications![indexOfStudent].student.documents[document.type]!.isValid =
        true;

    applications![indexOfStudent]
        .student
        .documents[document.type]!
        .rejectionText = null;
    notifyListeners();
  }

  rejectDocument({
    required Student student,
    required Document document,
    required String rejectionText,
  }) {
    int indexOfStudent = applications!.indexWhere(
      (application) => application.student.uid == student.uid,
    );

    applications![indexOfStudent].student.documents[document.type]!.isValid =
        false;

    applications![indexOfStudent]
        .student
        .documents[document.type]!
        .rejectionText = rejectionText;
    notifyListeners();
  }

  removeApplicatoin({
    required Student student,
  }) {
    applications!.removeWhere(
      (application) => application.student.uid == student.uid,
    );
    notifyListeners();
  }

  bool isApplicationCompletelyReviewd({
    required Student student,
  }) {
    int indexOfStudent = applications!.indexWhere(
      (application) => application.student.uid == student.uid,
    );
    List<Document> documents =
        applications![indexOfStudent].student.documents.values.toList();

    for (Document doc in documents) {
      if (doc.type != DocumentType.preferenceList) {
        if (doc.isValid == null && doc.rejectionText == null) {
          return false;
        }
      }
    }
    return true;
  }

  bool isApplicationReadyForRejection({
    required Student student,
  }) {
    int indexOfStudent = applications!.indexWhere(
      (application) => application.student.uid == student.uid,
    );
    List<Document> documents =
        applications![indexOfStudent].student.documents.values.toList();

    for (Document doc in documents) {
      if (doc.type != DocumentType.preferenceList) {
        if (doc.rejectionText != null) {
          return true;
        }
      }
    }
    return false;
  }

  bool isApplicationReadyForAcception({
    required Student student,
  }) {
    int indexOfStudent = applications!.indexWhere(
      (application) => application.student.uid == student.uid,
    );
    List<Document> documents =
        applications![indexOfStudent].student.documents.values.toList();

    for (Document doc in documents) {
      if (doc.type != DocumentType.preferenceList) {
        if (doc.isValid == false) {
          return false;
        }
      }
    }
    return true;
  }
}
