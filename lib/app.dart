import 'package:appflug/constants/other.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/data/backend/authentication.dart';
import 'package:appflug/data/provider/bottom_nav_bar_provider.dart';
import 'package:appflug/data/provider/student_provider.dart';
import 'package:appflug/data/provider/university_provider.dart';
import 'package:appflug/routes/app_router.dart';
import 'package:appflug/routes/view_for_empl.dart';
import 'package:appflug/routes/views.dart';
import 'package:appflug/shared_utils/colors_service.dart';
import 'package:appflug/shared_utils/custom_scroll_behavior_for_web.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'constants/app_colors.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NavBarProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => StudentProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UniversityProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'AppFlug',
        navigatorKey: Get.key,
        scrollBehavior: MyCustomScrollBehavior(),
        theme: ThemeData(
          fontFamily: AppTextStyles.montserrat,
          primarySwatch: ColorService.createMaterialColor(
            AppColors.blue,
          ),
          backgroundColor: AppColors.white,
          scaffoldBackgroundColor: AppColors.white,
        ),
        initialRoute: !AuthenticationService.isLoggedIn()
            ? Views.start
            : AuthenticationService.currentUser!.email!
                    .endsWith(studEmailEnding)
                ? Views.home
                : ViewsForEmpl.wrapper,
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
