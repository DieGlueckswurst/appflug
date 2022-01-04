import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Appflug',
              style: AppTextStyles.montserratH1Bold.copyWith(
                color: AppColors.blue,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Studieren im Ausland leicht gemacht',
              style: AppTextStyles.montserratH4SemiBold.copyWith(
                color: AppColors.blue,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 200,
              child: Lottie.asset(
                'assets/lottie/travel.json',
                animate: true,
                repeat: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
