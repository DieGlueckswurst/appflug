import 'package:appflug/constants/measurements.dart';
import 'package:appflug/constants/other.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/data/backend/authentication.dart';
import 'package:appflug/data/student_service.dart';
import 'package:appflug/shared_utils/alert_service.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/back_button.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/rounded_corner_text_button.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/textfield_with_rounded_border.dart';
import 'package:appflug/ui/shared_widgets.dart/hero_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';

class ChangeEmailView extends StatefulWidget {
  @override
  _ChangeEmailViewState createState() => _ChangeEmailViewState();
}

class _ChangeEmailViewState extends State<ChangeEmailView> {
  String _email = '';
  bool _isLoading = false;
  late String initEmailStringWithoutEnding;

  @override
  void initState() {
    super.initState();

    _email = StudentService.getStudent(
      context,
      listen: false,
    ).email!;
    initEmailStringWithoutEnding = _email.substring(
      0,
      _email.lastIndexOf('@'),
    );
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
          child: Center(
            child: Column(
              children: [
                CustomBackButton(),
                HeroHeader(
                  title: 'Email ändern',
                ),
                SizedBox(
                  height: 30,
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 400,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: TextFieldWithRoundedBorder(
                              initValue: initEmailStringWithoutEnding,
                              onChanged: (email) {
                                setState(() {
                                  _email = email.trim() + studEmailEnding;
                                });
                              },
                              hintText: 'vorname.nachname',
                              textInputType: TextInputType.emailAddress,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            studEmailEnding,
                            style: AppTextStyles.montserratH7Regular,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      RoundedCornersTextButton(
                        title: 'Email ändern',
                        isLoading: _isLoading,
                        onTap: () async {
                          setState(() {
                            _isLoading = true;
                          });

                          GetUtils.isEmail(
                            _email,
                          )
                              ? await _changeEmail(
                                  context,
                                )
                              : AlertService.showSnackBar(
                                  title: 'Ungültige Email-Adresse',
                                  description:
                                      'Bitte gib eine gültige Email-Adresse ein.',
                                  isSuccess: false,
                                );
                        },
                      ),
                      SizedBox(
                        height: sidePadding,
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

  Future<void> _changeEmail(BuildContext context) async {
    bool wasSuccessfull = await AuthenticationService.changeEmail(
      context,
      _email,
    );

    if (wasSuccessfull) {
      AlertService.showSnackBar(
        title: 'Email erfolgreich geändert.',
        description: 'Du kannst dich mit deinem neuen Passwort jetzt anmelden.',
        isSuccess: true,
      );
    }

    setState(() {
      _isLoading = false;
    });
  }
}
