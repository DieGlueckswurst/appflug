import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingDots extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      child: Lottie.asset(
        'assets/lottie/loading_dots_primary.json',
        animate: true,
        repeat: true,
      ),
    );
  }
}
