import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/measurements.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/data/classes/student.dart';
import 'package:appflug/data/classes/university.dart';
import 'package:appflug/enums/document_type.dart';
import 'package:appflug/enums/views.dart';
import 'package:appflug/routes/views.dart';
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
  bool _isLoading = false;

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
                        child: Stack(
                          children: [
                            Column(
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
                                              style: AppTextStyles
                                                  .montserratH2Bold,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 100,
                                          child: Center(
                                            child: Text(
                                              '2.',
                                              style: AppTextStyles
                                                  .montserratH2Bold,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 100,
                                          child: Center(
                                            child: Text(
                                              '3.',
                                              style: AppTextStyles
                                                  .montserratH2Bold,
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
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          onReorder: (
                                            int oldIndex,
                                            int newIndex,
                                          ) async {
                                            setState(() {
                                              _isLoading = true;
                                            });
                                            await _saveReorderedList(
                                              student: _student,
                                              universities: _universities!,
                                              oldIndex: oldIndex,
                                              newIndex: newIndex,
                                            );
                                          },
                                          children: [
                                            ..._student
                                                .documents[DocumentType
                                                    .preferenceList]!
                                                .preferenceList!
                                                .keys
                                                .map(
                                                  (key) => PreferenceListTile(
                                                    key: Key(key),
                                                    student: _student,
                                                    universities:
                                                        _universities!,
                                                    position: key,
                                                    onTap: (university) {
                                                      Navigator.pushNamed(
                                                        context,
                                                        Views.universityDetail,
                                                        arguments: university,
                                                      );
                                                    },
                                                  ),
                                                )
                                                .toList(),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                RoundedCornersTextButton(
                                  title: 'Universität finden',
                                  onTap: () {
                                    Navigator.pop(
                                      context,
                                    );
                                    NavBarService.setSelectedView(
                                      context: context,
                                      viewToSelect: NavBarView.university,
                                    );
                                  },
                                ),
                                SizedBox(
                                  height: sidePadding,
                                )
                              ],
                            ),
                            AnimatedSwitcher(
                              duration: kThemeAnimationDuration,
                              child: _isLoading
                                  ? Container(
                                      height: 320,
                                      color: AppColors.white.withOpacity(0.8),
                                      child: Center(
                                        child: LoadingPlane(),
                                      ),
                                    )
                                  : SizedBox.shrink(),
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

  Future<void> _saveReorderedList({
    required Student student,
    required List<University> universities,
    required int oldIndex,
    required int newIndex,
  }) async {
    String oldPosition = (oldIndex + 1).toString();

    String newPoisiton =
        oldIndex > newIndex ? (newIndex + 1).toString() : (newIndex).toString();

    String oldUniversityId = student
        .documents[DocumentType.preferenceList]!.preferenceList![oldPosition]!;
    String newUniversityId = student
        .documents[DocumentType.preferenceList]!.preferenceList![newPoisiton]!;

    await StudentService.reorderPreferenceList(
      context: context,
      student: student,
      oldUniversityId: oldUniversityId,
      oldPosition: oldPosition,
      newUniversityId: newUniversityId,
      newPosition: newPoisiton,
    );

    setState(() {
      _isLoading = false;
    });
  }
}
