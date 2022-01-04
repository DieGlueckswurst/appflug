import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyles {
  static const montserrat = 'Montserrat';

  static TextStyle montserratH1Regular = const TextStyle(
    fontFamily: montserrat,
    fontSize: 36,
  );

  static TextStyle montserratH1Bold = montserratH1Regular.copyWith(
    fontWeight: FontWeight.w800,
  );

  static TextStyle montserratH2Regular = const TextStyle(
    fontFamily: montserrat,
    color: AppColors.darkBlue,
    fontSize: 27,
  );

  static TextStyle montserratH2SemiBold = montserratH2Regular.copyWith(
    fontWeight: FontWeight.w600,
  );

  static TextStyle montserratH4Regular = const TextStyle(
    fontWeight: FontWeight.w400,
    fontFamily: montserrat,
    fontSize: 17,
    color: AppColors.darkBlue,
  );

  static TextStyle montserratH4SemiBold = montserratH4Regular.copyWith(
    fontWeight: FontWeight.w600,
  );

  static TextStyle montserratH5Regular = const TextStyle(
    fontWeight: FontWeight.w400,
    fontFamily: montserrat,
    fontSize: 15,
    color: AppColors.darkBlue,
  );

  static TextStyle montserratH5Medium = const TextStyle(
    fontWeight: FontWeight.w500,
    fontFamily: montserrat,
    fontSize: 15,
    color: AppColors.darkBlue,
  );

  static TextStyle montserratH5SemiBold = const TextStyle(
    fontWeight: FontWeight.w600,
    fontFamily: montserrat,
    fontSize: 15,
    color: AppColors.darkBlue,
  );

  static TextStyle montserratH6Regular = const TextStyle(
    fontWeight: FontWeight.w400,
    fontFamily: montserrat,
    fontSize: 13,
    color: AppColors.darkBlue,
  );

  static TextStyle montserratH6SemiBold = montserratH6Regular.copyWith(
    fontWeight: FontWeight.w600,
  );

  static TextStyle montserratH7Regular = const TextStyle(
    color: AppColors.darkBlue,
    fontWeight: FontWeight.w400,
    fontFamily: montserrat,
    fontSize: 11,
  );

  static TextStyle montserratH7SemiBold = montserratH7Regular.copyWith(
    fontWeight: FontWeight.w600,
  );
}
