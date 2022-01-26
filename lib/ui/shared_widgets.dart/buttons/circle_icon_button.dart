import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/measurements.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CircleIconButton extends StatelessWidget {
  final VoidCallback onTapped;
  final double size;
  final String svgPath;
  final double svgSize;
  final double padding;
  final Color backgroundColor;
  final Color svgColor;
  final bool isMulticolor;
  final Alignment alignment;

  const CircleIconButton({
    required this.onTapped,
    required this.svgPath,
    this.size = touchTargetForButtons,
    this.svgSize = 40,
    this.padding = 0,
    this.backgroundColor = AppColors.blue,
    this.svgColor = AppColors.yellow,
    this.isMulticolor = false,
    this.alignment = Alignment.center,
  });
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTapped,
        child: Container(
          height: size + padding,
          width: size + padding,
          color: AppColors.transparent,
          child: Center(
            child: Container(
              height: size,
              width: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: backgroundColor,
              ),
              child: Align(
                alignment: alignment,
                child: SvgPicture.asset(
                  svgPath,
                  height: svgSize,
                  width: svgSize,
                  color: isMulticolor ? null : svgColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
