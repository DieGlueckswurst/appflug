extension StringService on String {
  String toFlagEmoji() {
    return toUpperCase().replaceAllMapped(
      RegExp(r'[A-Z]'),
      (match) => String.fromCharCode(
        match.group(0)!.codeUnitAt(0) + 127397,
      ),
    );
  }

  String removeLastCharacter() {
    return isNotEmpty
        ? substring(
            0,
            length - 1,
          )
        : '';
  }

  String toFullCountryName() {
    if (this == 'US') {
      return 'Vereinigte Staaten von Amerika';
    } else if (this == 'DE') {
      return 'Deutschland';
    } else if (this == 'CZ') {
      return 'Tschechien';
    } else if (this == 'GB') {
      return 'Vereinigtes Königreich';
    } else {
      return 'unbekanntes Land';
    }
  }

  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  static String getNameFromEmail(String email) {
    List<String> splittedEmail = email
        .substring(
          0,
          email.indexOf('@'),
        )
        .split('.');

    return splittedEmail.first + ' ' + splittedEmail.last.toCapitalized();
  }
}
