import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/data/classes/university.dart';
import 'package:appflug/shared_utils/review._service.dart';
import 'package:appflug/shared_utils/string_service.dart';
import 'package:appflug/ui/views/course/utils/course_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'flag_emoji.dart';

class UniversityCard extends StatelessWidget {
  final University university;

  const UniversityCard({
    Key? key,
    required this.university,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(
          10,
        ),
        border: Border.all(
          width: 3,
          color: AppColors.blue,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(
          15,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                    border: Border.all(
                      width: 3,
                      color: AppColors.blue,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      university.logoDownloadUrl,
                      height: 25,
                      fit: BoxFit.fill,
                      loadingBuilder: (
                        BuildContext context,
                        Widget child,
                        ImageChunkEvent? loadingProgress,
                      ) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Spacer(),
                FlagEmoji(
                  countryCode: university.countryCode,
                  size: 25,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
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
                Text(
                  university.city +
                      ',\n' +
                      university.countryCode.toFullCountryName(),
                  style: AppTextStyles.montserratH6Regular,
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
                Text(
                  'erford. Notendurchschnitt: ${university.requiredGPA}',
                  style: AppTextStyles.montserratH6Regular,
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
                Text(
                  _getCoursesString(),
                  style: AppTextStyles.montserratH6Regular,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.asset(
                  'assets/icons/star.svg',
                  height: 15,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  ReviewService.getReviewAverage(university.reviews).toString(),
                  style: AppTextStyles.montserratH6SemiBold,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  '( ${university.reviews.length.toString()} )',
                  style: AppTextStyles.montserratH6Regular.copyWith(
                    color: AppColors.grey,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  String _getCoursesString() {
    String coursesString = '';
    for (var course in university.coursesOfStudy) {
      coursesString += '${CourseService.courses[course]!},\n';
    }
    return coursesString.removeLastCharacter().removeLastCharacter();
  }
}
