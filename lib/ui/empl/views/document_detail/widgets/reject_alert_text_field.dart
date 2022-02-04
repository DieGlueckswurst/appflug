import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/measurements.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/rounded_corner_text_button.dart';
import 'package:flutter/material.dart';

class RejectAlertTextField extends StatefulWidget {
  final Function(String) onReject;

  const RejectAlertTextField({
    Key? key,
    required this.onReject,
  }) : super(key: key);

  @override
  _RejectAlertTextFieldState createState() => _RejectAlertTextFieldState();
}

class _RejectAlertTextFieldState extends State<RejectAlertTextField> {
  String _text = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 300,
          decoration: BoxDecoration(
            color: AppColors.white,
            border: Border.all(
              color: AppColors.blue,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
          padding: EdgeInsets.all(
            sidePadding,
          ),
          child: TextFormField(
            maxLines: null,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              hintText: 'Begründung eingeben...',
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
            style: AppTextStyles.montserratH4Regular,
            onChanged: (text) {
              setState(() {
                _text = text;
              });
            },
          ),
        ),
        SizedBox(
          height: 30,
        ),
        RoundedCornersTextButton(
          isEnabled: _text.isNotEmpty,
          title: 'Dokument ablehnen',
          backgroundColor: AppColors.red,
          textColor: AppColors.white,
          onTap: () {
            widget.onReject(
              _text,
            );
          },
        ),
        SizedBox(
          height: 20,
        ),
        RoundedCornersTextButton(
          title: 'Abbrechen',
          backgroundColor: AppColors.white,
          textColor: AppColors.blue,
          onTap: () {
            Navigator.pop(
              context,
            );
          },
        ),
      ],
    );
  }
}
