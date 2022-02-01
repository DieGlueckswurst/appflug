import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/hero_key.dart';
import 'package:appflug/constants/measurements.dart';
import 'package:appflug/data/backend/authentication.dart';
import 'package:appflug/data/classes/student.dart';
import 'package:appflug/shared_utils/student_service.dart';
import 'package:appflug/shared_utils/alert_service.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/back_button.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/rounded_corner_text_button.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/textfield_with_rounded_border.dart';
import 'package:appflug/ui/shared_widgets.dart/hero_header.dart';
import 'package:flutter/material.dart';

class AuthenticationView extends StatefulWidget {
  final String viewToNavigateTo;

  const AuthenticationView({
    Key? key,
    required this.viewToNavigateTo,
  }) : super(key: key);
  @override
  _AuthenticationViewState createState() => _AuthenticationViewState();
}

class _AuthenticationViewState extends State<AuthenticationView> {
  String _password = '';
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    Student _student = StudentService.getStudent(
      context,
      listen: false,
    )!;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10,
            left: sidePadding,
            right: sidePadding,
          ),
          child: Column(
            children: [
              CustomBackButton(),
              SizedBox(
                height: 10,
              ),
              HeroHeader(
                title: 'Identität bestätigen',
              ),
              Expanded(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 400,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      TextFieldWithRoundedBorder(
                        initValue: _student.email,
                        readOnly: true,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFieldWithRoundedBorder(
                        textInputType: TextInputType.visiblePassword,
                        onChanged: (password) {
                          setState(() {
                            _password = password;
                          });
                        },
                        hintText: 'Passwort eingeben',
                        focusOnInit: true,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RoundedCornersTextButton(
                        heroKey: HeroKeys.buttonKeyAsStud,
                        title: 'Identität bestätigen',
                        isLoading: _isLoading,
                        onTap: () async {
                          setState(() {
                            _isLoading = true;
                          });
                          await _reauthenticate(
                            email: _student.email!,
                          );
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
                            email: _student.email!,
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _reauthenticate({
    required String email,
  }) async {
    bool wasSuccessfull = await AuthenticationService.reauthenticate(
      email: email,
      password: _password,
    );

    if (wasSuccessfull) {
      Navigator.pushReplacementNamed(
        context,
        widget.viewToNavigateTo,
      );
    }

    setState(() {
      _isLoading = false;
    });
  }
}
