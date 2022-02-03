import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/data/classes/student.dart';
import 'package:appflug/data/classes/university.dart';
import 'package:appflug/enums/document_type.dart';
import 'package:appflug/enums/views.dart';
import 'package:appflug/ui/shared_widgets.dart/university_hero_logo.dart';
import 'package:appflug/ui/views/navigation/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class PreferenceListTile extends StatelessWidget {
  final Student student;
  final List<University> universities;
  final String position;
  final Function(University) onTap;

  const PreferenceListTile({
    Key? key,
    required this.student,
    required this.universities,
    required this.position,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    University? _university = _getUniversity(
      student: student,
      universities: universities,
      position: position,
    );
    return GestureDetector(
      onTap: () {
        if (_university != null) {
          onTap(_university);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 5,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            border: Border.all(
              color: AppColors.blue,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
          key: Key(position),
          padding: EdgeInsets.all(
            20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _university != null
                  ? UniversityHeroLogo(
                      university: _university,
                      width: 200,
                      height: 40,
                      isHeroEnabled: NavBarService.getSelectedView(context) !=
                          NavBarView.university,
                    )
                  : SizedBox(
                      height: 40,
                      child: Center(
                        child: Text(
                          'keine Universität',
                          style: AppTextStyles.montserratH6SemiBold,
                        ),
                      ),
                    ),
              SizedBox(
                width: 10,
              ),
              if (!kIsWeb)
                SvgPicture.asset(
                  'assets/icons/reorder.svg',
                  color: AppColors.yellow,
                  height: 10,
                )
            ],
          ),
        ),
      ),
    );
  }

  University? _getUniversity({
    required Student student,
    required List<University> universities,
    required String position,
  }) {
    University? university = universities.firstWhereOrNull(
      (university) =>
          university.id ==
          student.documents[DocumentType.preferenceList]!
              .preferenceList![position],
    );

    return university;
  }
}
