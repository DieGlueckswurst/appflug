import 'package:appflug/data/backend/student.dart';
import 'package:appflug/data/provider/student_provider.dart';
import 'package:appflug/enums/application_status_option.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'backend/base.dart';
import 'classes/student.dart';

class StudentService {
  static Future<Student> getStudentData({required BuildContext context}) async {
    await Future.delayed(
      Duration(
        seconds: 2,
      ),
    );
    Student student = await BackendService().getStudentData();
    Provider.of<StudentProvider>(context, listen: false).setStudent(
      student,
    );
    return student;
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
    required String course,
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

  static bool getProfileIsComplete(BuildContext context) {
    return Provider.of<StudentProvider>(
      context,
      listen: false,
    ).profileIsComplete;
  }
}
