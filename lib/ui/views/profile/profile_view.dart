import 'package:appflug/constants/measurements.dart';
import 'package:appflug/data/classes/student.dart';
import 'package:appflug/shared_utils/student_service.dart';
import 'package:appflug/enums/views.dart';
import 'package:appflug/routes/views.dart';
import 'package:appflug/shared_utils/layout_service.dart';
import 'package:appflug/ui/shared_widgets.dart/custom_list_tile.dart';
import 'package:appflug/ui/shared_widgets.dart/hero_header.dart';
import 'package:appflug/ui/shared_widgets.dart/lottie_animations/loading_plane.dart';
import 'package:appflug/ui/views/navigation/utils.dart';
import 'package:flutter/material.dart';

class SettingsView extends StatefulWidget {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    Student? _student = StudentService.getStudent(
      context,
      listen: true,
    );
    return SafeArea(
      child: Padding(
        padding: LayoutService.getSidePaddingDependingOnDeviceSize(
          context,
        ),
        child: Column(
          children: [
            HeroHeader(
              isEnabled:
                  NavBarView.settings == NavBarService.getSelectedView(context),
              title: 'Mein Profil',
            ),
            SizedBox(
              height: 30,
            ),
            _student != null
                ? Expanded(
                    child: ConstrainedBox(
                      constraints: webMaxWidthConstraint,
                      child: Column(
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
                      ),
                    ),
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
