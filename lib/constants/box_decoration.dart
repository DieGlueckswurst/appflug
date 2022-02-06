import 'package:flutter/material.dart';

import 'app_colors.dart';

const double defaultBorderWith = 3;
const double defaultBorderRadius = 10;

final BoxDecoration defaultBoxDecoration = BoxDecoration(
  color: AppColors.white,
  border: Border.all(
    color: AppColors.blue,
    width: defaultBorderWith,
  ),
  borderRadius: BorderRadius.circular(
    defaultBorderRadius,
  ),
);
