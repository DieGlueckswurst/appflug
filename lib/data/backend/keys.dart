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
