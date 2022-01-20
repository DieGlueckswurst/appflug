import 'package:appflug/data/classes/document.dart';
import 'package:appflug/data/classes/student.dart';
import 'package:appflug/data/provider/student_provider.dart';
import 'package:appflug/enums/document_type.dart';
import 'package:appflug/routes/views.dart';
import 'package:appflug/ui/shared_widgets.dart/custom_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IncompleteDocumentsView extends StatefulWidget {
  @override
  _IncompleteDocumentsViewState createState() =>
      _IncompleteDocumentsViewState();
}

class _IncompleteDocumentsViewState extends State<IncompleteDocumentsView> {
  @override
  Widget build(BuildContext context) {
    Student _student = Provider.of<StudentProvider>(context).currentStudent!;
    return Column(
      children: _buildChildren(_student),
    );
  }

  List<Widget> _buildChildren(Student student) {
    List<Document> documents = student.documents.values.toList();

    List<Widget> children = [];

    for (Document doc in documents) {
      if (doc.downloadUrl == null) {
        switch (doc.type) {
          case DocumentType.languageTest:
            children.add(
              CustomListTile(
                title: 'Aktuelles Sprachzeugnis hochladen',
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
                title: 'Motivationsschreiben hochladen',
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
                title:
                    'Auflistung der bisher von Ihnen besuchten Studienveranstaltungen hochladen',
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
            children.add(
              CustomListTile(
                title: 'Präferenzuniversiäten angeben',
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    Views.preferenceList,
                  );
                },
              ),
            );
            break;
          case DocumentType.passport:
            children.add(
              CustomListTile(
                title:
                    'Kopie Ihres Personalausweises (EU, Norwegen, Schweiz) bzw. Reisepasses (alle anderen Länder)',
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
            height: 20,
          ),
        );
      }
    }
    return children;
  }
}
