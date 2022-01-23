import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/measurements.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/data/classes/student.dart';
import 'package:appflug/data/provider/student_provider.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/circle_icon_button.dart';
import 'package:appflug/ui/views/home/widgets/personal_data_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonalDataView extends StatefulWidget {
  @override
  _PersonalDataViewState createState() => _PersonalDataViewState();
}

class _PersonalDataViewState extends State<PersonalDataView> {
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
              Text(
                'Persönliche Daten',
                style: AppTextStyles.montserratH2Bold.copyWith(
                  color: AppColors.blue,
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
        PersonalDataListView(
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
