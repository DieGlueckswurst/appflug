import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/data/classes/university.dart';
import 'package:appflug/shared_utils/string_service.dart';
import 'package:appflug/shared_utils/url_launch_service.dart';
import 'package:appflug/ui/views/course/utils/course_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UniversityInformation extends StatelessWidget {
  final University university;
  final bool showWebsite;

  const UniversityInformation({
    Key? key,
    required this.university,
    required this.showWebsite,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (showWebsite) ...[
          GestureDetector(
            onTap: () {
              openURL(
                context,
                url: university.websiteUrl,
              );
            },
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                SvgPicture.asset(
                  'assets/icons/website.svg',
                  width: 15,
                ),
                SizedBox(
                  width: 20,
                ),
                Flexible(
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Text(
                      university.websiteUrl,
                      style: AppTextStyles.montserratH6Regular.copyWith(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
        ],
        Row(
          children: [
            SizedBox(
              width: 10,
            ),
            SvgPicture.asset(
              'assets/icons/location.svg',
              width: 15,
            ),
            SizedBox(
              width: 20,
            ),
            Flexible(
              child: Text(
                university.city +
                    ',\n' +
                    university.countryCode.toFullCountryName(),
                style: AppTextStyles.montserratH6Regular,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          children: [
            SizedBox(
              width: 10,
            ),
            SvgPicture.asset(
              'assets/icons/average.svg',
              width: 15,
            ),
            SizedBox(
              width: 20,
            ),
            Flexible(
              child: Text(
                'erford. Notendurchschnitt: ${university.requiredGPA}',
                style: AppTextStyles.montserratH6Regular,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          children: [
            SizedBox(
              width: 10,
            ),
            SvgPicture.asset(
              'assets/icons/student_hat.svg',
              width: 15,
            ),
            SizedBox(
              width: 20,
            ),
            Flexible(
              child: Text(
                _getCoursesString(),
                style: AppTextStyles.montserratH6Regular,
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _getCoursesString() {
    String coursesString = '';
    for (var course in university.coursesOfStudy) {
      coursesString += '${CourseService.enumToString(course)},\n';
    }
    return coursesString.removeLastCharacter().removeLastCharacter();
  }
}
