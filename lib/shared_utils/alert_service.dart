import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/measurements.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
      margin: EdgeInsets.only(
        top: 20,
        left: sidePadding,
        right: sidePadding,
      ),
      titleText: Text(
        title,
        style: AppTextStyles.montserratH5SemiBold.copyWith(
          color: AppColors.white,
        ),
      ),
      messageText: Text(
        description,
        style: AppTextStyles.montserratH6SemiBold.copyWith(
          color: AppColors.white,
        ),
      ),
      icon: SvgPicture.asset(
        isSuccess ? 'assets/icons/correct.svg' : 'assets/icons/multiply.svg',
        height: 15,
        color: isSuccess ? AppColors.green : AppColors.red,
      ),
      padding: EdgeInsets.all(20),
      backgroundColor: AppColors.blue,
      isDismissible: true,
      maxWidth: 500,
      duration: Duration(seconds: 4),
    );
  }
}
