class PasswordRegex {
  static final RegExp atLeastOneUpperAndOneLowerCaseLetter = RegExp(
    '^(?=.*?[A-Z])(?=.*?[a-z])',
  );

  static final RegExp atLeastOneDigit = RegExp(
    '^(?=.*?[0-9])',
  );

  static final RegExp atLeast8Characters = RegExp(
    '^.{8,}',
  );
}
