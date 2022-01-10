import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/measurements.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/ui/views/home/utils/application_deadline_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ApplicationDeadlineView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: sidePadding,
        ),
        Text(
          'Bewerbungsfrist',
          style: AppTextStyles.montserratH3Bold.copyWith(
            color: AppColors.blue,
          ),
        ),
        Text(
          'für das Wintersemester 2023/2024',
          style: AppTextStyles.montserratH6Regular,
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Text(
              DateFormat('dd.MM.yyy').format(
                ApplicationDeadlineService.deadline,
              ),
              style: AppTextStyles.montserratH3Bold.copyWith(
                color: AppColors.red,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              '(noch ' +
                  ApplicationDeadlineService.getDaysUntilDeadline().toString() +
                  ' Tage)',
              style: AppTextStyles.montserratH6Regular,
            ),
          ],
        ),
      ],
    );
  }
}
