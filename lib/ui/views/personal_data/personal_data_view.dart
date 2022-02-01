import 'package:appflug/constants/measurements.dart';
import 'package:appflug/data/classes/student.dart';
import 'package:appflug/shared_utils/student_service.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/back_button.dart';
import 'package:appflug/ui/shared_widgets.dart/hero_header.dart';
import 'package:appflug/ui/views/home/widgets/personal_data_list_view.dart';
import 'package:flutter/material.dart';

class PersonalDataView extends StatefulWidget {
  @override
  _PersonalDataViewState createState() => _PersonalDataViewState();
}

class _PersonalDataViewState extends State<PersonalDataView> {
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
            children: [
              CustomBackButton(),
              SizedBox(
                height: 10,
              ),
              HeroHeader(
                title: 'Persönliche Daten',
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
    )!;

    return Expanded(
      child: ConstrainedBox(
        constraints: webMaxWidthConstraint,
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            PersonalDataListView(
              student: _student,
              isInSettings: true,
            ),
            SizedBox(
              height: sidePadding,
            ),
          ],
        ),
      ),
    );
  }
}
