import 'package:appflug/enums/status_option.dart';

class BackendKeys {
  const BackendKeys();
  String get users => 'users';
  String get studs => 'studs';
  String get empls => 'empls';
  String get email => 'email';
  String get password => 'password';
  String get uid => 'uid';
  String get status => 'status';
  String get applicationStatus => 'application_status';
  String get birthplace => 'birthplace';
  String get course => 'course';
  String get matriculationNumber => 'matriculationNumber';
  String get documents => 'documents';
  String get languageTest => 'languageTest';
  String get letterOfMotivation => 'letterOfMotivation';
  String get transcriptOfRecords => 'transcriptOfRecords';
  String get visa => 'visa';
  String get passport => 'passport';
  String get documentType => 'documentType';
  String get id => 'id';
  String get storageLocation => 'storageLocation';
  String get downloadUrl => 'downloadUrl';

  String getKeyFromStatusOption(StatusOption statusOption) {
    if (statusOption == StatusOption.stud) {
      return studs;
    } else if (statusOption == StatusOption.empl) {
      return empls;
    } else {
      return 'unknown status';
    }
  }
}
