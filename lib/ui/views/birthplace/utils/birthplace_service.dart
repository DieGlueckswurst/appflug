import 'package:appflug/data/backend/base.dart';
import 'package:appflug/data/backend/student.dart';
import 'package:appflug/data/provider/student_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BirthplaceService {
  static Future<bool> setBirthplace({
    required BuildContext context,
    required String birthplace,
  }) async {
    Provider.of<StudentProvider>(context, listen: false).setBirthplace(
      birthplace,
    );
    return await BackendService().setBirthplace(birthplace);
  }
}
