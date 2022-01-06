import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/measurements.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:flutter/material.dart';

class TextFieldWithRoundedBorder extends StatelessWidget {
  final String? hintText;
  final Function(String) onChanged;

  const TextFieldWithRoundedBorder({
    Key? key,
    required this.onChanged,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(
            color: AppColors.blue,
            width: 3.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(
            color: AppColors.blue,
            width: 3.0,
          ),
        ),
        hintText: hintText,
      ),
      style: AppTextStyles.montserratH6Regular,
      onChanged: onChanged,
    );
  }
}
