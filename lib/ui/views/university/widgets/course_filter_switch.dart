import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/data/classes/student.dart';
import 'package:appflug/data/local_storage/local_storage_keys.dart';
import 'package:appflug/data/local_storage/local_storage_service.dart';
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

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: RichText(
            text: TextSpan(
              style: defaultStyle,
              children: <TextSpan>[
                TextSpan(
                  text: widget.student.course == null
                      ? 'Du hast noch keinen '
                      : 'Nur für ',
                ),
                TextSpan(
                  text: widget.student.course == null
                      ? 'Studiengang'
                      : 'meinen Studiengang',
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
                  text: widget.student.course == null
                      ? ' angegeben. Es werden alle Partneruniversitäten angezeigt.'
                      : ' zulässige Universitäten anzeigen.',
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        if (widget.student.course != null)
          FutureBuilder(
            future: LocalStorageService.getData(
              key: LocalStorageKeys.onlyShowCompatibleUniversities,
            ),
            builder: (context, AsyncSnapshot<dynamic> snapshot) {
              return Stack(
                children: [
                  Switch.adaptive(
                    value: snapshot.data ?? true,
                    activeColor: AppColors.green,
                    onChanged: (isEnabled) async {
                      widget.onChanged(
                        isEnabled,
                      );
                      await LocalStorageService.setBool(
                        key: LocalStorageKeys.onlyShowCompatibleUniversities,
                        value: isEnabled,
                      );
                    },
                  ),
                  AnimatedSwitcher(
                    duration: kThemeAnimationDuration,
                    child: snapshot.connectionState == ConnectionState.done
                        ? SizedBox.shrink()
                        : Container(
                            color: AppColors.white.withOpacity(1),
                          ),
                  )
                ],
              );
            },
          ),
      ],
    );
  }
}
