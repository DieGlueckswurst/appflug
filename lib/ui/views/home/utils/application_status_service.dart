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
        return 'unvollständiges Profil';
      case ApplicationStatusOption.incompleteDocuments:
        return 'unvollständige Dokumente';
      case ApplicationStatusOption.readyForApplication:
        return 'bereit für Bewerbung';
      case ApplicationStatusOption.documentsSubmitted:
        return 'Bewerbung eingereicht';
      case ApplicationStatusOption.waitingForUniversity:
        return 'warten auf Universität';
    }
  }
}
