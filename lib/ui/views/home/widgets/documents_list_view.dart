import 'package:appflug/constants/measurements.dart';
import 'package:appflug/data/classes/document.dart';
import 'package:appflug/data/classes/student.dart';
import 'package:appflug/enums/document_type.dart';
import 'package:appflug/routes/views.dart';
import 'package:appflug/shared_utils/document_service.dart';
import 'package:appflug/ui/shared_widgets.dart/custom_list_tile.dart';
import 'package:flutter/material.dart';

class DocumentsListView extends StatefulWidget {
  final Student student;

  final bool isInSettings;

  const DocumentsListView({
    Key? key,
    required this.student,
    required this.isInSettings,
  }) : super(key: key);

  @override
  _DocumentsListViewState createState() => _DocumentsListViewState();
}

class _DocumentsListViewState extends State<DocumentsListView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: _buildChildren(),
    );
  }

  List<Widget> _buildChildren() {
    List<Document> documents = widget.student.documents.values.toList();
    documents = DocumentService.sortDocumentsAlphabetically(
      documents,
    );

    List<Widget> children = [];

    for (Document doc in documents) {
      if (doc.type == DocumentType.preferenceList) {
        if (doc.preferenceList!.containsValue('')) {
          children.add(
            CustomListTile(
              title: widget.isInSettings
                  ? 'Präferenzliste mit Wunschuniverstitäten'
                  : 'Präferenzliste mit Wunschuniverstitäten vervollständigen',
              onTap: () {
                Navigator.pushNamed(
                  context,
                  Views.preferenceList,
                );
              },
            ),
          );
          children.add(
            SizedBox(
              height: sidePadding,
            ),
          );
        }
      } else {
        if ((doc.downloadUrl == null &&
                doc.type != DocumentType.preferenceList) ||
            widget.isInSettings ||
            doc.rejectionText != null) {
          switch (doc.type) {
            case DocumentType.languageTest:
              children.add(
                CustomListTile(
                  title: widget.isInSettings
                      ? 'Aktuelles Sprachzeugnis'
                      : 'Aktuelle Sprachzeugnis hochladen',
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      Views.languageTest,
                      arguments: doc,
                    );
                  },
                ),
              );
              break;
            case DocumentType.letterOfMotivation:
              children.add(
                CustomListTile(
                  title: widget.isInSettings
                      ? 'Motivationsschreiben'
                      : 'Motivationsschreiben hochladen',
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      Views.letterOfMotivation,
                      arguments: doc,
                    );
                  },
                ),
              );
              break;
            case DocumentType.transcriptOfRecords:
              children.add(
                CustomListTile(
                  title: widget.isInSettings
                      ? 'Auflistung der bisher von Ihnen besuchten Studienveranstaltungen'
                      : 'Auflistung der bisher von Ihnen besuchten Studienveranstaltungen hochladen',
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      Views.transcriptOfRecords,
                      arguments: doc,
                    );
                  },
                ),
              );
              break;
            case DocumentType.preferenceList:
              break;
            case DocumentType.passport:
              children.add(
                CustomListTile(
                  title: widget.isInSettings
                      ? 'Kopie Ihres Personalausweises (EU, Norwegen, Schweiz) bzw. Reisepasses (alle anderen Länder)'
                      : 'Kopie Ihres Personalausweises (EU, Norwegen, Schweiz) bzw. Reisepasses (alle anderen Länder) hochladen',
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      Views.passport,
                      arguments: doc,
                    );
                  },
                ),
              );
              break;
          }

          children.add(
            SizedBox(
              height: sidePadding,
            ),
          );
        }
      }
    }
    return children;
  }
}
