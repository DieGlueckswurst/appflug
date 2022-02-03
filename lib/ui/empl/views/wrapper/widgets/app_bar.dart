import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/measurements.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/data/backend/authentication.dart';
import 'package:appflug/routes/views.dart';
import 'package:appflug/shared_utils/alert_service.dart';
import 'package:appflug/shared_utils/layout_service.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/circle_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppBarForEmpl extends PreferredSize {
  AppBarForEmpl({
    Key? key,
    required BuildContext context,
  }) : super(
          key: key,
          preferredSize: Size.fromHeight(
            100 +
                LayoutService.safeAreaTop(
                  context,
                ),
          ),
          child: Container(
            height: 100 +
                LayoutService.safeAreaTop(
                  context,
                ),
            decoration: BoxDecoration(color: AppColors.blue, boxShadow: [
              BoxShadow(
                color: AppColors.grey,
                offset: Offset(0, -5),
                spreadRadius: 5,
                blurRadius: 10,
              )
            ]),
            child: Padding(
              padding: EdgeInsets.only(
                top: LayoutService.safeAreaTop(
                  context,
                ),
              ),
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
                    style: LayoutService.isDesktop(context)
                        ? AppTextStyles.montserratH1Bold.copyWith(
                            color: AppColors.white,
                          )
                        : AppTextStyles.montserratH2Bold.copyWith(
                            color: AppColors.white,
                          ),
                  ),
                  Spacer(),
                  CircleIconButton(
                    onTapped: () async {
                      bool wasSuccessfull = await AuthenticationService.signOut(
                        context: context,
                      );
                      AlertService.showSnackBar(
                        title: wasSuccessfull
                            ? 'Erfolgreich ausgeloggt'
                            : 'Beim ausloggen ist etwas schiefgelaufen.',
                        description: wasSuccessfull
                            ? 'AppFlug ist übrigens auf iOS, Android und im Web verfügbar.'
                            : 'Bitte versuche es erneut oder starte die App neu.',
                        isSuccess: wasSuccessfull,
                      );
                      if (wasSuccessfull) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          Views.start,
                          (route) => false,
                        );
                      }
                    },
                    svgPath: 'assets/icons/logout.svg',
                    svgColor: AppColors.white,
                  ),
                  SizedBox(
                    width: sidePadding,
                  ),
                ],
              ),
            ),
          ),
        );
}
