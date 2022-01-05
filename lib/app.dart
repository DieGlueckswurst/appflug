import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/shared_utils/colors_service.dart';
import 'package:appflug/ui/start/start_view.dart';
import 'package:flutter/material.dart';

import 'constants/app_colors.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppFlug',
      theme: ThemeData(
        fontFamily: AppTextStyles.montserrat,
        primarySwatch: ColorService.createMaterialColor(
          AppColors.blue,
        ),
      ),
      home: const StartView(),
    );
  }
}
