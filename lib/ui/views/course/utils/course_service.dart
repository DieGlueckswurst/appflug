import 'package:appflug/enums/courses.dart';

class CourseService {
  static const List<Course> courses = Course.values;

  static String enumToString(Course course) {
    switch (course) {
      case Course.angewandteInformatik:
        return 'Angewandte Informatik';
      case Course.computingInHumanities:
        return 'Computing in the Humanities';
      case Course.informatikSoftwareSystemScience:
        return 'Informatik: Software Systems Science';
      case Course.internationalInformationSystemScience:
        return 'International Information System Science';
      case Course.wirtschaftsInformatik:
        return 'Wirtschaftsinformatik';
    }
  }
}
