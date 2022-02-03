import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/measurements.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/data/classes/student.dart';
import 'package:appflug/data/classes/university.dart';
import 'package:appflug/enums/document_type.dart';
import 'package:appflug/shared_utils/alert_service.dart';
import 'package:appflug/shared_utils/layout_service.dart';
import 'package:appflug/shared_utils/student_service.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/back_button.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/rounded_corner_text_button.dart';
import 'package:appflug/ui/shared_widgets.dart/university_hero_logo.dart';
import 'package:appflug/ui/shared_widgets.dart/university_information.dart';
import 'package:appflug/ui/views/university_detail/widgets/h2_header.dart';
import 'package:appflug/ui/views/university_detail/widgets/review_overview.dart';
import 'package:appflug/ui/views/university_detail/widgets/university_image_list_view.dart';
import 'package:flutter/material.dart';

class UniversityDetailView extends StatefulWidget {
  final University university;

  const UniversityDetailView({
    Key? key,
    required this.university,
  }) : super(key: key);
  @override
  _UniversityDetailViewState createState() => _UniversityDetailViewState();
}

class _UniversityDetailViewState extends State<UniversityDetailView> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    Student _student = StudentService.getStudent(
      context,
      listen: true,
    )!;

    bool _isOnPreferenceList = _getIsOnPreferenceList(
      student: _student,
    );
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: LayoutService.defaultViewPadding,
          child: Column(
            children: [
              CustomBackButton(),
              Expanded(
                child: ListView(
                  children: [
                    Text(
                      widget.university.name,
                      style: AppTextStyles.montserratH3Bold,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    UniversityHeroLogo(
                      university: widget.university,
                      width: 200,
                      height: 50,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ReviewOverview(
                      university: widget.university,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: LayoutService.isDesktop(context)
                              ? 400
                              : MediaQuery.of(context).size.width -
                                  2 * sidePadding,
                          child: RoundedCornersTextButton(
                            title: _isOnPreferenceList
                                ? 'Von Präferenzliste entfernen'
                                : 'In Präferenzliste speichern',
                            backgroundColor: _isOnPreferenceList
                                ? AppColors.white
                                : AppColors.blue,
                            borderColor:
                                _isOnPreferenceList ? AppColors.blue : null,
                            textColor: _isOnPreferenceList
                                ? AppColors.red
                                : AppColors.yellow,
                            isLoading: _isLoading,
                            onTap: () {
                              setState(() {
                                _isLoading = true;
                              });
                              _savePreference(
                                context: context,
                                student: _student,
                                isRemoving: _isOnPreferenceList,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    H2Header(
                      title: 'Beschreibung',
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            widget.university.description,
                            style: AppTextStyles.montserratH6Regular,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    H2Header(
                      title: 'Bilder',
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    UniversityImageListView(
                      university: widget.university,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    H2Header(
                      title: 'Informationen',
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    UniversityInformation(
                      university: widget.university,
                      showWebsite: true,
                    ),
                    SizedBox(
                      height: sidePadding,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _getIsOnPreferenceList({
    required Student student,
  }) {
    return student
        .documents[DocumentType.preferenceList]!.preferenceList!.values
        .contains(
      widget.university.id,
    );
  }

  String _getIndexOfUniversityInPrefList({
    required Student student,
  }) {
    List<String> keys = student
        .documents[DocumentType.preferenceList]!.preferenceList!.keys
        .toList();
    return keys.firstWhere(
      (key) =>
          student
              .documents[DocumentType.preferenceList]!.preferenceList![key] ==
          widget.university.id,
    );
  }

  Future _savePreference({
    required BuildContext context,
    required Student student,
    required bool isRemoving,
  }) async {
    if (isRemoving) {
      await StudentService.setUniInPreferenceList(
        context: context,
        student: student,
        university: widget.university,
        position: _getIndexOfUniversityInPrefList(
          student: student,
        ).toString(),
        isRemoving: true,
      );
    } else {
      AlertService.showPreferenceDialog(
        context,
        onPositionSaved: (
          String position,
        ) async {
          await StudentService.setUniInPreferenceList(
            context: context,
            student: student,
            university: widget.university,
            position: position,
            isRemoving: false,
          );
        },
      );
    }

    setState(() {
      _isLoading = false;
    });
  }
}
