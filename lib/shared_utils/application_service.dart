import 'package:appflug/data/backend/application.dart';
import 'package:appflug/data/backend/base.dart';
import 'package:appflug/data/classes/application.dart';
import 'package:appflug/data/provider/application_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ApplicationService {
  static Future<void> initApplicationsData(BuildContext context) async {
    List<Application> applications =
        await BackendService().getApplicationData();
    Provider.of<ApplicationProvider>(
      context,
      listen: false,
    ).setApplications(
      applications,
    );
  }

  static List<Application>? getApplications(BuildContext context) {
    return Provider.of<ApplicationProvider>(
      context,
      listen: false,
    ).applications;
  }
}
