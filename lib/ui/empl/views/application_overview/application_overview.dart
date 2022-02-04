import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/hero_key.dart';
import 'package:appflug/constants/measurements.dart';
import 'package:appflug/data/classes/application.dart';
import 'package:appflug/data/classes/document.dart';
import 'package:appflug/data/classes/student.dart';
import 'package:appflug/enums/document_type.dart';
import 'package:appflug/routes/view_for_empl.dart';
import 'package:appflug/shared_utils/alert_service.dart';
import 'package:appflug/shared_utils/application_service.dart';
import 'package:appflug/shared_utils/document_service.dart';
import 'package:appflug/shared_utils/layout_service.dart';
import 'package:appflug/shared_utils/string_service.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/back_button.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/rounded_corner_text_button.dart';
import 'package:appflug/ui/shared_widgets.dart/custom_list_tile.dart';
import 'package:appflug/ui/shared_widgets.dart/hero_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class ApplicationOverviewView extends StatefulWidget {
  final Application application;

  const ApplicationOverviewView({
    Key? key,
    required this.application,
  }) : super(key: key);

  @override
  _ApplicationOverviewViewState createState() =>
      _ApplicationOverviewViewState();
}

class _ApplicationOverviewViewState extends State<ApplicationOverviewView> {
  bool _isLoading = false;
  late Application? _application;
  @override
  Widget build(BuildContext context) {
    var applications = ApplicationService.getApplications(
      context: context,
      listen: true,
    );
    if (applications != null) {
      _application = applications.firstWhereOrNull(
        (application) =>
            application.student.uid == widget.application.student.uid,
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: LayoutService.defaultViewPadding,
          child: _application == null
              ? Container()
              : Column(
                  children: [
                    CustomBackButton(),
                    SizedBox(
                      height: 10,
                    ),
                    HeroHeader(
                      title: StringService.getNameFromEmail(
                        _application!.student.email!,
                      ),
                    ),
                    _buildBody(
                      context: context,
                      application: _application!,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ConstrainedBox(
                      constraints: webMaxWidthConstraint,
                      child: RoundedCornersTextButton(
                        heroKey: HeroKeys.acceptButton,
                        isEnabled: ApplicationService
                                .isApplicationCompletelyReviewd(
                              context: context,
                              student: _application!.student,
                            ) &&
                            ApplicationService.isApplicationReadyForAcception(
                              context: context,
                              student: _application!.student,
                            ),
                        title: 'Bewerbung annehmen',
                        backgroundColor: AppColors.green,
                        textColor: AppColors.white,
                        isLoading: _isLoading,
                        onTap: () async {
                          setState(() {
                            _isLoading = true;
                          });
                          bool wasSuccessfull =
                              await ApplicationService.acceptApplication(
                            context: context,
                            student: _application!.student,
                          );
                          if (wasSuccessfull) {
                            AlertService.showSnackBar(
                              title: 'Bewerbung erfolgreich angenommen.',
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
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ConstrainedBox(
                      constraints: webMaxWidthConstraint,
                      child: RoundedCornersTextButton(
                        heroKey: HeroKeys.rejectButton,
                        isEnabled: ApplicationService
                                .isApplicationCompletelyReviewd(
                              context: context,
                              student: _application!.student,
                            ) &&
                            ApplicationService.isApplicationReadyForRejection(
                              context: context,
                              student: _application!.student,
                            ),
                        title: 'Bewerbung ablehnen',
                        backgroundColor: AppColors.red,
                        textColor: AppColors.white,
                        isLoading: _isLoading,
                        onTap: () async {
                          setState(() {
                            _isLoading = true;
                          });
                          bool wasSuccessfull =
                              await ApplicationService.rejectApplication(
                            context: context,
                            student: _application!.student,
                          );
                          if (wasSuccessfull) {
                            AlertService.showSnackBar(
                              title: 'Bewerbung erfolgreich abgelehnt.',
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
                    ),
                    SizedBox(
                      height: sidePadding,
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildBody(
      {required BuildContext context, required Application application}) {
    List<Document> documents = application.student.documents.values.toList();

    return Expanded(
      child: ConstrainedBox(
        constraints: webMaxWidthConstraint,
        child: ListView(
          children: [
            SizedBox(
              height: 30,
            ),
            ..._buildDocumentTiles(
              documents: documents,
              student: application.student,
            ),
            SizedBox(
              height: sidePadding,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildDocumentTiles({
    required List<Document> documents,
    required Student student,
  }) {
    return DocumentService.sortDocumentsAlphabetically(
      documents,
    ).map((document) {
      if (document.type != DocumentType.preferenceList) {
        return Padding(
          padding: const EdgeInsets.only(
            bottom: 20,
          ),
          child: CustomListTile(
            backgroundColor: (document.isValid) ?? false
                ? AppColors.green
                : document.rejectionText != null
                    ? AppColors.red
                    : AppColors.white,
            title: DocumentService.getDocumentTitleFromType(
              document.type,
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                ViewsForEmpl.documentDetail,
                arguments: <Object>[
                  document,
                  student,
                ],
              );
            },
          ),
        );
      } else {
        return SizedBox.shrink();
      }
    }).toList();
  }
}
