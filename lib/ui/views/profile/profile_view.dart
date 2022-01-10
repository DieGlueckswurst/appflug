import 'package:appflug/constants/measurements.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/data/backend/authentication.dart';
import 'package:appflug/routes/views.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/rounded_corner_text_button.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: sidePadding,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Profil',
              style: AppTextStyles.montserratH1Bold,
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
        ));
  }
}
