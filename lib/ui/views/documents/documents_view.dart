import 'package:appflug/constants/measurements.dart';
import 'package:appflug/data/classes/student.dart';
import 'package:appflug/data/student_service.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/back_button.dart';
import 'package:appflug/ui/shared_widgets.dart/hero_header.dart';
import 'package:appflug/ui/views/home/widgets/documents_list_view.dart';
import 'package:flutter/material.dart';

class DocumentsView extends StatefulWidget {
  @override
  _DocumentsViewState createState() => _DocumentsViewState();
}

class _DocumentsViewState extends State<DocumentsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            left: sidePadding,
            right: sidePadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomBackButton(),
              SizedBox(
                height: 10,
              ),
              HeroHeader(
                title: 'Meine Dokumente',
              ),
              _buildBody(
                context: context,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody({
    required BuildContext context,
  }) {
    Student _student = StudentService.getStudent(
      context,
      listen: true,
    );

    return Column(
      children: [
        SizedBox(
          height: 30,
        ),
        DocumentsListView(
          student: _student,
          isInSettings: true,
        ),
        SizedBox(
          height: sidePadding,
        ),
      ],
    );
  }
}
