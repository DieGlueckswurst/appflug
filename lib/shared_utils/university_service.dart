import 'package:appflug/data/backend/authentication.dart';
import 'package:appflug/data/backend/university.dart';
import 'package:appflug/data/classes/university.dart';
import 'package:appflug/data/provider/university_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UniversityService {
  static Future initUniversities(BuildContext context) async {
    if (AuthenticationService.currentUser != null) {
      List<University> universities =
          await UniversityBackendService().getUniversities();
      Provider.of<UniversityProvider>(
        context,
        listen: false,
      ).setUniversities(
        universities,
      );
    }
  }

  static List<University>? getUniversities({
    required BuildContext context,
    required bool listen,
  }) {
    return Provider.of<UniversityProvider>(
      context,
      listen: listen,
    ).currentUniversities;
  }
}
