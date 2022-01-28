import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/measurements.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/data/classes/student.dart';
import 'package:appflug/data/provider/student_provider.dart';
import 'package:appflug/data/student_service.dart';
import 'package:appflug/enums/application_status_option.dart';
import 'package:appflug/shared_utils/layout_service.dart';
import 'package:appflug/ui/shared_widgets.dart/lottie_animations/loading_plane.dart';
import 'package:appflug/ui/views/home/widgets/application_status_indicator.dart';
import 'package:appflug/ui/views/home/widgets/documents_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'application_progress_indicator.dart';
import 'personal_data_list_view.dart';

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
      builder: (context, AsyncSnapshot<void> studentSnapshot) {
        Student? _student =
            Provider.of<StudentProvider>(context).currentStudent;
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
            AnimatedSwitcher(
              duration: kThemeAnimationDuration,
              child: _student != null
                  ? _buildBody(
                      context: context,
                      student: _student,
                    )
                  : Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 100,
                          ),
                          LoadingPlane(),
                        ],
                      ),
                    ),
            )
          ],
        );
      },
    );
  }

  Widget _buildBody({
    required BuildContext context,
    required Student student,
  }) {
    return Column(
      children: [
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: LayoutService.isDesktop(context)
                ? sidePadding * 3
                : sidePadding,
          ),
          child: ApplicationProgressIndicator(
            currentApplicationStatus: student.applicationStatus,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        ApplicationStatusIndicator(
          student: student,
        ),
        SizedBox(
          height: 30,
        ),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: LayoutService.isDesktop(context) ? 400 : double.infinity,
          ),
          child: _buildViewDependingOnApplicationsStatus(
            student,
          ),
        ),
        SizedBox(
          height: sidePadding,
        ),
      ],
    );
  }

  Widget _buildViewDependingOnApplicationsStatus(Student student) {
    switch (student.applicationStatus) {
      case ApplicationStatusOption.incompleteProfile:
        return PersonalDataListView(
          student: student,
          isInSettings: false,
        );
      case ApplicationStatusOption.incompleteDocuments:
        return DocumentsListView(
          student: student,
          isInSettings: false,
        );
      case ApplicationStatusOption.readyForApplication:
        return Container();
      case ApplicationStatusOption.documentsSubmitted:
        return Container();
      case ApplicationStatusOption.waitingForUniversity:
        return Container();
    }
  }
}
