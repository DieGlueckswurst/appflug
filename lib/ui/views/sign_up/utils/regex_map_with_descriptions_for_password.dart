import 'package:appflug/ui/views/sign_up/utils/regex_for_password.dart';

final Map<RegExp, String> regexMapWithDescriptionsForPassword = {
  PasswordRegex.atLeastOneUpperAndOneLowerCaseLetter:
      'mindestens ein Groß- & Kleinbuchstabe',
  PasswordRegex.atLeastOneDigit: 'mindestens eine Ziffer',
  PasswordRegex.atLeast8Characters: 'mindestens 8 Zeichen',
};
