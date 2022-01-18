import 'package:appflug/enums/document_type.dart';

class Document {
  String? id;
  DocumentType type;
  String? storageLocation;
  String? downloadUrl;

  Document({
    required this.type,
    this.id,
    this.storageLocation,
    this.downloadUrl,
  });
}
