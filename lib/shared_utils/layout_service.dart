import 'package:appflug/constants/measurements.dart';
import 'package:flutter/material.dart';

class LayoutService {
  static const double minimumWidthForWebLayout = 1000;

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width > minimumWidthForWebLayout;
  }

  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < minimumWidthForWebLayout;
  }

  static EdgeInsetsGeometry getSidePaddingDependingOnDeviceSize(
      BuildContext context) {
    return EdgeInsets.only(
      top: LayoutService.isDesktop(context) ? sidePadding * 2 : sidePadding,
      left: LayoutService.isDesktop(context) ? sidePadding * 4 : sidePadding,
      right: LayoutService.isDesktop(context) ? sidePadding * 4 : sidePadding,
    );
  }

  static EdgeInsets get defaultViewPadding => const EdgeInsets.only(
        top: 10,
        left: sidePadding,
        right: sidePadding,
      );
}
