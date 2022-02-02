import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/measurements.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/shared_utils/preference_choice_tile_liste_view.dart';
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
        left: 20,
        right: 20,
      ),
      titleText: Text(
        title,
        style: AppTextStyles.montserratH6SemiBold.copyWith(
          color: AppColors.white,
        ),
      ),
      messageText: Text(
        description,
        style: AppTextStyles.montserratH7Regular.copyWith(
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

  static showPreferenceDialog(
    BuildContext context, {
    required Function(String) onPositionSaved,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.transparent,
          content: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(
                color: AppColors.blue,
                width: 3,
              ),
              borderRadius: BorderRadius.circular(
                10,
              ),
            ),
            padding: EdgeInsets.all(
              sidePadding,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                PreferenceChoiseListTileView(onPositionChanged: (position) {
                  onPositionSaved(
                    position,
                  );
                  Navigator.pop(
                    context,
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }
}
