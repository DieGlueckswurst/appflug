import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const CustomListTile({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              title,
              style: AppTextStyles.montserratH6Regular,
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
    );
  }
}
