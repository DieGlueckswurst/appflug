import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlertService {
  static showSnackBar({
    required String title,
    required String description,
    required bool isSuccess,
  }) {
    Get.snackbar(
      '',
      '',
      titleText: Padding(
        padding: EdgeInsets.only(bottom: 8.0),
        child: Text(
          title,
          style: AppTextStyles.montserratH5SemiBold.copyWith(
            color: isSuccess ? AppColors.green : AppColors.red,
          ),
        ),
      ),
      messageText: Text(
        description,
        style: AppTextStyles.montserratH6Regular.copyWith(
          color: isSuccess ? AppColors.green : AppColors.red,
        ),
      ),
      onTap: (snack) {
        // ignore: avoid_print
        print('tap on snackbar');
      },
      padding: EdgeInsets.all(20),
      backgroundColor: AppColors.white,
      borderColor: AppColors.blue,
      borderWidth: 3,
      isDismissible: true,
      duration: Duration(seconds: 3),
    );
  }
}
