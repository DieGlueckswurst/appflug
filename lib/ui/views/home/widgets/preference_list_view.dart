import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/measurements.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:flutter/material.dart';

class PreferenceListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: sidePadding,
        ),
        Text(
          'Präferenzuniversitäten',
          style: AppTextStyles.montserratH3Bold.copyWith(
            color: AppColors.blue,
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
