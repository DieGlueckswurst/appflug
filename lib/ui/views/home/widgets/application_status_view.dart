import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/measurements.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/data/backend/base.dart';
import 'package:appflug/data/backend/user.dart';
import 'package:appflug/data/classes/student.dart';
import 'package:flutter/material.dart';

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
    return Text(
      student.applicationStatus ?? 'Penis',
      style: AppTextStyles.montserratH1Bold,
    );
  }
}
