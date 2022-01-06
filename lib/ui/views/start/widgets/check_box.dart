import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/measurements.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CheckBox extends StatefulWidget {
  final Function(bool) onCheckedChanged;

  const CheckBox({required this.onCheckedChanged});

  @override
  _CheckBoxState createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBox> {
  bool isChecked = true;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
        });
        widget.onCheckedChanged(
          isChecked,
        );
      },
      child: Container(
        height: touchTargetForButtons,
        width: touchTargetForButtons,
        color: AppColors.transparent,
        child: Center(
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.darkBlue,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Visibility(
              visible: isChecked,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: SvgPicture.asset(
                  'assets/icons/correct.svg',
                  color: AppColors.darkBlue,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
