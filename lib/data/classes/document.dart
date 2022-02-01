import 'package:appflug/enums/document_type.dart';

class Document {
  String? id;
  String? name;
  DocumentType type;
  String? storageLocation;
  String? downloadUrl;
  Map<String, String>? preferenceList;

  Document({
    required this.type,
    this.id,
    this.storageLocation,
    this.downloadUrl,
    this.name,
    this.preferenceList,
  });
}
