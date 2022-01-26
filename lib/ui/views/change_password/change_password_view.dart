import 'package:appflug/constants/measurements.dart';
import 'package:appflug/data/backend/authentication.dart';
import 'package:appflug/shared_utils/alert_service.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/back_button.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/rounded_corner_text_button.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/textfield_with_rounded_border.dart';
import 'package:appflug/ui/shared_widgets.dart/hero_header.dart';
import 'package:appflug/ui/shared_widgets.dart/password_validation_view.dart';
import 'package:flutter/material.dart';

class ChangePasswordView extends StatefulWidget {
  @override
  _ChangePasswordViewState createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
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
                CustomBackButton(),
                HeroHeader(title: 'Passwort ändern'),
                SizedBox(
                  height: 10,
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 400,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      PasswordValidationView(
                        password: _password,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      RoundedCornersTextButton(
                        title: 'Passwort ändern',
                        isLoading: _isLoading,
                        isEnabled: AuthenticationService.isValidPassword(
                          _password,
                        ),
                        onTap: () async {
                          setState(() {
                            _isLoading = true;
                          });
                          _changePassword();
                        },
                      ),
                      SizedBox(
                        height: sidePadding,
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

  Future<void> _changePassword() async {
    bool wasSuccessfull = await AuthenticationService.changePassword(_password);

    if (wasSuccessfull) {
      AlertService.showSnackBar(
        title: 'Passwort erfolgreich geändert.',
        description: 'Du kannst dich mit deinem neuen Passwort jetzt anmelden.',
        isSuccess: true,
      );
    }

    setState(() {
      _isLoading = false;
    });
  }
}
