import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/measurements.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/rounded_corner_text_button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class StartView extends StatefulWidget {
  const StartView({Key? key}) : super(key: key);

  @override
  State<StartView> createState() => _HStartViewState();
}

class _HStartViewState extends State<StartView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: sidePadding,
        ),
        child: Center(
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
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 350,
                ),
                child: RoundedCornersTextButton(
                  title: 'Login',
                  onTap: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
