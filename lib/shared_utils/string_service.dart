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
    } else {
      return 'unbekannte Land';
    }
  }
}
