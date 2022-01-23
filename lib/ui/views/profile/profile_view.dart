import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/measurements.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/data/provider/student_provider.dart';
import 'package:appflug/routes/views.dart';
import 'package:appflug/ui/shared_widgets.dart/custom_list_tile.dart';
import 'package:appflug/ui/shared_widgets.dart/lottie_animations/loading_plane.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsView extends StatefulWidget {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    bool _studentHasData = Provider.of<StudentProvider>(
      context,
    ).dataIsRetrieved;
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
            _studentHasData
                ? Column(
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
                      CustomListTile(
                          title: 'Konto',
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              Views.account,
                            );
                          }),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  )
                : Column(
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LoadingPlane(),
                        ],
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
