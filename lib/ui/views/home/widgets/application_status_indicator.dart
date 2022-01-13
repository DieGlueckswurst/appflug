import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/data/classes/student.dart';
import 'package:appflug/data/provider/student_provider.dart';
import 'package:appflug/enums/application_status_option.dart';
import 'package:appflug/ui/views/home/utils/application_status_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ApplicationStatusIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Student _student = Provider.of<StudentProvider>(context).currentStudent!;

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
            gradient: _student.applicationStatus ==
                    ApplicationStatusOption.incompleteProfile
                ? _getGradient(_student)
                : null,
          ),
          child: Text(
            ApplicationStatusService.getApplicationStatusTitleFromOption(
              _student.applicationStatus,
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
    if (student.applicationStatus ==
        ApplicationStatusOption.incompleteProfile) {
      double progress = 0.0;
      if (student.matriculationNumber != null) {
        progress += 1 / 3;
      }
      if (student.birthplace != null) {
        progress += 1 / 3;
      }

      if (student.course != null) {
        progress += 1 / 3;
      }

      return LinearGradient(
        colors: const [
          AppColors.white,
          AppColors.white,
          AppColors.green,
          AppColors.green,
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
}
