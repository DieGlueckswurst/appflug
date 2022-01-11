import 'package:appflug/enums/application_status_option.dart';

class Student {
  String? email;
  int? matriculationNumber;
  String? course;
  String? birthplace;
  ApplicationStatusOption applicationStatus;

  Student({
    required this.applicationStatus,
    this.email,
    this.matriculationNumber,
    this.course,
    this.birthplace,
  });
}
