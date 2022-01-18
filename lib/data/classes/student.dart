import 'package:appflug/data/classes/document.dart';
import 'package:appflug/enums/application_status_option.dart';

class Student {
  String? uid;
  String? email;
  int? matriculationNumber;
  String? course;
  String? birthplace;
  ApplicationStatusOption applicationStatus;
  List<Document?>? documents;

  Student({
    required this.applicationStatus,
    this.uid,
    this.email,
    this.matriculationNumber,
    this.course,
    this.birthplace,
    this.documents,
  });
}
