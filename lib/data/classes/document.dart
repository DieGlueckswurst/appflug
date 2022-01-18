import 'package:appflug/enums/document_type.dart';

class Document {
  String? id;
  DocumentType? type;
  String? storageLocation;
  String? downloadUrl;

  Document({
    this.id,
    this.type,
    this.storageLocation,
    this.downloadUrl,
  });
}
