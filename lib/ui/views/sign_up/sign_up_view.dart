import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/hero_key.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/data/backend/authentication.dart';
import 'package:appflug/routes/views.dart';
import 'package:appflug/shared_utils/layout_service.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/back_button.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/rounded_corner_text_button.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/textfield_with_rounded_border.dart';
import 'package:appflug/ui/shared_widgets.dart/password_validation_view.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatefulWidget {
  final String email;

  const SignUpView({required this.email});

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  String _password = '';
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: LayoutService.defaultViewPadding,
          child: Center(
            child: Column(
              children: [
                CustomBackButton(),
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
                      PasswordValidationView(
                        password: _password,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RoundedCornersTextButton(
                        heroKey: HeroKeys.buttonKeyAsStud,
                        isEnabled: AuthenticationService.isValidPassword(
                          _password,
                        ),
                        title: 'Weiter',
                        isLoading: _isLoading,
                        onTap: () async {
                          setState(() {
                            _isLoading = true;
                          });
                          bool wasSuccessfull =
                              await AuthenticationService.signUp(
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
