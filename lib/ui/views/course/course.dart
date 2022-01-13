import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/measurements.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/data/student_service.dart';
import 'package:appflug/shared_utils/alert_service.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/circle_icon_button.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/rounded_corner_text_button.dart';
import 'package:appflug/ui/views/course/utils/course_service.dart';
import 'package:appflug/ui/views/course/widgets/course_tile.dart';
import 'package:flutter/material.dart';

class CourseView extends StatefulWidget {
  final String? selectedCourse;

  const CourseView({
    Key? key,
    this.selectedCourse,
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
    if (widget.selectedCourse != null) {
      _course = widget.selectedCourse!;
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
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 400,
            ),
            child: Column(
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Studiengang',
                        style: AppTextStyles.montserratH2Bold.copyWith(
                          color: AppColors.blue,
                        ),
                        textAlign: TextAlign.center,
                      ),
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
              ],
            ),
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

    if (wasSuccessfull) {
      AlertService.showSnackBar(
        title: 'Studiengang gespeichert',
        description: '',
        isSuccess: true,
      );
      Navigator.pop(context);
    }

    setState(() {
      _isLoading = false;
    });
  }
}
