import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/data/backend/authentication.dart';
import 'package:appflug/routes/app_router.dart';
import 'package:appflug/routes/views.dart';
import 'package:appflug/shared_utils/colors_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'constants/app_colors.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppFlug',
      navigatorKey: Get.key,
      theme: ThemeData(
        fontFamily: AppTextStyles.montserrat,
        primarySwatch: ColorService.createMaterialColor(
          AppColors.blue,
        ),
        backgroundColor: AppColors.white,
        scaffoldBackgroundColor: AppColors.white,
      ),
      initialRoute:
          AuthenticationService.isLoggedIn() ? Views.home : Views.start,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
