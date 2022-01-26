import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/enums/views.dart';
import 'package:appflug/ui/views/navigation/utils.dart';
import 'package:flutter/material.dart';

class AppBarForWebItem extends StatefulWidget {
  final NavBarView view;

  const AppBarForWebItem({
    Key? key,
    required this.view,
  }) : super(key: key);

  @override
  State<AppBarForWebItem> createState() => _AppBarForWebItemState();
}

class _AppBarForWebItemState extends State<AppBarForWebItem> {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          NavBarService.setSelectedView(
            context: context,
            viewToSelect: widget.view,
          );
        },
        child: Container(
          color: AppColors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _getTitle(),
                style: _getIsSelected(context)
                    ? AppTextStyles.montserratH2Bold.copyWith(
                        color: AppColors.white,
                      )
                    : AppTextStyles.montserratH2SemiBold.copyWith(
                        color: AppColors.white,
                      ),
              ),
              if (_getIsSelected(context))
                Container(
                  height: 5,
                  width: 20,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(
                      3,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  bool _getIsSelected(BuildContext context) {
    return widget.view == NavBarService.getSelectedView(context);
  }

  String _getTitle() {
    switch (widget.view) {
      case NavBarView.home:
        return 'Home';
      case NavBarView.university:
        return 'Universitäten';
      case NavBarView.faq:
        return 'FAQ';
      case NavBarView.settings:
        return 'Profil';
    }
  }
}
