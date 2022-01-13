import 'package:appflug/data/classes/student.dart';
import 'package:appflug/data/provider/student_provider.dart';
import 'package:appflug/routes/views.dart';
import 'package:appflug/ui/shared_widgets.dart/custom_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IncompleteProfileView extends StatefulWidget {
  @override
  _IncompleteProfileViewState createState() => _IncompleteProfileViewState();
}

class _IncompleteProfileViewState extends State<IncompleteProfileView> {
  @override
  Widget build(BuildContext context) {
    Student _student = Provider.of<StudentProvider>(context).currentStudent!;
    return Column(
      children: [
        if (_student.matriculationNumber == null) ...[
          CustomListTile(
            title: 'Matrikelnummer hinzufügen',
            onTap: () {
              Navigator.pushNamed(
                context,
                Views.matriculationNumber,
              );
            },
          ),
          SizedBox(
            height: 20,
          ),
        ],
        if (_student.birthplace == null) ...[
          CustomListTile(
            title: 'Geburtsort hinzufügen',
            onTap: () {
              Navigator.pushNamed(
                context,
                Views.birthplace,
              );
            },
          ),
          SizedBox(
            height: 20,
          ),
        ],
        if (_student.course == null)
          CustomListTile(
            title: 'Studiengang hinzufügen',
            onTap: () {
              Navigator.pushNamed(
                context,
                Views.course,
              );
            },
          ),
      ],
    );
  }
}
