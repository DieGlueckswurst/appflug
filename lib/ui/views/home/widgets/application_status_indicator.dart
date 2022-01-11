import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/enums/application_status_option.dart';
import 'package:appflug/ui/views/home/utils/application_status_service.dart';
import 'package:flutter/material.dart';

class ApplicationStatusIndicator extends StatelessWidget {
  final ApplicationStatusOption applicationStatusOption;

  const ApplicationStatusIndicator({required this.applicationStatusOption});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(
        20,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          width: 3,
          color: AppColors.blue,
        ),
        borderRadius: BorderRadius.circular(30),
        color: AppColors.yellow,
      ),
      child: Text(
        ApplicationStatusService.getApplicationStatusTitleFromOption(
          applicationStatusOption,
        ),
        style: AppTextStyles.montserratH5SemiBold.copyWith(
          height: 1,
          color: AppColors.blue,
        ),
      ),
    );
  }
}
