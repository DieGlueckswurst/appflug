import 'dart:io';
import 'dart:typed_data';

import 'package:appflug/data/backend/authentication.dart';
import 'package:appflug/data/backend/base.dart';
import 'package:appflug/data/backend/storage.dart';
import 'package:appflug/data/backend/student.dart';
import 'package:appflug/data/classes/document.dart';
import 'package:appflug/data/provider/student_provider.dart';
import 'package:appflug/enums/application_status_option.dart';
import 'package:appflug/enums/document_type.dart';
import 'package:appflug/shared_utils/student_service.dart';
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
    return '${BackendService().keys.studs}/${AuthenticationService.currentUser?.uid}/${documentType.name}/$fileName';
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
      context: context,
    );

    bool wasSuccessfull = await BackendService().setDocument(
      downloadUrl: downloadUrl,
      fileName: fileName,
      documentType: documentType,
      documentId: documentId,
    );

    StudentProvider studentProvider = Provider.of<StudentProvider>(
      context,
      listen: false,
    );

    studentProvider.setDocument(
      Document(
        type: documentType,
        id: documentId,
        name: fileName,
        downloadUrl: downloadUrl,
        storageLocation: DocumentService.buildDocumentPathInStorage(
          documentType: documentType,
          fileName: fileName,
        ),
        rejectionText: null,
        isValid: true,
      ),
    );

    if (wasSuccessfull) {
      if (StudentService.getAreDocumentsComplete(context)) {
        studentProvider.setApplicationStatusOption(
          ApplicationStatusOption.readyForApplication,
        );
        return await BackendService().setApplicationStatus(
          studentProvider.currentStudent!.applicationStatus,
        );
      }
      return true;
    } else {
      return false;
    }
  }

  static String getDocumentTitleFromType(DocumentType type) {
    switch (type) {
      case DocumentType.languageTest:
        return 'Sprachzeugnis';
      case DocumentType.letterOfMotivation:
        return 'Motivationsschreiben';
      case DocumentType.transcriptOfRecords:
        return 'Transcript of Records';
      case DocumentType.preferenceList:
        return 'Präferenzliste';
      case DocumentType.passport:
        return 'Personalausweis/Reisepass';
    }
  }

  static List<Document> sortDocumentsAlphabetically(List<Document> documents) {
    documents.sort(
      (docA, docB) => getDocumentTitleFromType(
        docA.type,
      ).compareTo(
        getDocumentTitleFromType(
          docB.type,
        ),
      ),
    );
    return documents;
  }
}
