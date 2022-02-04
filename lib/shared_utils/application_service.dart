import 'package:appflug/data/backend/application.dart';
import 'package:appflug/data/backend/base.dart';
import 'package:appflug/data/classes/application.dart';
import 'package:appflug/data/classes/document.dart';
import 'package:appflug/data/classes/student.dart';
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

  static List<Application>? getApplications({
    required BuildContext context,
    required bool listen,
  }) {
    return Provider.of<ApplicationProvider>(
      context,
      listen: listen,
    ).applications;
  }

  static Future<bool> acceptDocument({
    required BuildContext context,
    required Student student,
    required Document document,
  }) async {
    Provider.of<ApplicationProvider>(
      context,
      listen: false,
    ).acceptDocument(
      student: student,
      document: document,
    );

    return await BackendService().acceptDocument(
      studentId: student.uid!,
      documentId: document.id!,
    );
  }

  static Future<bool> rejectDocument(
      {required BuildContext context,
      required Student student,
      required Document document,
      required String rejectionText}) async {
    Provider.of<ApplicationProvider>(
      context,
      listen: false,
    ).rejectDocument(
      student: student,
      document: document,
      rejectionText: rejectionText,
    );

    return await BackendService().rejectDocument(
      studentId: student.uid!,
      documentId: document.id!,
      rejectionText: rejectionText,
    );
  }

  static Future<bool> rejectApplication({
    required BuildContext context,
    required Student student,
  }) async {
    Provider.of<ApplicationProvider>(
      context,
      listen: false,
    ).removeApplicatoin(
      student: student,
    );

    return await BackendService().rejectApplication(
      studentId: student.uid!,
    );
  }

  static Future<bool> acceptApplication({
    required BuildContext context,
    required Student student,
  }) async {
    Provider.of<ApplicationProvider>(
      context,
      listen: false,
    ).removeApplicatoin(
      student: student,
    );

    return await BackendService().acceptApplication(
      studentId: student.uid!,
    );
  }

  static bool isApplicationCompletelyReviewd({
    required BuildContext context,
    required Student student,
  }) {
    return Provider.of<ApplicationProvider>(
      context,
      listen: false,
    ).isApplicationCompletelyReviewd(
      student: student,
    );
  }

  static bool isApplicationReadyForAcception({
    required BuildContext context,
    required Student student,
  }) {
    return Provider.of<ApplicationProvider>(
      context,
      listen: false,
    ).isApplicationReadyForAcception(
      student: student,
    );
  }

  static bool isApplicationReadyForRejection({
    required BuildContext context,
    required Student student,
  }) {
    return Provider.of<ApplicationProvider>(
      context,
      listen: false,
    ).isApplicationReadyForRejection(
      student: student,
    );
  }

  static void resetApplications({
    required BuildContext context,
  }) {
    Provider.of<ApplicationProvider>(
      context,
      listen: false,
    ).setApplications(
      null,
    );
  }
}
