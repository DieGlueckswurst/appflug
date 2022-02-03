import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/measurements.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/shared_utils/student_service.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/rounded_corner_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReadyForApplicationView extends StatefulWidget {
  @override
  State<ReadyForApplicationView> createState() =>
      _ReadyForApplicationViewState();
}

class _ReadyForApplicationViewState extends State<ReadyForApplicationView> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          'assets/icons/warning.svg',
          color: AppColors.red,
          height: 50,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          'Bitte überprüfe vor dem Abschicken noch einmal all deine Dokumente auf Vollständigkeit und Richtigkeit.',
          style: AppTextStyles.montserratH6SemiBold,
        ),
        SizedBox(
          height: 20,
        ),
        RoundedCornersTextButton(
          isLoading: _isLoading,
          title: 'Bewerbung abschicken',
          onTap: () async {
            setState(() {
              _isLoading = true;
            });
            await _apply(
              context,
            );
          },
        ),
        SizedBox(
          height: sidePadding,
        ),
      ],
    );
  }

  Future<bool> _apply(
    BuildContext context,
  ) async {
    return await StudentService.apply(
      context: context,
    );
  }
}
