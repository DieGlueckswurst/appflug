import 'package:appflug/data/classes/student.dart';

class Application {
  final int dateTimeInMilliSecondsSinceEpoch;
  Student student;

  Application({
    required this.dateTimeInMilliSecondsSinceEpoch,
    required this.student,
  });
}
