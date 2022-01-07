import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/measurements.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/circle_icon_button.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/rounded_corner_text_button.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/textfield_with_rounded_border.dart';
import 'package:appflug/ui/views/sign_up/utils/regex_for_password.dart';
import 'package:appflug/ui/views/sign_up/utils/regex_map_with_descriptions_for_password.dart';
import 'package:appflug/ui/views/sign_up/widgets/password_validator.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatefulWidget {
  final String email;

  const SignUpView({required this.email});

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  String _password = '';
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
                        'Konto erstellen',
                        style: AppTextStyles.montserratH2Bold.copyWith(
                          color: AppColors.blue,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFieldWithRoundedBorder(
                        onChanged: (password) {
                          setState(() {
                            _password = password;
                          });
                        },
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
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 10,
                        ),
                        child: PasswordValidator(
                          password: _password,
                          regExp: PasswordRegex
                              .atLeastOneUpperAndOneLowerCaseLetter,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 10,
                        ),
                        child: PasswordValidator(
                          password: _password,
                          regExp: PasswordRegex.atLeastOneDigit,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 10,
                        ),
                        child: PasswordValidator(
                          password: _password,
                          regExp: PasswordRegex.atLeast8Characters,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RoundedCornersTextButton(
                        isEnabled: _paswordIsValid,
                        title: 'Weiter',
                        onTap: () {},
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

  bool get _paswordIsValid =>
      regexMapWithDescriptionsForPassword.keys.toList()[0].hasMatch(
            _password,
          ) &&
      regexMapWithDescriptionsForPassword.keys.toList()[1].hasMatch(
            _password,
          ) &&
      regexMapWithDescriptionsForPassword.keys.toList()[2].hasMatch(
            _password,
          );
}
