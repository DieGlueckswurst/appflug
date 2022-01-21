import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/measurements.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/data/backend/authentication.dart';
import 'package:appflug/routes/views.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/rounded_corner_text_button.dart';
import 'package:appflug/ui/shared_widgets.dart/custom_list_tile.dart';
import 'package:flutter/material.dart';

class SettingsView extends StatefulWidget {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: sidePadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: sidePadding,
              ),
              Text(
                'Mein Profil',
                style: AppTextStyles.montserratH2Bold.copyWith(
                  color: AppColors.blue,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  CustomListTile(
                      title: 'Persönliche Daten',
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          Views.personalData,
                        );
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  CustomListTile(
                      title: 'Dokumente',
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          Views.documents,
                        );
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  CustomListTile(title: 'Konto', onTap: () {}),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
              RoundedCornersTextButton(
                title: 'Logout',
                onTap: () async {
                  bool wasSuccessfull = await AuthenticationService.signOut();
                  if (wasSuccessfull) {
                    Navigator.pushReplacementNamed(
                      context,
                      Views.start,
                    );
                  }
                },
              ),
            ],
          )),
    );
  }
}
