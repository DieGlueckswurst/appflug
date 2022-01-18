import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/measurements.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/data/classes/student.dart';
import 'package:appflug/data/provider/student_provider.dart';
import 'package:appflug/data/student_service.dart';
import 'package:appflug/enums/application_status_option.dart';
import 'package:appflug/ui/views/home/widgets/application_status_indicator.dart';
import 'package:appflug/ui/views/home/widgets/incomplete_documents_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'application_progress_indicator.dart';
import 'incomplete_profile_view.dart';

class ApplicationStatusView extends StatefulWidget {
  @override
  _ApplicationStatusViewState createState() => _ApplicationStatusViewState();
}

class _ApplicationStatusViewState extends State<ApplicationStatusView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: StudentService.getStudentData(
          context: context,
        ),
        builder: (context, AsyncSnapshot<Student> studentSnapshot) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: sidePadding,
              ),
              Text(
                'Bewerbungsstatus',
                style: AppTextStyles.montserratH3Bold.copyWith(
                  color: AppColors.blue,
                ),
              ),
              studentSnapshot.hasData
                  ? _buildBody(
                      context: context,
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            ],
          );
        });
  }

  Widget _buildBody({
    required BuildContext context,
  }) {
    Student _student = Provider.of<StudentProvider>(context).currentStudent!;
    return Column(
      children: [
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: ApplicationProgressIndicator(
            currentApplicationStatus: _student.applicationStatus,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        ApplicationStatusIndicator(),
        SizedBox(
          height: 30,
        ),
        _buildViewDependingOnApplicationsStatus(_student),
        SizedBox(
          height: sidePadding,
        ),
      ],
    );
  }

  Widget _buildViewDependingOnApplicationsStatus(Student student) {
    switch (student.applicationStatus) {
      case ApplicationStatusOption.incompleteProfile:
        return IncompleteProfileView();
      case ApplicationStatusOption.incompleteDocuments:
        return IncompleteDocumentsView();
      case ApplicationStatusOption.readyForApplication:
        return Container();
      case ApplicationStatusOption.documentsSubmitted:
        return Container();
      case ApplicationStatusOption.waitingForUniversity:
        return Container();
    }
  }
}
