import 'package:appflug/data/backend/authentication.dart';
import 'package:appflug/data/backend/base.dart';
import 'package:appflug/data/classes/student.dart';
import 'package:appflug/enums/application_status_option.dart';
import 'package:appflug/enums/status_option.dart';
import 'package:appflug/shared_utils/alert_service.dart';
import 'package:appflug/ui/views/home/utils/application_status_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

extension StudentBackendService on BackendService {
  Future<void> createUserInDatabase({
    required String uid,
    required StatusOption statusOption,
    required String email,
  }) async {
    await firestoreInstance
        .collection(keys.getKeyFromStatusOption(statusOption))
        .doc(uid)
        .set(
      {
        keys.uid: uid,
        keys.status: statusOption.name,
        keys.applicationStatus: ApplicationStatusOption.incompleteProfile.name,
        keys.email: email,
      },
    );
  }

  Future<Student> getStudentData() async {
    var docSnapshot = await firestoreInstance
        .collection(keys.studs)
        .doc(AuthenticationService().currentUser!.uid)
        .get();
    Map<String, dynamic>? docData = docSnapshot.data();
    return Student(
      email: docData?[keys.email],
      matriculationNumber: docData?[keys.matriculationNumber],
      applicationStatus:
          ApplicationStatusService.getApplicationStatusOptionFromString(
        docData?[keys.applicationStatus],
      ),
      course: docData?[keys.course],
      birthplace: docData?[keys.birthplace],
    );
  }

  Future<bool> setMatriculationNumber(int matriculationNumber) async {
    try {
      await firestoreInstance
          .collection(keys.studs)
          .doc(AuthenticationService().currentUser!.uid)
          .set(
        {
          keys.matriculationNumber: matriculationNumber,
        },
        SetOptions(
          merge: true,
        ),
      );
      return true;
    } on FirebaseException catch (e) {
      AlertService.showSnackBar(
        title: 'Matrikelnummer speichern fehlgeschlagen',
        description: e.message ?? '',
        isSuccess: false,
      );
      return false;
    }
  }
}
