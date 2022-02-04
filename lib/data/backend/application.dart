import 'package:appflug/data/backend/base.dart';
import 'package:appflug/data/backend/student.dart';
import 'package:appflug/data/classes/application.dart';
import 'package:appflug/data/classes/student.dart';
import 'package:appflug/enums/application_status_option.dart';
import 'package:appflug/shared_utils/alert_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

extension ApplicationBackendService on BackendService {
  Future<bool> saveApplication({
    required Student student,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection(keys.applications)
          .doc(student.uid)
          .set(
        {
          keys.studentId: student.uid,
          keys.dateDateInMillisecondsSinceEpoch:
              DateTime.now().millisecondsSinceEpoch,
        },
      );
      return true;
    } on FirebaseException catch (e) {
      AlertService.showSnackBar(
        title: 'Bewerbung speichern fehlgeschlagen',
        description: e.message ?? '',
        isSuccess: false,
      );
      return false;
    }
  }

  Future<bool> rejectDocument({
    required String studentId,
    required String documentId,
    required String rejectionText,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection(keys.studs)
          .doc(studentId)
          .collection(keys.documents)
          .doc(documentId)
          .set(
        {
          keys.rejectionText: rejectionText,
          keys.isValid: false,
        },
        SetOptions(
          merge: true,
        ),
      );
      return true;
    } on FirebaseException catch (e) {
      AlertService.showSnackBar(
        title: 'Ablehnen fehlgeschlagen',
        description: e.message ?? '',
        isSuccess: false,
      );
      return false;
    }
  }

  Future<bool> acceptDocument({
    required String studentId,
    required String documentId,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection(keys.studs)
          .doc(studentId)
          .collection(keys.documents)
          .doc(documentId)
          .set(
        {
          keys.isValid: true,
          keys.rejectionText: FieldValue.delete(),
        },
        SetOptions(
          merge: true,
        ),
      );
      return true;
    } on FirebaseException catch (e) {
      AlertService.showSnackBar(
        title: 'Annehmen fehlgeschlagen',
        description: e.message ?? '',
        isSuccess: false,
      );
      return false;
    }
  }

  Future<bool> deleteApplication({
    required String studentId,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection(keys.applications)
          .doc(studentId)
          .delete();

      return true;
    } on FirebaseException catch (e) {
      AlertService.showSnackBar(
        title: 'Bewerbungen löschen fehlgeschlagen',
        description: e.message ?? '',
        isSuccess: false,
      );
      return false;
    }
  }

  Future<bool> acceptApplication({
    required String studentId,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection(keys.studs)
          .doc(studentId)
          .set(
        {
          keys.applicationStatus:
              ApplicationStatusOption.waitingForUniversity.name,
        },
        SetOptions(
          merge: true,
        ),
      );
      return await deleteApplication(
        studentId: studentId,
      );
    } on FirebaseException catch (e) {
      AlertService.showSnackBar(
        title: 'Annehmen fehlgeschlagen',
        description: e.message ?? '',
        isSuccess: false,
      );
      return false;
    }
  }

  Future<bool> rejectApplication({
    required String studentId,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection(keys.studs)
          .doc(studentId)
          .set(
        {
          keys.applicationStatus:
              ApplicationStatusOption.rejectedDocuments.name,
        },
        SetOptions(
          merge: true,
        ),
      );
      return await deleteApplication(
        studentId: studentId,
      );
    } on FirebaseException catch (e) {
      AlertService.showSnackBar(
        title: 'Annehmen fehlgeschlagen',
        description: e.message ?? '',
        isSuccess: false,
      );
      return false;
    }
  }

  Future<List<Application>> getApplicationData() async {
    List<Application> applications = [];
    var documentQuerySnapshot =
        await firestoreInstance.collection(keys.applications).get();
    for (var doc in documentQuerySnapshot.docs) {
      Map<String, dynamic> data = doc.data();

      applications.add(
        Application(
          dateTimeInMilliSecondsSinceEpoch:
              data[keys.dateDateInMillisecondsSinceEpoch],
          student: await BackendService().getStudentData(
            uid: data[keys.studentId],
          ),
        ),
      );
    }

    return applications;
  }
}
