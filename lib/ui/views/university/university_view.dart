import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/data/classes/student.dart';
import 'package:appflug/data/classes/university.dart';
import 'package:appflug/shared_utils/student_service.dart';
import 'package:appflug/shared_utils/layout_service.dart';
import 'package:appflug/shared_utils/university_service.dart';
import 'package:appflug/ui/shared_widgets.dart/custom_horizontal_devider.dart';
import 'package:appflug/ui/shared_widgets.dart/hero_header.dart';
import 'package:appflug/ui/shared_widgets.dart/lottie_animations/loading_plane.dart';
import 'package:appflug/ui/views/university/widgets/course_filter_switch.dart';
import 'package:appflug/ui/views/university/widgets/university_card.dart';
import 'package:flutter/material.dart';

class UniversityView extends StatefulWidget {
  @override
  _UniversityViewState createState() => _UniversityViewState();
}

class _UniversityViewState extends State<UniversityView> {
  bool _onlyShowCompatibleUniversities = true;

  @override
  Widget build(BuildContext context) {
    Student? _student = StudentService.getStudent(
      context,
      listen: true,
    );
    List<University>? _universities = UniversityService.getUniversities(
      context: context,
      listen: true,
    );
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: LayoutService.getSidePaddingDependingOnDeviceSize(
            context,
          ),
          child: Column(
            children: [
              HeroHeader(
                title: 'Universitäten',
                isEnabled: false,
              ),
              SizedBox(
                height: 20,
              ),
              _student != null && _universities != null
                  ? Expanded(
                      child: Column(
                        crossAxisAlignment: LayoutService.isDesktop(context)
                            ? CrossAxisAlignment.start
                            : CrossAxisAlignment.center,
                        children: [
                          ..._buildyBody(
                            student: _student,
                            universities: _universities,
                          ),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        SizedBox(
                          height: 100,
                        ),
                        LoadingPlane(),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildyBody({
    required Student student,
    required List<University> universities,
  }) {
    return [
      CourseFilterSwitch(
        onChanged: (onlyShowCompatibleUniversities) {
          setState(() {
            _onlyShowCompatibleUniversities = onlyShowCompatibleUniversities;
          });
        },
        student: student,
      ),
      SizedBox(
        height: 10,
      ),
      CustomHorizontalDevider(),
      SizedBox(
        height: 20,
      ),
      Expanded(
        child: SingleChildScrollView(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            spacing: 20,
            runSpacing: 20,
            children: _buildUniversityCards(
              student: student,
              universities: universities,
            ),
          ),
        ),
      ),
    ];
  }

  List<Widget> _buildUniversityCards({
    required Student student,
    required List<University> universities,
  }) {
    List<Widget> universityCards = [];

    universities.sort(
      (a, b) => a.countryCode.compareTo(
        b.countryCode,
      ),
    );

    for (var university in universities) {
      if (university.coursesOfStudy.contains(student.course) ||
          !_onlyShowCompatibleUniversities ||
          student.course == null) {
        universityCards.add(
          UniversityCard(
            university: university,
          ),
        );
      }
    }

    if (universityCards.isEmpty) {
      universityCards.add(
        Padding(
          padding: EdgeInsets.only(
            top: 100,
          ),
          child: Text(
            'Für deinen Studiengang sind gerade keine Partneruniversitäten verfügbar.',
            style: AppTextStyles.montserratH6SemiBold,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    universityCards.add(
      SizedBox(),
    );

    return universityCards;
  }
}
