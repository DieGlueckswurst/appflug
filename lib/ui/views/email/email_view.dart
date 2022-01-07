import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/measurements.dart';
import 'package:appflug/constants/other.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/routes/views.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/circle_icon_button.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/rounded_corner_text_button.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/textfield_with_rounded_border.dart';
import 'package:flutter/material.dart';

class EmailView extends StatefulWidget {
  @override
  State<EmailView> createState() => _EmailViewState();
}

class _EmailViewState extends State<EmailView> {
  String _email = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10,
            left: sidePadding,
            right: sidePadding,
          ),
          child: Center(
            child: Column(
              children: [
                Row(
                  children: [
                    CircleIconButton(
                      onTapped: () {
                        Navigator.pop(context);
                      },
                      svgPath: 'assets/icons/arrow_left.svg',
                      svgColor: AppColors.blue,
                      backgroundColor: AppColors.transparent,
                      svgSize: 22,
                      alignment: Alignment.centerLeft,
                    ),
                  ],
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 400,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email',
                        style: AppTextStyles.montserratH2Bold.copyWith(
                          color: AppColors.blue,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: TextFieldWithRoundedBorder(
                              onChanged: (email) {
                                setState(() {
                                  _email = email;
                                });
                              },
                              hintText: 'vorname.nachname',
                              focusOnInit: true,
                              textInputType: TextInputType.emailAddress,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            studEmailEnding,
                            style: AppTextStyles.montserratH7Regular,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RoundedCornersTextButton(
                        title: 'Weiter',
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Views.signUp,
                            arguments: _email + studEmailEnding,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
