import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/measurements.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/data/backend/authentication.dart';
import 'package:appflug/routes/views.dart';
import 'package:appflug/shared_utils/alert_service.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/circle_icon_button.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/rounded_corner_text_button.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/textfield_with_rounded_border.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  final String email;

  const LoginView({required this.email});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String _password = '';
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10,
            left: sidePadding,
            right: sidePadding,
          ),
          child: Center(
            child: Column(
              children: [
                Row(
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
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 400,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Login',
                        style: AppTextStyles.montserratH2Bold.copyWith(
                          color: AppColors.blue,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFieldWithRoundedBorder(
                        initValue: widget.email,
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFieldWithRoundedBorder(
                        onChanged: (password) {
                          setState(() {
                            _password = password;
                          });
                        },
                        hintText: 'Passwort eingeben',
                        focusOnInit: true,
                        textInputType: TextInputType.visiblePassword,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      RoundedCornersTextButton(
                        title: 'Weiter',
                        isLoading: _isLoading,
                        onTap: () async {
                          setState(() {
                            _isLoading = true;
                          });
                          bool wasSuccessfull =
                              await AuthenticationService.signIn(
                            email: widget.email,
                            password: _password,
                          );
                          if (wasSuccessfull) {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              Views.home,
                              (route) => false,
                            );
                          }
                          setState(() {
                            _isLoading = false;
                          });
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      RoundedCornersTextButton(
                        title: 'Passwort vergessen',
                        backgroundColor: AppColors.white,
                        textColor: AppColors.blue,
                        onTap: () async {
                          await AuthenticationService.sendPasswordResetEmail(
                            email: widget.email,
                          );
                          AlertService.showSnackBar(
                            title: 'Passwort zurückgesetzt',
                            description:
                                'Wir haben dir eine Mail geschickt, mit der du ein neues Passwort vergeben kannst.',
                            isSuccess: true,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}