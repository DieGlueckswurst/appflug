import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/measurements.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/shared_utils/alert_service.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/circle_icon_button.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/rounded_corner_text_button.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/textfield_with_rounded_border.dart';
import 'package:appflug/ui/views/birthplace/utils/birthplace_service.dart';
import 'package:flutter/material.dart';

class BirthplaceView extends StatefulWidget {
  @override
  _BirthplaceViewViewState createState() => _BirthplaceViewViewState();
}

class _BirthplaceViewViewState extends State<BirthplaceView> {
  String _birthplace = '';
  bool _isLoading = false;
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
                        'Geburtsort',
                        style: AppTextStyles.montserratH2Bold.copyWith(
                          color: AppColors.blue,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFieldWithRoundedBorder(
                        onChanged: (birthplace) {
                          setState(() {
                            _birthplace = birthplace.trim();
                          });
                        },
                        hintText: 'Geburtsort eingeben',
                        focusOnInit: true,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RoundedCornersTextButton(
                        title: 'Speichern',
                        isLoading: _isLoading,
                        onTap: () async {
                          setState(() {
                            _isLoading = true;
                          });
                          _birthplace.isNotEmpty
                              ? _saveBirthplace(context)
                              : AlertService.showSnackBar(
                                  title: 'Ungültiger Geburtsort',
                                  description:
                                      'Bitte gib einen gültigen Geburtsort ein.',
                                  isSuccess: false,
                                );

                          setState(() {
                            _isLoading = false;
                          });
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

  Future<void> _saveBirthplace(BuildContext context) async {
    bool wasSuccessfull = await BirthplaceService.setBirthplace(
      context: context,
      birthplace: _birthplace,
    );

    if (wasSuccessfull) {
      AlertService.showSnackBar(
        title: 'Geburtsort gespeichert',
        description: '',
        isSuccess: true,
      );
      Navigator.pop(context);
    }

    setState(() {
      _isLoading = false;
    });
  }
}