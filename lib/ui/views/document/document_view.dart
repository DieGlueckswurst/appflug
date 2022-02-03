import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/measurements.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/data/classes/document.dart';
import 'package:appflug/enums/document_type.dart';
import 'package:appflug/shared_utils/alert_service.dart';
import 'package:appflug/shared_utils/document_service.dart';
import 'package:appflug/shared_utils/layout_service.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/back_button.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/rounded_corner_text_button.dart';
import 'package:appflug/ui/shared_widgets.dart/custom_horizontal_devider.dart';
import 'package:appflug/ui/shared_widgets.dart/hero_header.dart';
import 'package:appflug/ui/views/document/widgets/file_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DocumentView extends StatefulWidget {
  final Document document;

  const DocumentView({
    Key? key,
    required this.document,
  }) : super(key: key);
  @override
  _DocumentViewState createState() => _DocumentViewState();
}

class _DocumentViewState extends State<DocumentView> {
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
          padding: LayoutService.defaultViewPadding,
          child: Column(
            children: [
              CustomBackButton(),
              SizedBox(
                height: 10,
              ),
              HeroHeader(
                title: DocumentService.getDocumentTitleFromType(
                  widget.document.type,
                ),
              ),
              Expanded(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 400,
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
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
                      if (widget.document.rejectionText != null) ...[
                        SizedBox(
                          height: 20,
                        ),
                        SvgPicture.asset(
                          'assets/icons/warning.svg',
                          color: AppColors.red,
                          height: 30,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Ablehnungsgrund:',
                          style: AppTextStyles.montserratH5SemiBold,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.document.rejectionText!,
                          style: AppTextStyles.montserratH5Regular,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomHorizontalDevider(),
                      ],
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
                              _getHint(),
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
                        title: initDocumentForFilePicker.downloadUrl == null ||
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
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getHint() {
    switch (widget.document.type) {
      case DocumentType.languageTest:
        return 'Mindestniveau für Englisch und Französisch: B2, für alle anderen Sprachen: B1(bzgl. Ausnahmen bitte Angaben im Bewerberkreis beachten)! \n\nDas Zeugnis über Kenntnisse in der Unterrichtssprache ist sowohl für Ihren Erstwunsch, als auch für alle Universitäten auf der Präferenzliste bereits zum Zeitpunkt der Bewerbung erforderlich. Falls Sie also auf der Präferenzliste Hochschulen mit verschiedenen Sprachen mischen, müssen Sie entsprechend auch Zeugnisse für die entsprechenden Sprachen mit abgegeben. \n\nEin späteres Nachreichen ist nicht möglich! \n\nDas Sprachzeugnis entfällt für Universitäten, an denen die Unterrichtssprache Deutsch ist.\n';
      case DocumentType.letterOfMotivation:
        return 'Warum wollen Sie sich speziell an dieser Gasthochschule bewerben? Welche studienspezifischen Gründe haben Sie bewogen, sprich, welche Fächer/Kurse möchten Sie dort gerne belegen und warum? Passt das dortige Lehrangebot zu Ihrem Studiengang in Bamberg? Haben Sie sich bereits nach einer möglichen Anrechnung von Studienleistungen erkundigt und wie wichtig ist Ihnen diese? Eher nachranging, aber ggf. auch von Interesse: Was versprechen Sie sich im Allgemeinen von Ihrem Auslandsaufenthalt? Warum wollen Sie speziell in dieses Land?\n';
      case DocumentType.transcriptOfRecords:
        return 'Listen Sie alle von Ihnen an der Universität Bamberg besuchten Studienveranstaltungen inkl. des laufenden Semesters auf, unabhängig davon, ob Sie eine Note erhalten haben oder nicht. Sollten Ihre Noten vollständig im FlexNow-System aufgelistet sein, müssen Sie keine Scheine als Nachweis über Ihre Noten mitbringen. Wir werden die Notenangaben in Ihrer Auflistung direkt anhand des Flex-Nows überprüfen. Studierende, die Scheine für Studienleistungen erhalten haben, die nicht im FlexNow ersichtlich sind, legen diese bei der Abgabe der Bewerbung bitte zusätzlich im Original zur Beglaubigung vor.\nDie Vollständigkeit der Liste ist wichtig für Ihre spätere Einstufung an der Gasthochschule. Da diese Liste ggf. in den kommenden Monaten wieder aktualisiert werden muss (weil weitere Noten hinzugekommen sind) ist es wichtig, dass Sie diese Liste für zukünftige Zwecke an einem sicheren Ort abspeichern.\n';
      case DocumentType.preferenceList:
        return '';
      case DocumentType.passport:
        return 'Für ein Studium innerhalb der EU, Norwegen und der Schweiz benötigen Sie als EU-Bürger lediglich eine Kopie Ihres Personalausweises. Für ein Studium in einem anderen Zielland benötigen Sie eine Kopie Ihres Reisepasses, der mindestens noch 2 Jahre gültig sein muss.\n';
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
          ? '${DocumentService.getDocumentTitleFromType(widget.document.type)} erfolgreich hochgeladen'
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
