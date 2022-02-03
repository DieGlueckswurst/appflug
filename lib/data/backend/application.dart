import 'package:appflug/data/backend/base.dart';
import 'package:appflug/data/classes/student.dart';
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
}
