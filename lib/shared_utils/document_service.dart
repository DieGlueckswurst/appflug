import 'dart:io';
import 'dart:typed_data';

import 'package:appflug/data/backend/authentication.dart';
import 'package:appflug/data/backend/base.dart';
import 'package:appflug/data/backend/storage.dart';
import 'package:appflug/data/backend/student.dart';
import 'package:appflug/data/classes/document.dart';
import 'package:appflug/data/provider/student_provider.dart';
import 'package:appflug/enums/document_type.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DocumentService {
  static DocumentType getDocumentTypeFromString(String docTypeString) {
    return DocumentType.values.firstWhere(
      (docType) => docType.name == docTypeString,
    );
  }

  static String buildDocumentPathInStorage({
    required DocumentType documentType,
    required String fileName,
  }) {
    return '${BackendService().keys.studs}/${AuthenticationService().currentUser?.uid}/${documentType.name}/$fileName';
  }

  static Future<bool> savePdf({
    required PlatformFile pickedFile,
    required String fileName,
    required DocumentType documentType,
    required String documentId,
    required BuildContext context,
  }) async {
    Uint8List assetAsUint8List = kIsWeb
        ? pickedFile.bytes!
        : File(
            pickedFile.path!,
          ).readAsBytesSync();
    String downloadUrl = await BackendStorageService.savePdf(
      assetAsUint8List: assetAsUint8List,
      fileName: fileName,
      documentType: documentType,
    );

    bool wasSuccessfull = await BackendService().setDocument(
      downloadUrl: downloadUrl,
      fileName: fileName,
      documentType: documentType,
      documentId: documentId,
    );

    Provider.of<StudentProvider>(context, listen: false).setDocument(
      Document(
        type: documentType,
        id: documentId,
        name: fileName,
        downloadUrl: downloadUrl,
        storageLocation: DocumentService.buildDocumentPathInStorage(
          documentType: documentType,
          fileName: fileName,
        ),
      ),
    );

    return wasSuccessfull;
  }
}