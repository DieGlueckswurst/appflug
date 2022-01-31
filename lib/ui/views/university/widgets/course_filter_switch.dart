import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/data/classes/student.dart';
import 'package:appflug/routes/views.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CourseFilterSwitch extends StatefulWidget {
  final Student student;
  final Function(bool) onChanged;

  const CourseFilterSwitch({
    Key? key,
    required this.onChanged,
    required this.student,
  }) : super(key: key);
  @override
  _CourseFilterSwitchState createState() => _CourseFilterSwitchState();
}

class _CourseFilterSwitchState extends State<CourseFilterSwitch> {
  TextStyle defaultStyle = AppTextStyles.montserratH6Regular;
  TextStyle linkStyle = AppTextStyles.montserratH6SemiBold.copyWith(
    decoration: TextDecoration.underline,
  );

  bool _isEnabled = true;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: widget.student.course == null
          ? [
              Text(
                'Du hast noch keinen Studiengang angegeben. Es werden alle Partneruniversitäten angezeigt.',
                style: defaultStyle,
              )
            ]
          : [
              Flexible(
                child: RichText(
                  text: TextSpan(
                    style: defaultStyle,
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Nur für ',
                      ),
                      TextSpan(
                        text: 'meinen Studiengang',
                        style: linkStyle,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(
                              context,
                              Views.course,
                              arguments: widget.student.course,
                            );
                          },
                      ),
                      TextSpan(
                        text: ' zulässige Universitäten anzeigen.',
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Switch.adaptive(
                value: _isEnabled,
                activeColor: AppColors.green,
                onChanged: (isEnabled) {
                  setState(() {
                    _isEnabled = isEnabled;
                  });
                  widget.onChanged(
                    isEnabled,
                  );
                },
              )
            ],
    );
  }
}
