import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/enums/views.dart';
import 'package:flutter/material.dart';

import 'bottom_nav_bar_item.dart';

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: AppColors.lightGrey,
                width: 1,
              ),
            ),
            color: AppColors.transparent,
          ),
          height: 49,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              BottomNavBarItem(
                view: NavBarView.home,
              ),
              BottomNavBarItem(
                view: NavBarView.university,
              ),
              BottomNavBarItem(
                view: NavBarView.faq,
              ),
              BottomNavBarItem(
                view: NavBarView.settings,
              ),
            ],
          ),
        ),
        Container(
          height: MediaQuery.of(context).padding.bottom,
          color: AppColors.white,
        )
      ],
    );
  }
}
