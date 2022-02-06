import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/box_decoration.dart';
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
          color: isSelected ? AppColors.yellow : AppColors.white,
          border: Border.all(
            color: AppColors.blue,
            width: defaultBorderWith,
          ),
          borderRadius: BorderRadius.circular(
            defaultBorderRadius,
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
                  width: defaultBorderWith,
                  color: AppColors.blue,
                ),
                color: AppColors.white,
              ),
              child: isSelected
                  ? Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.blue,
                        border: Border.all(
                          color: AppColors.white,
                          width: defaultBorderWith,
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
                CourseService.enumToString(
                  course,
                ),
                style: AppTextStyles.montserratH6Regular.copyWith(
                  color: AppColors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
