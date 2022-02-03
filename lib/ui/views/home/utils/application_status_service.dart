import 'package:appflug/enums/application_status_option.dart';

class ApplicationStatusService {
  static ApplicationStatusOption getApplicationStatusOptionFromString(
    String stringOption,
  ) {
    return ApplicationStatusOption.values.toList().firstWhere(
          (option) => option.name == stringOption,
        );
  }

  static String getApplicationStatusTitleFromOption(
      ApplicationStatusOption option) {
    switch (option) {
      case ApplicationStatusOption.incompleteProfile:
        return 'Unvollständiges Profil';
      case ApplicationStatusOption.incompleteDocuments:
        return 'Unvollständige Dokumente';
      case ApplicationStatusOption.readyForApplication:
        return 'Bereit für Bewerbung';
      case ApplicationStatusOption.documentsSubmitted:
        return 'Bewerbung eingereicht';
      case ApplicationStatusOption.waitingForUniversity:
        return 'Warten auf Universität';
      case ApplicationStatusOption.rejectedDocuments:
        return 'Fehlerhafte Dokumente';
    }
  }
}
