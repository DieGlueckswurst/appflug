import 'package:appflug/constants/measurements.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/data/backend/authentication.dart';
import 'package:appflug/routes/views.dart';
import 'package:appflug/shared_utils/alert_service.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/back_button.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/rounded_corner_text_button.dart';
import 'package:appflug/ui/shared_widgets.dart/hero_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DeleteAccountView extends StatefulWidget {
  @override
  _DeleteAccountViewState createState() => _DeleteAccountViewState();
}

class _DeleteAccountViewState extends State<DeleteAccountView> {
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
                HeroHeader(
                  title: 'Konto löschen',
                ),
                SizedBox(
                  height: 10,
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 400,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      SvgPicture.asset(
                        'assets/icons/warning.svg',
                        height: 40,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Das Löschen des Accounts kann NICHT rückgängig gemacht werden. Alle deine gespeicherten Daten werden dabei gelöscht.',
                        style: AppTextStyles.montserratH7SemiBold,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      RoundedCornersTextButton(
                        title: 'Konto löschen',
                        isLoading: _isLoading,
                        onTap: () async {
                          setState(() {
                            _isLoading = true;
                          });
                          _deleteAccount(context);
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

  Future<void> _deleteAccount(BuildContext context) async {
    bool wasSuccessfull = await AuthenticationService.deleteUser(context);

    if (wasSuccessfull) {
      AlertService.showSnackBar(
        title: 'Dein Konto wurde erfolgreich gelöscht.',
        description: 'Du kannst dich jederzeit kostenlos neu registrieren.',
        isSuccess: true,
      );

      Navigator.pushNamedAndRemoveUntil(
        context,
        Views.start,
        (route) => false,
      );
    }

    setState(() {
      _isLoading = false;
    });
  }
}
