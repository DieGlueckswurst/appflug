import 'package:get/utils.dart';

class MatriculationNumberService {
  static const int matriculationNumberLength = 7;

  static bool isMatriculationNumber(String matriculationNumberString) {
    return GetUtils.isNumericOnly(matriculationNumberString) &&
        matriculationNumberString.length == matriculationNumberLength;
  }
}
