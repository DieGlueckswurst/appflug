import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/measurements.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:flutter/material.dart';

class ApplicationStatusView extends StatefulWidget {
  @override
  _ApplicationStatusViewState createState() => _ApplicationStatusViewState();
}

class _ApplicationStatusViewState extends State<ApplicationStatusView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: sidePadding,
        ),
        Text(
          'Bewerbungsstatus',
          style: AppTextStyles.montserratH3Bold.copyWith(
            color: AppColors.blue,
          ),
        ),
      ],
    );
  }

  // Widget _buildBody(BuildContext context) {

  // }
}
