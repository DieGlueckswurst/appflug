import 'package:appflug/data/backend/base.dart';
import 'package:appflug/data/backend/student.dart';
import 'package:appflug/data/provider/student_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:provider/provider.dart';

class MatriculationNumberService {
  static const int matriculationNumberLength = 7;

  static bool isMatriculationNumber(String matriculationNumberString) {
    return GetUtils.isNumericOnly(matriculationNumberString) &&
        matriculationNumberString.length == matriculationNumberLength;
  }

  static Future<bool> saveMatriculationNumber({
    required BuildContext context,
    required int matriculationNumber,
  }) async {
    Provider.of<StudentProvider>(context, listen: false).setMatriculationNumber(
      matriculationNumber,
    );

    return await BackendService().setMatriculationNumber(matriculationNumber);
  }
}
