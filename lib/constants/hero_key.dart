import 'package:appflug/data/classes/university.dart';

class HeroKeys {
  static String get buttonKeyAsStud => 'buttonKeyAsStud';
  static String get buttonKeysAsEmpl => 'buttonKeysAsEmpl';
  static String get backButton => 'backButton';
  static String get header => 'header';

  static String getKeyFromUniversity(University university) {
    return university.name;
  }
}
