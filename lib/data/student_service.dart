import 'package:appflug/data/backend/student.dart';
import 'package:appflug/data/provider/student_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'backend/base.dart';
import 'classes/student.dart';

class StudentService {
  static Future<Student> getStudentData({required BuildContext context}) async {
    Student student = await BackendService().getStudentData();
    Provider.of<StudentProvider>(context, listen: false).setStudent(
      student,
    );
    return student;
  }
}
