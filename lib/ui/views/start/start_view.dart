import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/measurements.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/routes/views.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/rounded_corner_text_button.dart';
import 'package:appflug/ui/views/start/widgets/terms_of_service_view.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class StartView extends StatefulWidget {
  const StartView({Key? key}) : super(key: key);

  @override
  State<StartView> createState() => _HStartViewState();
}

class _HStartViewState extends State<StartView> {
  bool _termsOfServiceIsChecked = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 400,
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: sidePadding,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    'AppFlug',
                    style: AppTextStyles.montserratH1Bold.copyWith(
                      color: AppColors.blue,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  AutoSizeText(
                    'Studieren im Ausland leicht gemacht',
                    style: AppTextStyles.montserratH4SemiBold.copyWith(
                      color: AppColors.blue,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    height: 150,
                    child: Lottie.asset(
                      'assets/lottie/travel.json',
                      animate: true,
                      repeat: true,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  RoundedCornersTextButton(
                    title: 'Ich studiere',
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        Views.email,
                      );
                    },
                    isEnabled: _termsOfServiceIsChecked,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  RoundedCornersTextButton(
                    title: 'Ich bearbeite Anträge',
                    textColor: AppColors.blue,
                    backgroundColor: AppColors.yellow,
                    onTap: () {},
                    isEnabled: _termsOfServiceIsChecked,
                  ),
                  Spacer(),
                  TermsOfServiceView(
                    onIsCheckedChanged: (isChecked) {
                      setState(() {
                        _termsOfServiceIsChecked = isChecked;
                      });
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
