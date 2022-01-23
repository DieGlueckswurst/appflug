import 'package:appflug/data/backend/authentication.dart';
import 'package:appflug/routes/views.dart';
import 'package:appflug/shared_utils/alert_service.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/rounded_corner_text_button.dart';
import 'package:flutter/material.dart';

class AccountView extends StatefulWidget {
  @override
  _AccountViewState createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RoundedCornersTextButton(
          title: 'Logout',
          onTap: () async {
            bool wasSuccessfull = await AuthenticationService.signOut(
              context,
            );
            AlertService.showSnackBar(
              title: wasSuccessfull
                  ? 'Erfolgreich ausgeloggt'
                  : 'Beim ausloggen ist etwas schiefgelaufen.',
              description:
                  'AppFlug ist übrigens auf iOS, Android und im Web verfügbar.',
              isSuccess: wasSuccessfull,
            );
            if (wasSuccessfull) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                Views.start,
                (route) => false,
              );
            }
          },
        ),
      ),
    );
  }
}
