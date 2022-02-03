import 'package:appflug/data/backend/authentication.dart';
import 'package:appflug/data/backend/base.dart';
import 'package:appflug/data/classes/document.dart';
import 'package:appflug/data/classes/student.dart';
import 'package:appflug/enums/application_status_option.dart';
import 'package:appflug/enums/courses.dart';
import 'package:appflug/enums/document_type.dart';
import 'package:appflug/enums/status_option.dart';
import 'package:appflug/shared_utils/alert_service.dart';
import 'package:appflug/shared_utils/document_service.dart';
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

    var documentsCollectionRef = firestoreInstance
        .collection(keys.getKeyFromStatusOption(statusOption))
        .doc(uid)
        .collection(keys.documents);

    for (var documentType in DocumentType.values) {
      var docRef = documentsCollectionRef.doc();

      await docRef.set({
        keys.documentType: documentType.name,
        keys.id: docRef.id,
      });

      if (documentType == DocumentType.preferenceList) {
        await docRef.set(
          {
            keys.preferenceList: {
              '1': '',
              '2': '',
              '3': '',
            },
          },
          SetOptions(
            merge: true,
          ),
        );
      }
    }
  }

  Future<Student> getStudentData({
    required String uid,
  }) async {
    var docSnapshot =
        await firestoreInstance.collection(keys.studs).doc(uid).get();
    Map<String, dynamic>? docData = docSnapshot.data();
    Student student = Student(
      email: docData?[keys.email],
      matriculationNumber: docData?[keys.matriculationNumber],
      applicationStatus:
          ApplicationStatusService.getApplicationStatusOptionFromString(
        docData?[keys.applicationStatus],
      ),
      course: docData?[keys.course] != null
          ? Course.values.byName(docData?[keys.course])
          : null,
      birthplace: docData?[keys.birthplace],
      uid: docData?[keys.uid],
      documents: {},
    );

    var documentQuerySnapshot = await firestoreInstance
        .collection(keys.studs)
        .doc(uid)
        .collection(keys.documents)
        .get();
    for (var doc in documentQuerySnapshot.docs) {
      Map<String, dynamic> data = doc.data();
      DocumentType documentType = DocumentService.getDocumentTypeFromString(
        data[keys.documentType],
      );
      if (documentType == DocumentType.preferenceList) {
        student.documents[documentType] = Document(
          id: data[keys.id],
          type: documentType,
          preferenceList: Map<String, String>.from(
            data[keys.preferenceList],
          ),
          rejectionText: data[keys.rejectionText],
        );
      } else {
        student.documents[documentType] = Document(
          id: data[keys.id],
          type: documentType,
          storageLocation: data[keys.storageLocation],
          downloadUrl: data[keys.downloadUrl],
          name: data[keys.name],
          rejectionText: data[keys.rejectionText],
        );
      }
    }
    return student;
  }

  Future<bool> setApplicationStatus(ApplicationStatusOption status) async {
    try {
      await firestoreInstance
          .collection(keys.studs)
          .doc(AuthenticationService.currentUser!.uid)
          .set(
        {
          keys.applicationStatus: status.name,
        },
        SetOptions(
          merge: true,
        ),
      );
      return true;
    } on FirebaseException catch (e) {
      AlertService.showSnackBar(
        title: 'Status speichern fehlgeschlagen',
        description: e.message ?? '',
        isSuccess: false,
      );
      return false;
    }
  }

  Future<bool> setEmail(String email) async {
    try {
      await firestoreInstance
          .collection(keys.studs)
          .doc(AuthenticationService.currentUser!.uid)
          .set(
        {
          keys.email: email,
        },
        SetOptions(
          merge: true,
        ),
      );
      return true;
    } on FirebaseException catch (e) {
      AlertService.showSnackBar(
        title: 'Email speichern fehlgeschlagen',
        description: e.message ?? '',
        isSuccess: false,
      );
      return false;
    }
  }

  Future<bool> setMatriculationNumber(int matriculationNumber) async {
    try {
      await firestoreInstance
          .collection(keys.studs)
          .doc(AuthenticationService.currentUser!.uid)
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

  Future<bool> setBirthplace(String birthplace) async {
    try {
      await firestoreInstance
          .collection(keys.studs)
          .doc(AuthenticationService.currentUser!.uid)
          .set(
        {
          keys.birthplace: birthplace,
        },
        SetOptions(
          merge: true,
        ),
      );
      return true;
    } on FirebaseException catch (e) {
      AlertService.showSnackBar(
        title: 'Geburtsort speichern fehlgeschlagen',
        description: e.message ?? '',
        isSuccess: false,
      );
      return false;
    }
  }

  Future<bool> setCourse(Course course) async {
    try {
      await firestoreInstance
          .collection(keys.studs)
          .doc(AuthenticationService.currentUser!.uid)
          .set(
        {
          keys.course: course.name,
        },
        SetOptions(
          merge: true,
        ),
      );
      return true;
    } on FirebaseException catch (e) {
      AlertService.showSnackBar(
        title: 'Studiengang speichern fehlgeschlagen',
        description: e.message ?? '',
        isSuccess: false,
      );
      return false;
    }
  }

  Future<bool> setDocument({
    required String downloadUrl,
    required String fileName,
    required DocumentType documentType,
    required String documentId,
  }) async {
    try {
      String documentLocation = DocumentService.buildDocumentPathInStorage(
        documentType: documentType,
        fileName: fileName,
      );
      await firestoreInstance
          .collection(keys.studs)
          .doc(AuthenticationService.currentUser!.uid)
          .collection(keys.documents)
          .doc(documentId)
          .set(
        {
          keys.name: fileName,
          keys.downloadUrl: downloadUrl,
          keys.storageLocation: documentLocation,
          keys.rejectionText: FieldValue.delete(),
        },
        SetOptions(
          merge: true,
        ),
      );
      return true;
    } on FirebaseException catch (e) {
      AlertService.showSnackBar(
        title: '$fileName speichern fehlgeschlagen',
        description: e.message ?? '',
        isSuccess: false,
      );
      return false;
    }
  }

  Future<bool> setPreferenceList({
    required String universityId,
    required String position,
    required String documentId,
  }) async {
    try {
      await firestoreInstance
          .collection(keys.studs)
          .doc(AuthenticationService.currentUser!.uid)
          .collection(keys.documents)
          .doc(documentId)
          .update(
        {
          '${keys.preferenceList}.$position': universityId,
        },
      );
      return true;
    } on FirebaseException catch (e) {
      AlertService.showSnackBar(
        title: 'Liste speichern fehlgeschlagen',
        description: e.message ?? '',
        isSuccess: false,
      );
      return false;
    }
  }

  Future<bool> reorderPreferenceList({
    required String oldUniversityId,
    required String oldPosition,
    required String newUniversityId,
    required String newPosition,
    required String documentId,
  }) async {
    try {
      await firestoreInstance
          .collection(keys.studs)
          .doc(AuthenticationService.currentUser!.uid)
          .collection(keys.documents)
          .doc(documentId)
          .update(
        {
          '${keys.preferenceList}.$newPosition': oldUniversityId,
          '${keys.preferenceList}.$oldPosition': newUniversityId,
        },
      );
      return true;
    } on FirebaseException catch (e) {
      AlertService.showSnackBar(
        title: 'Liste speichern fehlgeschlagen',
        description: e.message ?? '',
        isSuccess: false,
      );
      return false;
    }
  }

  Future<bool> deleteUser() async {
    try {
      await firestoreInstance
          .collection(keys.studs)
          .doc(AuthenticationService.currentUser!.uid)
          .delete();
      return true;
    } on FirebaseException catch (e) {
      AlertService.showSnackBar(
        title: 'Fehler',
        description: e.message ?? '',
        isSuccess: false,
      );
      return false;
    }
  }

  Future<String?> getEmailForUser({
    required String uid,
  }) async {
    try {
      dynamic doc =
          await firestoreInstance.collection(keys.studs).doc(uid).get();

      Map<String, dynamic> data = doc.data();

      return data[keys.email];
    } on FirebaseException catch (e) {
      AlertService.showSnackBar(
        title: 'Fehler',
        description: e.message ?? '',
        isSuccess: false,
      );
      return null;
    }
  }
}
