import 'package:appflug/data/classes/document.dart';
import 'package:appflug/enums/application_status_option.dart';
import 'package:appflug/enums/courses.dart';
import 'package:appflug/enums/document_type.dart';

class Student {
  String? uid;
  String? email;
  int? matriculationNumber;
  Course? course;
  String? birthplace;
  ApplicationStatusOption applicationStatus;
  Map<DocumentType, Document> documents;

  Student({
    required this.applicationStatus,
    required this.documents,
    this.uid,
    this.email,
    this.matriculationNumber,
    this.course,
    this.birthplace,
  });
}
