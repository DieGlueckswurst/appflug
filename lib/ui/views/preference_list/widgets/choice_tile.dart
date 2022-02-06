import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/box_decoration.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:flutter/material.dart';

class PreferenceListPositionTile extends StatelessWidget {
  final String position;
  final bool isSelected;
  final Function(String) onCourseChange;

  const PreferenceListPositionTile({
    Key? key,
    required this.position,
    required this.isSelected,
    required this.onCourseChange,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onCourseChange(position);
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
                position + '. Wahl',
                style: AppTextStyles.montserratH5SemiBold.copyWith(
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
