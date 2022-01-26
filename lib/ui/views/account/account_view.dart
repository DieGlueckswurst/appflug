import 'package:appflug/constants/measurements.dart';
import 'package:appflug/data/backend/authentication.dart';
import 'package:appflug/routes/views.dart';
import 'package:appflug/shared_utils/alert_service.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/back_button.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/rounded_corner_text_button.dart';
import 'package:appflug/ui/shared_widgets.dart/custom_list_tile.dart';
import 'package:appflug/ui/shared_widgets.dart/hero_header.dart';
import 'package:flutter/material.dart';

class AccountView extends StatefulWidget {
  @override
  _AccountViewState createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
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
                title: 'Konto',
              ),
              SizedBox(
                height: 30,
              ),
              Expanded(
                child: ConstrainedBox(
                  constraints: webMaxWidthConstraint,
                  child: Column(
                    children: [
                      CustomListTile(
                        title: 'Konto löschen',
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Views.authentication,
                            arguments: Views.deleteAccount,
                          );
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomListTile(
                        title: 'Passwort ändern',
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Views.authentication,
                            arguments: Views.changePassword,
                          );
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RoundedCornersTextButton(
                        title: 'Logout',
                        onTap: () async {
                          bool wasSuccessfull =
                              await AuthenticationService.signOut(
                            context,
                          );
                          AlertService.showSnackBar(
                            title: wasSuccessfull
                                ? 'Erfolgreich ausgeloggt'
                                : 'Beim ausloggen ist etwas schiefgelaufen.',
                            description: wasSuccessfull
                                ? 'AppFlug ist übrigens auf iOS, Android und im Web verfügbar.'
                                : 'Bitte versuche es erneut oder starte die App neu.',
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
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: sidePadding,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
