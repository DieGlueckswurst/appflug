import 'package:appflug/data/backend/application.dart';
import 'package:appflug/data/backend/authentication.dart';
import 'package:appflug/data/backend/student.dart';
import 'package:appflug/data/classes/university.dart';
import 'package:appflug/data/provider/student_provider.dart';
import 'package:appflug/enums/application_status_option.dart';
import 'package:appflug/enums/courses.dart';
import 'package:appflug/enums/document_type.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/backend/base.dart';
import '../data/classes/student.dart';
import 'alert_service.dart';

class StudentService {
  static Student? getStudent(
    BuildContext context, {
    required bool listen,
  }) {
    return Provider.of<StudentProvider>(
      context,
      listen: listen,
    ).currentStudent;
  }

  static Future<void> initStudent({required BuildContext context}) async {
    var studentProvider = Provider.of<StudentProvider>(
      context,
      listen: false,
    );

    if (AuthenticationService.currentUser != null &&
        !studentProvider.isDeletingAccount) {
      Student student = await BackendService().getStudentData(
        uid: AuthenticationService.currentUser!.uid,
      );
      studentProvider.setStudent(
        student,
      );
      studentProvider.setDataIsRetrieved(
        true,
      );
    }
    return;
  }

  static Future<bool> setBirthplace({
    required BuildContext context,
    required String birthplace,
  }) async {
    StudentProvider studentProvider = Provider.of<StudentProvider>(
      context,
      listen: false,
    );
    studentProvider.setBirthplace(
      birthplace,
    );
    bool wasSuccessfull = await BackendService().setBirthplace(birthplace);

    if (wasSuccessfull) {
      if (getProfileIsComplete(context)) {
        studentProvider.setApplicationStatusOption(
          ApplicationStatusOption.incompleteDocuments,
        );
        return await BackendService().setApplicationStatus(
          studentProvider.currentStudent!.applicationStatus,
        );
      }
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> setCourse({
    required BuildContext context,
    required Course course,
  }) async {
    StudentProvider studentProvider = Provider.of<StudentProvider>(
      context,
      listen: false,
    );
    studentProvider.setCourse(
      course,
    );

    bool wasSuccessfull = await BackendService().setCourse(course);

    if (wasSuccessfull) {
      if (getProfileIsComplete(context)) {
        studentProvider.setApplicationStatusOption(
          ApplicationStatusOption.incompleteDocuments,
        );
        return await BackendService().setApplicationStatus(
          studentProvider.currentStudent!.applicationStatus,
        );
      }
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> setMatriculationNumber({
    required BuildContext context,
    required int matriculationNumber,
  }) async {
    StudentProvider studentProvider = Provider.of<StudentProvider>(
      context,
      listen: false,
    );
    studentProvider.setMatriculationNumber(
      matriculationNumber,
    );

    bool wasSuccessfull =
        await BackendService().setMatriculationNumber(matriculationNumber);

    if (wasSuccessfull) {
      if (getProfileIsComplete(context)) {
        studentProvider.setApplicationStatusOption(
          ApplicationStatusOption.incompleteDocuments,
        );
        return await BackendService().setApplicationStatus(
          studentProvider.currentStudent!.applicationStatus,
        );
      }
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> setEmail({
    required BuildContext context,
    required String email,
  }) async {
    StudentProvider studentProvider = Provider.of<StudentProvider>(
      context,
      listen: false,
    );
    studentProvider.setEmail(
      email,
    );

    return await BackendService().setEmail(
      email,
    );
  }

  static bool getProfileIsComplete(BuildContext context) {
    return Provider.of<StudentProvider>(
      context,
      listen: false,
    ).profileIsComplete;
  }

  static bool getAreDocumentsComplete(BuildContext context) {
    return Provider.of<StudentProvider>(
      context,
      listen: false,
    ).getAreDocumentsComplete();
  }

  static bool getIsValidPreference({
    required Student student,
    required University university,
  }) {
    return university.coursesOfStudy.contains(
      student.course,
    );
  }

  static Future<bool> reorderPreferenceList({
    required BuildContext context,
    required Student student,
    required String oldUniversityId,
    required String oldPosition,
    required String newUniversityId,
    required String newPosition,
  }) async {
    StudentProvider studentProvider = Provider.of<StudentProvider>(
      context,
      listen: false,
    );

    studentProvider.reorderUniInPreferenceList(
      oldUniversityId: oldUniversityId,
      oldPosition: oldPosition,
      newUniversityId: newUniversityId,
      newPosition: newPosition,
    );

    bool wasSuccessfull = await BackendService().reorderPreferenceList(
      oldUniversityId: oldUniversityId,
      oldPosition: oldPosition,
      newUniversityId: newUniversityId,
      newPosition: newPosition,
      documentId: student.documents[DocumentType.preferenceList]!.id!,
    );

    if (wasSuccessfull) {
      AlertService.showSnackBar(
        title: 'Erfolgreich gespeichert.',
        description:
            'Wenn du 3 Universitäten auf deiner Präferenzliste gespeicher hast, gilt dieses Dokument als vollständig.',
        isSuccess: true,
      );
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> setUniInPreferenceList({
    required BuildContext context,
    required Student student,
    required University university,
    required String position,
    required bool isRemoving,
  }) async {
    StudentProvider studentProvider = Provider.of<StudentProvider>(
      context,
      listen: false,
    );

    bool isValid = StudentService.getIsValidPreference(
      student: student,
      university: university,
    );

    if (isValid || isRemoving) {
      studentProvider.setUniInPreferenceList(
        universityId: isRemoving ? '' : university.id,
        position: position,
      );

      bool wasSuccessfull = await BackendService().setPreferenceList(
        universityId: isRemoving ? '' : university.id,
        position: position,
        documentId: student.documents[DocumentType.preferenceList]!.id!,
      );

      if (wasSuccessfull) {
        AlertService.showSnackBar(
          title: 'Erfolgreich gespeichert.',
          description:
              'Du kannst die Reihenfolge im Nachhinein auch noch ändern.',
          isSuccess: true,
        );
        if (StudentService.getAreDocumentsComplete(context)) {
          studentProvider.setApplicationStatusOption(
            ApplicationStatusOption.readyForApplication,
          );

          return await BackendService().setApplicationStatus(
            studentProvider.currentStudent!.applicationStatus,
          );
        }

        return true;
      } else {
        return false;
      }
    } else {
      AlertService.showSnackBar(
        title: 'Falscher Studiengang.',
        description:
            'Du kannst nur Universitäten, die deinen Studiengang anbieten, als Präferenz speichern.',
        isSuccess: false,
      );
      return false;
    }
  }

  static Future<bool> apply({
    required BuildContext context,
  }) async {
    StudentProvider studentProvider = Provider.of<StudentProvider>(
      context,
      listen: false,
    );

    Student student = StudentService.getStudent(
      context,
      listen: false,
    )!;
    bool wasSuccessfull = await BackendService().saveApplication(
      student: student,
    );

    if (wasSuccessfull) {
      studentProvider.setApplicationStatusOption(
        ApplicationStatusOption.documentsSubmitted,
      );

      AlertService.showSnackBar(
        title: 'Erfolgreich beworben.',
        description: 'Wir drücken dir die Daumen!',
        isSuccess: true,
      );
      return await BackendService().setApplicationStatus(
        studentProvider.currentStudent!.applicationStatus,
      );
    } else {
      return false;
    }
  }
}
