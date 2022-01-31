import 'dart:typed_data';

import 'package:appflug/data/classes/document.dart';
import 'package:appflug/data/student_service.dart';
import 'package:appflug/enums/document_type.dart';
import 'package:appflug/shared_utils/document_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class BackendStorageService {
  static Future<String> savePdf({
    required Uint8List assetAsUint8List,
    required String fileName,
    required DocumentType documentType,
    required BuildContext context,
  }) async {
    Document oldDocument = StudentService.getStudent(
      context,
      listen: false,
    )!
        .documents[documentType]!;

    if (oldDocument.downloadUrl != null) {
      await deleteDocument(oldDocument);
    }

    String path = DocumentService.buildDocumentPathInStorage(
      documentType: documentType,
      fileName: fileName,
    );
    await FirebaseStorage.instanceFor().ref(path).putData(
          assetAsUint8List,
        );
    return FirebaseStorage.instance.ref(path).getDownloadURL();
  }

  static Future<void> deleteDocument(Document document) async {
    await FirebaseStorage.instanceFor()
        .refFromURL(document.downloadUrl!)
        .delete();
  }

  static Future<void> deleteUser(BuildContext context) async {
    for (Document doc in StudentService.getStudent(
      context,
      listen: false,
    )!
        .documents
        .values) {
      if (doc.type != DocumentType.preferenceList && doc.downloadUrl != null) {
        await FirebaseStorage.instanceFor()
            .refFromURL(doc.downloadUrl!)
            .delete();
      }
    }
  }
}
