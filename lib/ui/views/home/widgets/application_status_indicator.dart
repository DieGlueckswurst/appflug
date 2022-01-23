import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/data/classes/document.dart';
import 'package:appflug/data/classes/student.dart';
import 'package:appflug/enums/application_status_option.dart';
import 'package:appflug/enums/document_type.dart';
import 'package:appflug/ui/views/home/utils/application_status_service.dart';
import 'package:flutter/material.dart';

class ApplicationStatusIndicator extends StatefulWidget {
  final Student student;

  const ApplicationStatusIndicator({
    Key? key,
    required this.student,
  }) : super(key: key);

  @override
  State<ApplicationStatusIndicator> createState() =>
      _ApplicationStatusIndicatorState();
}

class _ApplicationStatusIndicatorState
    extends State<ApplicationStatusIndicator> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(
            20,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              width: 3,
              color: AppColors.blue,
            ),
            borderRadius: BorderRadius.circular(30),
            gradient: _getGradient(
              widget.student,
            ),
          ),
          child: Text(
            ApplicationStatusService.getApplicationStatusTitleFromOption(
              widget.student.applicationStatus,
            ),
            style: AppTextStyles.montserratH5SemiBold.copyWith(
              height: 1,
              color: AppColors.blue,
            ),
          ),
        ),
      ],
    );
  }

  Gradient? _getGradient(Student student) {
    double progress = 0.0;

    switch (student.applicationStatus) {
      case ApplicationStatusOption.incompleteProfile:
        if (student.matriculationNumber != null) {
          progress += 1 / 3;
        }
        if (student.birthplace != null) {
          progress += 1 / 3;
        }

        if (student.course != null) {
          progress += 1 / 3;
        }
        break;
      case ApplicationStatusOption.incompleteDocuments:
        for (Document doc in student.documents.values) {
          if (doc.downloadUrl != null) {
            progress += 1 / DocumentType.values.length;
          }
        }
        break;
      case ApplicationStatusOption.readyForApplication:
        progress = 1;
        break;
      case ApplicationStatusOption.documentsSubmitted:
        progress = 1;

        break;
      case ApplicationStatusOption.waitingForUniversity:
        progress = 1;
        break;
    }

    return LinearGradient(
      colors: [
        AppColors.white,
        AppColors.white,
        student.applicationStatus == ApplicationStatusOption.readyForApplication
            ? AppColors.green
            : AppColors.yellow,
        student.applicationStatus == ApplicationStatusOption.readyForApplication
            ? AppColors.green
            : AppColors.yellow,
      ],
      stops: [
        0.0,
        (1 - progress) / 1,
        (1 - progress) / 1,
        1.0,
      ],
      end: Alignment.centerLeft,
      begin: Alignment.centerRight,
    );
  }
}
