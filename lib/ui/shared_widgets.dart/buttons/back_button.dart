import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/hero_key.dart';
import 'package:flutter/material.dart';

import 'circle_icon_button.dart';

class CustomBackButton extends StatelessWidget {
  final bool isHeroEnabled;

  const CustomBackButton({
    Key? key,
    this.isHeroEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HeroMode(
      enabled: isHeroEnabled,
      child: Hero(
        transitionOnUserGestures: true,
        tag: HeroKeys.backButton,
        child: Row(
          children: [
            CircleIconButton(
              onTapped: () {
                Navigator.pop(context);
              },
              svgPath: 'assets/icons/arrow_left.svg',
              svgColor: AppColors.blue,
              backgroundColor: AppColors.transparent,
              svgSize: 22,
              alignment: Alignment.centerLeft,
            ),
          ],
        ),
      ),
    );
  }
}
