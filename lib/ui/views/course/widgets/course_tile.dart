import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/enums/courses.dart';
import 'package:appflug/ui/views/course/utils/course_service.dart';
import 'package:flutter/material.dart';

class CourseTile extends StatelessWidget {
  final Course course;
  final bool isSelected;
  final Function(Course) onCourseChange;

  const CourseTile({
    Key? key,
    required this.course,
    required this.isSelected,
    required this.onCourseChange,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onCourseChange(course);
      },
      child: Container(
        padding: EdgeInsets.all(
          20,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.blue,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 3,
                  color: AppColors.blue,
                ),
                color: AppColors.white,
              ),
              child: isSelected
                  ? Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.yellow,
                        border: Border.all(
                          color: AppColors.white,
                          width: 3,
                        ),
                      ),
                    )
                  : null,
            ),
            SizedBox(
              width: 20,
            ),
            Flexible(
              child: Text(
                CourseService.courses[course]!,
                style: AppTextStyles.montserratH6Regular,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
