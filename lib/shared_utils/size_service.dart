import 'package:flutter/material.dart';

double width = 0.0;
double height = 0.0;
double safeAreaHorizontal = 0.0;
double safeAreaVertical = 0.0;
double safeAreaTop = 0.0;
double safeAreaBottom = 0.0;
const int baseHeight = 667; // iPhone SE 2nd Gen Height
const int baseWidth = 375;
MediaQueryData? mediaQueryData;
double screenHeight = 0;
double screenWidth = 0;

void initializeSizeService(BuildContext context) {
  mediaQueryData = MediaQuery.of(context);

  if (mediaQueryData == null) return;

  screenHeight = mediaQueryData!.size.height;
  screenWidth = mediaQueryData!.size.width;

  safeAreaTop = mediaQueryData!.padding.top;
  safeAreaBottom = mediaQueryData!.padding.bottom;

  safeAreaHorizontal =
      mediaQueryData!.padding.left + mediaQueryData!.padding.right;
  safeAreaVertical = safeAreaTop + safeAreaBottom;
  width = mediaQueryData!.size.width - safeAreaHorizontal;
  height = mediaQueryData!.size.height - safeAreaVertical;
}

double scaleHeight(double size) {
  double scaleFactor = size / baseHeight;
  double scaledSize = height * scaleFactor;
  return scaledSize;
}

double scaleWidth(double size) {
  double scaleFactor = size / baseWidth;
  double scaledSize = width * scaleFactor;
  return scaledSize;
}

bool hasBottmNotch(BuildContext context) {
  return MediaQuery.of(context).viewPadding.bottom > 0;
}

extension ScalingExtension on num {
  double get scaled => scaleWidth(toDouble());
}
