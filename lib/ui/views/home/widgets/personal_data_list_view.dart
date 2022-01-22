import 'package:appflug/data/classes/student.dart';
import 'package:appflug/routes/views.dart';
import 'package:appflug/ui/shared_widgets.dart/custom_list_tile.dart';
import 'package:flutter/material.dart';

class PersonalDataListView extends StatefulWidget {
  final Student student;
  final bool isInSettings;

  const PersonalDataListView({
    Key? key,
    required this.student,
    required this.isInSettings,
  }) : super(key: key);

  @override
  _PersonalDataListViewState createState() => _PersonalDataListViewState();
}

class _PersonalDataListViewState extends State<PersonalDataListView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.student.matriculationNumber == null ||
            widget.isInSettings) ...[
          CustomListTile(
            title: widget.isInSettings
                ? 'Matrikelnummer'
                : 'Matrikelnummer hinzufügen',
            onTap: () {
              Navigator.pushNamed(
                context,
                Views.matriculationNumber,
                arguments: widget.student.matriculationNumber?.toString(),
              );
            },
          ),
          SizedBox(
            height: 20,
          ),
        ],
        if (widget.student.birthplace == null || widget.isInSettings) ...[
          CustomListTile(
            title: widget.isInSettings ? 'Geburtsort' : 'Geburtsort hinzufügen',
            onTap: () {
              Navigator.pushNamed(
                context,
                Views.birthplace,
                arguments: widget.student.birthplace,
              );
            },
          ),
          SizedBox(
            height: 20,
          ),
        ],
        if (widget.student.course == null || widget.isInSettings)
          CustomListTile(
            title:
                widget.isInSettings ? 'Studiengang' : 'Studiengang hinzufügen',
            onTap: () {
              Navigator.pushNamed(
                context,
                Views.course,
                arguments: widget.student.course,
              );
            },
          ),
      ],
    );
  }
}
