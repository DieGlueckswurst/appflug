import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingPlane extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Lottie.asset(
        'assets/lottie/loading_plane.json',
        animate: true,
        repeat: true,
      ),
    );
  }
}
