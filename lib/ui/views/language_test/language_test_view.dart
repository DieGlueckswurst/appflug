import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/measurements.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/data/classes/document.dart';
import 'package:appflug/enums/document_type.dart';
import 'package:appflug/shared_utils/alert_service.dart';
import 'package:appflug/shared_utils/document_service.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/circle_icon_button.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/rounded_corner_text_button.dart';
import 'package:appflug/ui/shared_widgets.dart/custom_horizontal_devider.dart';
import 'package:appflug/ui/shared_widgets.dart/file_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class LanguageTestView extends StatefulWidget {
  final Document document;

  const LanguageTestView({
    Key? key,
    required this.document,
  }) : super(key: key);
  @override
  _LanguageTestViewState createState() => _LanguageTestViewState();
}

class _LanguageTestViewState extends State<LanguageTestView> {
  bool _isLoading = false;
  PlatformFile? _pickedFile;

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
                        FilePickerView(
                          onFilePicked: (PlatformFile pickedFile) {
                            setState(() {
                              _pickedFile = pickedFile;
                            });
                          },
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
                          isEnabled: _pickedFile != null,
                          onTap: () async {
                            setState(() {
                              _isLoading = true;
                            });
                            bool wasSuccessfull = await savePdf(
                              context,
                            );

                            AlertService.showSnackBar(
                              title: wasSuccessfull
                                  ? 'Sprachzeugnis erfolgreich hochgeladen'
                                  : 'Ups, hier ist etwas schiefgelaufen',
                              description: wasSuccessfull
                                  ? 'Du kannst das Dokument in deinem Profil nachträglich noch ändern.'
                                  : 'Bitte versuche es erneut oder starte die App neu.',
                              isSuccess: wasSuccessfull,
                            );
                            if (wasSuccessfull) {
                              Navigator.pop(context);
                            }
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

  Future<bool> savePdf(BuildContext context) async {
    return await DocumentService.savePdf(
      pickedFile: _pickedFile!,
      fileName: _pickedFile!.name,
      documentType: DocumentType.languageTest,
      documentId: widget.document.id!,
      context: context,
    );
  }
}
