import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:flutter/material.dart';

class HeroHeader extends StatelessWidget {
  final String title;

  const HeroHeader({
    Key? key,
    required this.title,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'text',
      child: Row(
        children: [
          Expanded(
            child: Material(
              color: AppColors.transparent,
              child: Text(
                title,
                style: AppTextStyles.montserratH2Bold.copyWith(
                  color: AppColors.blue,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
