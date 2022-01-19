import 'dart:typed_data';

import 'package:appflug/enums/document_type.dart';
import 'package:appflug/shared_utils/document_service.dart';
import 'package:firebase_storage/firebase_storage.dart';

class BackendStorageService {
  static Future<String> savePdf({
    required Uint8List assetAsUint8List,
    required String fileName,
    required DocumentType documentType,
  }) async {
    String path = DocumentService.buildDocumentPathInStorage(
      documentType: documentType,
      fileName: fileName,
    );
    await FirebaseStorage.instanceFor().ref(path).putData(
          assetAsUint8List,
        );
    return FirebaseStorage.instance.ref(path).getDownloadURL();
  }
}
