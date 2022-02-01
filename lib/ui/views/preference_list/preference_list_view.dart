import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/measurements.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/data/classes/student.dart';
import 'package:appflug/shared_utils/student_service.dart';
import 'package:appflug/routes/views.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/back_button.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/rounded_corner_text_button.dart';
import 'package:appflug/ui/shared_widgets.dart/custom_list_tile.dart';
import 'package:appflug/ui/shared_widgets.dart/hero_header.dart';
import 'package:appflug/ui/shared_widgets.dart/lottie_animations/loading_plane.dart';
import 'package:flutter/material.dart';

class PreferenceListView extends StatefulWidget {
  @override
  _PreferenceListViewState createState() => _PreferenceListViewState();
}

class _PreferenceListViewState extends State<PreferenceListView> {
  @override
  Widget build(BuildContext context) {
    Student? _student = StudentService.getStudent(
      context,
      listen: true,
    );
    return Scaffold(
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
                isEnabled: true,
                title: 'Präferenzliste',
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
                            Row(
                              children: [
                                Container(
                                  color: AppColors.green,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 30,
                                        width: 20,
                                        color: AppColors.red,
                                      ),
                                      Text(
                                        '1',
                                        style: AppTextStyles.montserratH2Bold,
                                      ),
                                      Text(
                                        '2',
                                        style: AppTextStyles.montserratH2Bold,
                                      ),
                                      Text(
                                        '3',
                                        style: AppTextStyles.montserratH2Bold,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: ReorderableListView(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    onReorder: (int oldIndex, int newIndex) {},
                                    children: [
                                      CustomListTile(
                                          key: Key('1'),
                                          title: 'Persönliche Daten',
                                          onTap: () {
                                            Navigator.pushNamed(
                                              context,
                                              Views.personalData,
                                            );
                                          }),
                                      CustomListTile(
                                          key: Key('2'),
                                          title: 'Dokumente',
                                          onTap: () {
                                            Navigator.pushNamed(
                                              context,
                                              Views.documents,
                                            );
                                          }),
                                      CustomListTile(
                                          key: Key('3'),
                                          title: 'Konto',
                                          onTap: () {
                                            Navigator.pushNamed(
                                              context,
                                              Views.account,
                                            );
                                          }),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            RoundedCornersTextButton(
                              title: 'Speichern',
                              onTap: () {},
                            ),
                            SizedBox(
                              height: sidePadding,
                            )
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
      ),
    );
  }
}
