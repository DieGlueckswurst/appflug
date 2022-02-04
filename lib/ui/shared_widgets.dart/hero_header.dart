import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/hero_key.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:flutter/material.dart';

class HeroHeader extends StatelessWidget {
  final String title;
  final bool isEnabled;

  const HeroHeader({
    Key? key,
    required this.title,
    this.isEnabled = true,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return HeroMode(
      enabled: isEnabled,
      child: Hero(
        transitionOnUserGestures: true,
        tag: HeroKeys.header,
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
      ),
    );
  }
}
