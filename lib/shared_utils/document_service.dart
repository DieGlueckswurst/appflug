import 'package:appflug/enums/document_type.dart';

class DocumentService {
  static DocumentType getDocumentTypeFromString(String docTypeString) {
    return DocumentType.values.firstWhere(
      (docType) => docType.name == docTypeString,
    );
  }
}
