import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/measurements.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/data/backend/base.dart';
import 'package:appflug/data/backend/user.dart';
import 'package:appflug/data/classes/student.dart';
import 'package:appflug/ui/shared_widgets.dart/custom_list_tile.dart';
import 'package:appflug/ui/views/home/widgets/application_status_indicator.dart';
import 'package:flutter/material.dart';

import 'application_progress_indicator.dart';

class ApplicationStatusView extends StatefulWidget {
  @override
  _ApplicationStatusViewState createState() => _ApplicationStatusViewState();
}

class _ApplicationStatusViewState extends State<ApplicationStatusView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: BackendService().getStudentData(),
        builder: (context, AsyncSnapshot<Student> studentSnapshot) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: sidePadding,
              ),
              Text(
                'Bewerbungsstatus',
                style: AppTextStyles.montserratH3Bold.copyWith(
                  color: AppColors.blue,
                ),
              ),
              studentSnapshot.hasData
                  ? _buildBody(context: context, student: studentSnapshot.data!)
                  : CircularProgressIndicator(),
            ],
          );
        });
  }

  Widget _buildBody({
    required BuildContext context,
    required Student student,
  }) {
    return Column(
      children: [
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: ApplicationProgressIndicator(
            currentApplicationStatus: student.applicationStatus,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        ApplicationStatusIndicator(
          applicationStatusOption: student.applicationStatus,
        ),
        SizedBox(
          height: 30,
        ),
        CustomListTile(
            title:
                'Matrikelnummer angeben asdf das ist ein sehr langer text jabidabibu',
            onTap: () {}),
      ],
    );
  }
}
