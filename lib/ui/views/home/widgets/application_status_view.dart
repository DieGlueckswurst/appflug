import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/measurements.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/data/classes/student.dart';
import 'package:appflug/enums/application_status_option.dart';
import 'package:appflug/shared_utils/layout_service.dart';
import 'package:appflug/ui/views/home/widgets/application_status_indicator.dart';
import 'package:appflug/ui/views/home/widgets/documents_list_view.dart';
import 'package:appflug/ui/views/home/widgets/ready_for_application_view.dart';
import 'package:flutter/material.dart';

import 'application_progress_indicator.dart';
import 'personal_data_list_view.dart';

class ApplicationStatusView extends StatefulWidget {
  final Student student;

  const ApplicationStatusView({
    Key? key,
    required this.student,
  }) : super(key: key);
  @override
  _ApplicationStatusViewState createState() => _ApplicationStatusViewState();
}

class _ApplicationStatusViewState extends State<ApplicationStatusView> {
  @override
  Widget build(BuildContext context) {
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
        _buildBody(
          context: context,
          student: widget.student,
        ),
      ],
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
        return ReadyForApplicationView();
      case ApplicationStatusOption.documentsSubmitted:
        return Padding(
          padding: EdgeInsets.only(
            bottom: sidePadding,
          ),
          child: Text(
            'Deine Dokumente werden von uns überprüft. Das kann bis zu 14 Tagen dauern. Du musst nichts weiter tun.',
            style: AppTextStyles.montserratH6Regular,
          ),
        );
      case ApplicationStatusOption.waitingForUniversity:
        return Padding(
          padding: EdgeInsets.only(
            bottom: sidePadding,
          ),
          child: Text(
            'Deine Dokumente wurden erfolgreich überprüft und an deine angegebenen Präferenzuniversitäten weitergeleitet. Wir melden uns sobald es eine Antwort der Partneruniversitäten gibt und drücken dir bis dahin die Daumen!',
            style: AppTextStyles.montserratH6Regular,
          ),
        );
      case ApplicationStatusOption.rejectedDocuments:
        return Container();
    }
  }
}
