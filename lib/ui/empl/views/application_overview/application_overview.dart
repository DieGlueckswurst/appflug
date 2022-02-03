import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/measurements.dart';
import 'package:appflug/data/classes/application.dart';
import 'package:appflug/data/classes/document.dart';
import 'package:appflug/enums/document_type.dart';
import 'package:appflug/shared_utils/document_service.dart';
import 'package:appflug/shared_utils/layout_service.dart';
import 'package:appflug/shared_utils/string_service.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/back_button.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/rounded_corner_text_button.dart';
import 'package:appflug/ui/shared_widgets.dart/custom_list_tile.dart';
import 'package:appflug/ui/shared_widgets.dart/hero_header.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                title: StringService.getNameFromEmail(
                  widget.application.student.email!,
                ),
              ),
              _buildBody(
                context: context,
              ),
              SizedBox(
                height: 20,
              ),
              RoundedCornersTextButton(
                title: 'Bewerbung annehmen',
                backgroundColor: AppColors.green,
                textColor: AppColors.white,
                onTap: () {},
              ),
              SizedBox(
                height: 20,
              ),
              RoundedCornersTextButton(
                title: 'Bewerbung ablehnen',
                backgroundColor: AppColors.red,
                textColor: AppColors.white,
                onTap: () {},
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

  Widget _buildBody({
    required BuildContext context,
  }) {
    List<Document> documents =
        widget.application.student.documents.values.toList();

    return Expanded(
      child: ConstrainedBox(
        constraints: webMaxWidthConstraint,
        child: ListView(
          shrinkWrap: true,
          children: [
            SizedBox(
              height: 30,
            ),
            ..._buildDocumentTiles(
              documents,
            ),
            SizedBox(
              height: sidePadding,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildDocumentTiles(List<Document> documents) {
    return DocumentService.sortDocumentsAlphabetically(
      documents,
    ).map((document) {
      if (document.type != DocumentType.preferenceList) {
        return Padding(
          padding: const EdgeInsets.only(
            bottom: 20,
          ),
          child: CustomListTile(
            title: DocumentService.getDocumentTitleFromType(
              document.type,
            ),
            onTap: () {},
          ),
        );
      } else {
        return SizedBox.shrink();
      }
    }).toList();
  }
}
