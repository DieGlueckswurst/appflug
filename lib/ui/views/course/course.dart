import 'package:appflug/constants/measurements.dart';
import 'package:appflug/data/student_service.dart';
import 'package:appflug/shared_utils/alert_service.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/back_button.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/rounded_corner_text_button.dart';
import 'package:appflug/ui/shared_widgets.dart/hero_header.dart';
import 'package:appflug/ui/views/course/utils/course_service.dart';
import 'package:appflug/ui/views/course/widgets/course_tile.dart';
import 'package:flutter/material.dart';

class CourseView extends StatefulWidget {
  final String? initCourse;

  const CourseView({
    Key? key,
    this.initCourse,
  }) : super(key: key);

  @override
  _CourseViewState createState() => _CourseViewState();
}

class _CourseViewState extends State<CourseView> {
  String _course = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.initCourse != null) {
      _course = widget.initCourse!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10,
            left: sidePadding,
            right: sidePadding,
          ),
          child: Column(
            children: [
              CustomBackButton(),
              SizedBox(
                height: 10,
              ),
              HeroHeader(
                title: 'Studiengang',
                isEnabled: widget.initCourse != null,
              ),
              Expanded(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 400,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      ListView(
                        shrinkWrap: true,
                        children: [
                          ...List<Widget>.generate(
                            CourseService.courses.length,
                            (index) => Padding(
                              padding: EdgeInsets.only(
                                bottom: 10,
                              ),
                              child: CourseTile(
                                course:
                                    CourseService.courses.keys.toList()[index],
                                isSelected: CourseService.courses.values
                                        .toList()[index] ==
                                    _course,
                                onCourseChange: (course) {
                                  setState(() {
                                    _course = CourseService.courses[course]!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Spacer(),
                            RoundedCornersTextButton(
                              title: 'Speichern',
                              isLoading: _isLoading,
                              onTap: () async {
                                setState(() {
                                  _isLoading = true;
                                });
                                _course.isNotEmpty
                                    ? await _saveCourse(context)
                                    : AlertService.showSnackBar(
                                        title: 'Ungültiger Studiengang',
                                        description:
                                            'Bitte wähle einen Studiengang.',
                                        isSuccess: false,
                                      );

                                setState(() {
                                  _isLoading = false;
                                });
                              },
                            ),
                            SizedBox(
                              height: sidePadding,
                            )
                          ],
                        ),
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

  Future<void> _saveCourse(BuildContext context) async {
    bool wasSuccessfull = await StudentService.setCourse(
      context: context,
      course: _course,
    );

    AlertService.showSnackBar(
      title: wasSuccessfull
          ? 'Studiengang erfolgreich gespeichert'
          : 'Ups, hier ist etwas schiefgelaufen',
      description: wasSuccessfull
          ? 'Du kannst deinen Studiengang in deinem Profil nachträglich noch ändern.'
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
}
