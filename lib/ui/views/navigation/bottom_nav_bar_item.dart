import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/enums/views.dart';
import 'package:appflug/ui/views/navigation/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavBarItem extends StatefulWidget {
  final NavBarView view;

  const BottomNavBarItem({Key? key, required this.view}) : super(key: key);

  @override
  _BottomNavBarItemState createState() => _BottomNavBarItemState();
}

class _BottomNavBarItemState extends State<BottomNavBarItem> {
  @override
  Widget build(BuildContext context) {
    bool _isSelected = _getIsSelected(context);
    return Expanded(
      child: GestureDetector(
        onTap: () {
          BottomNavBarService.setSelectedView(
            context: context,
            viewToSelect: widget.view,
          );
        },
        child: Container(
          color: AppColors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                _getIconPath(),
                height: 25,
                color: _isSelected ? AppColors.blue : AppColors.grey,
              ),
              // Text(
              //   _getTitle(),
              //   style: AppTextStyles.montserratH7Regular.copyWith(
              //     color: _isSelected ? AppColors.blue : AppColors.grey,
              //     fontWeight: _isSelected ? FontWeight.w700 : FontWeight.w400,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  bool _getIsSelected(BuildContext context) {
    return widget.view == BottomNavBarService.getSelectedView(context);
  }

  String _getIconPath() {
    String basePath = 'assets/icons/';
    switch (widget.view) {
      case NavBarView.home:
        return '${basePath}home.svg';
      case NavBarView.university:
        return '${basePath}university.svg';
      case NavBarView.faq:
        return '${basePath}faq.svg';
      case NavBarView.settings:
        return '${basePath}profile.svg';
    }
  }

  String _getTitle() {
    switch (widget.view) {
      case NavBarView.home:
        return 'Home';
      case NavBarView.university:
        return 'Suche';
      case NavBarView.faq:
        return 'FAQ';
      case NavBarView.settings:
        return 'Einstellungen';
    }
  }
}
