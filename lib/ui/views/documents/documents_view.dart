import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/measurements.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/data/classes/student.dart';
import 'package:appflug/data/provider/student_provider.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/circle_icon_button.dart';
import 'package:appflug/ui/views/home/widgets/documents_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DocumentsView extends StatefulWidget {
  @override
  _DocumentsViewState createState() => _DocumentsViewState();
}

class _DocumentsViewState extends State<DocumentsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            left: sidePadding,
            right: sidePadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              SizedBox(
                height: 10,
              ),
              Hero(
                tag: 'text',
                child: Material(
                  color: AppColors.white,
                  child: Text(
                    'Meine Dokumente',
                    style: AppTextStyles.montserratH2Bold.copyWith(
                      color: AppColors.blue,
                    ),
                  ),
                ),
              ),
              _buildBody(
                context: context,
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
    Student _student = Provider.of<StudentProvider>(context).currentStudent!;
    return Column(
      children: [
        SizedBox(
          height: 30,
        ),
        DocumentsListView(
          student: _student,
          isInSettings: true,
        ),
        SizedBox(
          height: sidePadding,
        ),
      ],
    );
  }
}
