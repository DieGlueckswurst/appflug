import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String? description;
  final VoidCallback onTap;
  final Color? backgroundColor;

  const CustomListTile({
    Key? key,
    required this.title,
    required this.onTap,
    this.description,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(
            20,
          ),
          decoration: BoxDecoration(
            color: backgroundColor ?? AppColors.white,
            border: Border.all(
              color: AppColors.blue,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.montserratH6SemiBold,
                    ),
                    if (description != null) ...[
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        description!,
                        style: AppTextStyles.montserratH6Regular,
                      ),
                    ]
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              SvgPicture.asset(
                'assets/icons/arrow_right.svg',
                color: AppColors.blue,
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
