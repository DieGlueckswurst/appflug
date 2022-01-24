import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/measurements.dart';
import 'package:appflug/data/backend/authentication.dart';
import 'package:appflug/routes/views.dart';
import 'package:appflug/shared_utils/alert_service.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/circle_icon_button.dart';
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
            crossAxisAlignment: CrossAxisAlignment.start,
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
              SizedBox(
                height: 10,
              ),
              HeroHeader(
                title: 'Konto',
              ),
              SizedBox(
                height: 30,
              ),
              CustomListTile(
                title: 'Email bearbeiten',
                onTap: () {},
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 20,
              ),
              RoundedCornersTextButton(
                title: 'Logout',
                onTap: () async {
                  bool wasSuccessfull = await AuthenticationService.signOut(
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
