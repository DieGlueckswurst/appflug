import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/data/backend/university.dart';
import 'package:appflug/data/classes/student.dart';
import 'package:appflug/data/classes/university.dart';
import 'package:appflug/data/student_service.dart';
import 'package:appflug/shared_utils/layout_service.dart';
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
              FutureBuilder(
                future: UniversityBackendService().getUniversities(),
                builder: (
                  context,
                  AsyncSnapshot<List<University>> universitiesSnapshot,
                ) {
                  return universitiesSnapshot.hasData && _student != null
                      ? Column(
                          children: [
                            ..._buildyBody(
                              student: _student,
                              universities: universitiesSnapshot.data!,
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            SizedBox(
                              height: 100,
                            ),
                            LoadingPlane(),
                          ],
                        );
                },
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
      ..._buildUniversityCards(
        student: student,
        universities: universities,
      )
    ];
  }

  List<Widget> _buildUniversityCards({
    required Student student,
    required List<University> universities,
  }) {
    List<Widget> universityCards = [];

    for (var university in universities) {
      if (university.coursesOfStudy.contains(student.course) ||
          !_onlyShowCompatibleUniversities) {
        universityCards.add(
          UniversityCard(
            university: university,
          ),
        );
      }
    }

    if (universityCards.isEmpty) {
      universityCards.add(
        SizedBox(
          height: 100,
        ),
      );

      universityCards.add(
        Text(
          'Für deinen Studiengang sind gerade keine Partneruniversitäten verfügbar.',
          style: AppTextStyles.montserratH6SemiBold,
          textAlign: TextAlign.center,
        ),
      );
    }
    return universityCards;
  }
}
