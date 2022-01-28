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
  String get preferenceList => 'preferenceList';
  String get passport => 'passport';
  String get documentType => 'documentType';
  String get id => 'id';
  String get storageLocation => 'storageLocation';
  String get downloadUrl => 'downloadUrl';
  String get name => 'name';
  String get countryCode => 'countryCode';
  String get city => 'city';
  String get description => 'description';
  String get requiredGPA => 'requiredGPA';
  String get websiteUrl => 'websiteUrl';
  String get logoStorageLocation => 'logoStorageLocation';
  String get logoDownloadUrl => 'logoDownloadUrl';
  String get userId => 'userId';
  String get universityId => 'universityId';
  String get average => 'average';
  String get professors => 'professors';
  String get lectures => 'lectures';
  String get equipment => 'equipment';
  String get freetimeActivities => 'freetimeActivities';
  String get internationality => 'internationality';
  String get universities => 'universities';
  String get reviews => 'reviews';
  String get images => 'images';
  String get location => 'location';
  String get index => 'index';
  String get addedAtInMilliSecondsSinceEpoch =>
      'addedAtInMilliSecondsSinceEpoch';
  String get coursesOfStudy => 'coursesOfStudy';

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
