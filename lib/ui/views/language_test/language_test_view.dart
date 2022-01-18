import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/measurements.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/circle_icon_button.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/rounded_corner_text_button.dart';
import 'package:appflug/ui/shared_widgets.dart/custom_horizontal_devider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LanguageTestView extends StatefulWidget {
  @override
  _LanguageTestViewState createState() => _LanguageTestViewState();
}

class _LanguageTestViewState extends State<LanguageTestView> {
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
                Expanded(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: 400,
                    ),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Sprachzeugnis',
                              style: AppTextStyles.montserratH2Bold.copyWith(
                                color: AppColors.blue,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Center(
                          child: Container(
                            height: 200,
                            width: 180,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.blue,
                                width: 3,
                              ),
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/upload.svg',
                                    height: 30,
                                    color: AppColors.blue,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'Datei wählen',
                                    style: AppTextStyles.montserratH6SemiBold,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomHorizontalDevider(),
                        ExpansionTile(
                          title: Text(
                            'Hinweise',
                            style: AppTextStyles.montserratH5SemiBold.copyWith(
                              color: AppColors.blue,
                            ),
                          ),
                          collapsedIconColor: AppColors.blue,
                          iconColor: AppColors.blue,
                          children: [
                            ListTile(
                              enableFeedback: false,
                              title: Text(
                                'Mindestniveau für Englisch und Französisch: B2, für alle anderen Sprachen: B1(bzgl. Ausnahmen bitte Angaben im Bewerberkreis beachten)! \n\nDas Zeugnis über Kenntnisse in der Unterrichtssprache ist sowohl für Ihren Erstwunsch, als auch für alle Universitäten auf der Präferenzliste bereits zum Zeitpunkt der Bewerbung erforderlich. Falls Sie also auf der Präferenzliste Hochschulen mit verschiedenen Sprachen mischen, müssen Sie entsprechend auch Zeugnisse für die entsprechenden Sprachen mit abgegeben. \n\nEin späteres Nachreichen ist nicht möglich! \n\nDas Sprachzeugnis entfällt für Universitäten, an denen die Unterrichtssprache Deutsch ist.\n',
                                style: AppTextStyles.montserratH6Regular,
                              ),
                            )
                          ],
                        ),
                        CustomHorizontalDevider(),
                        SizedBox(
                          height: 30,
                        ),
                        RoundedCornersTextButton(
                          title: 'Hochladen',
                          isLoading: _isLoading,
                          onTap: () async {
                            setState(() {
                              _isLoading = true;
                            });

                            setState(() {
                              _isLoading = false;
                            });
                          },
                        ),
                        SizedBox(
                          height: sidePadding,
                        )
                      ],
                    ),
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
