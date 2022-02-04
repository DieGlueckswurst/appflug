import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/hero_key.dart';
import 'package:appflug/constants/measurements.dart';
import 'package:appflug/data/classes/document.dart';
import 'package:appflug/data/classes/student.dart';
import 'package:appflug/shared_utils/alert_service.dart';
import 'package:appflug/shared_utils/application_service.dart';
import 'package:appflug/shared_utils/document_service.dart';
import 'package:appflug/shared_utils/layout_service.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/back_button.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/rounded_corner_text_button.dart';
import 'package:appflug/ui/shared_widgets.dart/hero_header.dart';
import 'package:appflug/ui/views/document/widgets/file_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class DocumentDetailView extends StatefulWidget {
  final Document document;
  final Student student;

  const DocumentDetailView({
    Key? key,
    required this.document,
    required this.student,
  }) : super(key: key);

  @override
  _DocumentDetailViewState createState() => _DocumentDetailViewState();
}

class _DocumentDetailViewState extends State<DocumentDetailView> {
  bool _isLoading = false;
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
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      FilePickerView(
                        initDocument: widget.document,
                        onFilePicked: (PlatformFile pickedFile) {},
                      ),
                      Spacer(),
                      RoundedCornersTextButton(
                        heroKey: HeroKeys.acceptButton,
                        title: 'Dokument annehmen',
                        backgroundColor: AppColors.green,
                        textColor: AppColors.white,
                        isLoading: _isLoading,
                        onTap: () async {
                          setState(() {
                            _isLoading = true;
                          });
                          bool wasSuccessfull =
                              await ApplicationService.acceptDocument(
                            context: context,
                            student: widget.student,
                            document: widget.document,
                          );

                          if (wasSuccessfull) {
                            AlertService.showSnackBar(
                              title: 'Dokument erfolgreich angenommen.',
                              description: 'Danke für die ausführliche Arbeit!',
                              isSuccess: true,
                            );
                            Navigator.pop(
                              context,
                            );
                          }
                          setState(() {
                            _isLoading = false;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RoundedCornersTextButton(
                        heroKey: HeroKeys.rejectButton,
                        title: 'Dokument ablehnen',
                        backgroundColor: AppColors.red,
                        textColor: AppColors.white,
                        isLoading: _isLoading,
                        onTap: () async {
                          setState(() {
                            _isLoading = true;
                          });
                          await AlertService.showRejectDocumentTextFieldAlert(
                            context,
                            onDocumentRejected: (rejectText) async {
                              bool wasSuccessfull =
                                  await ApplicationService.rejectDocument(
                                context: context,
                                student: widget.student,
                                document: widget.document,
                                rejectionText: rejectText,
                              );

                              if (wasSuccessfull) {
                                AlertService.showSnackBar(
                                  title: 'Dokument erfolgreich abgelehnt.',
                                  description:
                                      'Danke für die ausführliche Arbeit!',
                                  isSuccess: true,
                                );
                                Navigator.pop(
                                  context,
                                );
                              }
                            },
                          );

                          setState(() {
                            _isLoading = false;
                          });
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
}
