import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/enums/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'app_bar_item.dart';

class AppBarForWeb extends PreferredSize {
  AppBarForWeb({
    Key? key,
    required BuildContext context,
  }) : super(
          key: key,
          preferredSize: Size.fromHeight(100),
          child: Container(
            height: 100,
            decoration: BoxDecoration(color: AppColors.blue, boxShadow: [
              BoxShadow(
                color: AppColors.grey,
                offset: Offset(0, -5),
                spreadRadius: 5,
                blurRadius: 10,
              )
            ]),
            child: Row(
              children: [
                SizedBox(
                  width: 50,
                ),
                SvgPicture.asset(
                  'assets/images/logo.svg',
                  width: 40,
                ),
                SizedBox(
                  width: 30,
                ),
                Text(
                  'AppFlug',
                  style: AppTextStyles.montserratH1Bold.copyWith(
                    color: AppColors.white,
                  ),
                ),
                Spacer(),
                AppBarForWebItem(
                  view: NavBarView.home,
                ),
                SizedBox(
                  width: 50,
                ),
                AppBarForWebItem(
                  view: NavBarView.university,
                ),
                SizedBox(
                  width: 50,
                ),
                AppBarForWebItem(
                  view: NavBarView.faq,
                ),
                SizedBox(
                  width: 50,
                ),
                AppBarForWebItem(
                  view: NavBarView.settings,
                ),
                Spacer(),
              ],
            ),
          ),
        );
}
