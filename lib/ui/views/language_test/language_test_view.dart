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
  late Document initDocumentForFilePicker;

  @override
  void initState() {
    super.initState();
    initDocumentForFilePicker = widget.document;
  }

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
                            Flexible(
                              child: Text(
                                _getTitle(),
                                style: AppTextStyles.montserratH2Bold.copyWith(
                                  color: AppColors.blue,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        FilePickerView(
                          initDocument: initDocumentForFilePicker,
                          onFilePicked: (PlatformFile pickedFile) {
                            setState(() {
                              _pickedFile = pickedFile;
                            });
                          },
                        ),
                        SizedBox(
                          height: 40,
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
                          title:
                              initDocumentForFilePicker.downloadUrl == null ||
                                      _pickedFile != null
                                  ? 'Hochladen'
                                  : 'Neues Dokument hochladen',
                          isLoading: _isLoading,
                          isEnabled:
                              initDocumentForFilePicker.downloadUrl != null ||
                                  _pickedFile != null,
                          onTap: () async {
                            setState(() {
                              _isLoading = true;
                            });

                            if (initDocumentForFilePicker.downloadUrl != null) {
                              await _uploadNewDocument();
                            } else {
                              await _savePdf(context);
                            }
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

  String _getTitle() {
    switch (widget.document.type) {
      case DocumentType.languageTest:
        return 'Sprachzeugnis';
      case DocumentType.letterOfMotivation:
        return 'Motivationsschreiben';
      case DocumentType.transcriptOfRecords:
        return 'Transcript of Records';
      case DocumentType.preferenceList:
        return '';
      case DocumentType.passport:
        return 'Personalausweis/Reisepass';
    }
  }

  Future<void> _savePdf(BuildContext context) async {
    bool wasSuccessfull = await DocumentService.savePdf(
      pickedFile: _pickedFile!,
      fileName: _pickedFile!.name,
      documentType: widget.document.type,
      documentId: widget.document.id!,
      context: context,
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
  }

  Future<void> _uploadNewDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'pdf',
      ],
    );
    setState(
      () {
        if (result != null) {
          if (result.files.first.size > 5000000) {
            AlertService.showSnackBar(
              title: 'Fehler: Datei ist zu groß.',
              description: 'Das Dokument darf nicht größer als 5 MB sein.',
              isSuccess: false,
            );
          } else {
            _pickedFile = result.files.first;
            initDocumentForFilePicker = Document(
              type: widget.document.type,
              name: _pickedFile!.name,
            );
          }
        }
        _isLoading = false;
      },
    );
  }
}
