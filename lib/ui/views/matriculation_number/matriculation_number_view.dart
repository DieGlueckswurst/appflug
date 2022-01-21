import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/measurements.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/data/student_service.dart';
import 'package:appflug/shared_utils/alert_service.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/circle_icon_button.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/rounded_corner_text_button.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/textfield_with_rounded_border.dart';
import 'package:appflug/ui/views/matriculation_number/utils/matriculation_number_service.dart';
import 'package:flutter/material.dart';

class MatriculationNumberView extends StatefulWidget {
  final String? initMatriculationNumber;

  const MatriculationNumberView({
    Key? key,
    required this.initMatriculationNumber,
  }) : super(key: key);

  @override
  _MatriculationNumberViewState createState() =>
      _MatriculationNumberViewState();
}

class _MatriculationNumberViewState extends State<MatriculationNumberView> {
  String _matriculationNumberString = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.initMatriculationNumber != null) {
      _matriculationNumberString = widget.initMatriculationNumber!;
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
              Row(
                children: [
                  Text(
                    'Matrikelnummer',
                    style: AppTextStyles.montserratH2Bold.copyWith(
                      color: AppColors.blue,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
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
                      TextFieldWithRoundedBorder(
                        initValue: widget.initMatriculationNumber,
                        onChanged: (matriculationNumberString) {
                          setState(() {
                            _matriculationNumberString =
                                matriculationNumberString;
                          });
                        },
                        hintText: 'Matrikelnummer eingeben',
                        focusOnInit: widget.initMatriculationNumber == null,
                        textInputType: TextInputType.number,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RoundedCornersTextButton(
                        title: 'Speichern',
                        isLoading: _isLoading,
                        onTap: () async {
                          setState(() {
                            _isLoading = true;
                          });
                          MatriculationNumberService.isMatriculationNumber(
                            _matriculationNumberString,
                          )
                              ? _saveMatriculationNumber(context)
                              : AlertService.showSnackBar(
                                  title: 'Ungültige Matrikelnummer',
                                  description:
                                      'Bitte gib eine gültige Matrikelnummer ein.',
                                  isSuccess: false,
                                );

                          setState(() {
                            _isLoading = false;
                          });
                        },
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

  Future<void> _saveMatriculationNumber(BuildContext context) async {
    bool wasSuccessfull = await StudentService.setMatriculationNumber(
      context: context,
      matriculationNumber: int.parse(
        _matriculationNumberString,
      ),
    );

    AlertService.showSnackBar(
      title: wasSuccessfull
          ? 'Matrikelnummer erfolgreich gespeichert'
          : 'Ups, hier ist etwas schiefgelaufen',
      description: wasSuccessfull
          ? 'Du kannst deine Matrikelnummer in deinem Profil nachträglich noch ändern.'
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
