import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/measurements.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/data/classes/student.dart';
import 'package:appflug/data/classes/university.dart';
import 'package:appflug/enums/views.dart';
import 'package:appflug/shared_utils/layout_service.dart';
import 'package:appflug/shared_utils/student_service.dart';
import 'package:appflug/shared_utils/university_service.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/back_button.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/rounded_corner_text_button.dart';
import 'package:appflug/ui/shared_widgets.dart/hero_header.dart';
import 'package:appflug/ui/shared_widgets.dart/lottie_animations/loading_plane.dart';
import 'package:appflug/ui/views/navigation/utils.dart';
import 'package:appflug/ui/views/preference_list/widgets/preference_list_tile.dart';
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

    List<University>? _universities = UniversityService.getUniversities(
      context: context,
      listen: true,
    );
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: LayoutService.defaultViewPadding,
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
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 100,
                                      child: Center(
                                        child: Text(
                                          '1.',
                                          style: AppTextStyles.montserratH2Bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 100,
                                      child: Center(
                                        child: Text(
                                          '2.',
                                          style: AppTextStyles.montserratH2Bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 100,
                                      child: Center(
                                        child: Text(
                                          '3.',
                                          style: AppTextStyles.montserratH2Bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Theme(
                                    data: ThemeData(
                                      canvasColor: AppColors.transparent,
                                    ),
                                    child: ReorderableListView(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      onReorder:
                                          (int oldIndex, int newIndex) {},
                                      children: [
                                        PreferenceListTile(
                                          key: Key('1'),
                                          student: _student,
                                          universities: _universities!,
                                          position: '1',
                                        ),
                                        PreferenceListTile(
                                          key: Key('2'),
                                          student: _student,
                                          universities: _universities,
                                          position: '2',
                                        ),
                                        PreferenceListTile(
                                          key: Key('3'),
                                          student: _student,
                                          universities: _universities,
                                          position: '3',
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            RoundedCornersTextButton(
                              title: 'Zu den Universitäten',
                              backgroundColor: AppColors.white,
                              textColor: AppColors.blue,
                              onTap: () {
                                Navigator.pop(context);
                                NavBarService.setSelectedView(
                                  context: context,
                                  viewToSelect: NavBarView.university,
                                );
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
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
