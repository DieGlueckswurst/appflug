import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/hero_key.dart';
import 'package:appflug/constants/measurements.dart';
import 'package:appflug/constants/other.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/data/backend/authentication.dart';
import 'package:appflug/enums/status_option.dart';
import 'package:appflug/routes/views.dart';
import 'package:appflug/shared_utils/alert_service.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/back_button.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/rounded_corner_text_button.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/textfield_with_rounded_border.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';

class EmailView extends StatefulWidget {
  @override
  State<EmailView> createState() => _EmailViewState();
}

class _EmailViewState extends State<EmailView> {
  String _email = '';
  bool _isLoading = false;
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
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 400,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email',
                        style: AppTextStyles.montserratH2Bold.copyWith(
                          color: AppColors.blue,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: TextFieldWithRoundedBorder(
                              onChanged: (email) {
                                setState(() {
                                  _email = email.trim() + studEmailEnding;
                                });
                              },
                              hintText: 'vorname.nachname',
                              focusOnInit: true,
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
                        height: 20,
                      ),
                      RoundedCornersTextButton(
                        title: 'Weiter',
                        isLoading: _isLoading,
                        heroKey: HeroKeys.buttonKeyAsStud,
                        onTap: () async {
                          setState(() {
                            _isLoading = true;
                          });
                          GetUtils.isEmail(
                            _email,
                          )
                              ? Navigator.pushNamed(
                                  context,
                                  await AuthenticationService
                                          .checkIfEmailIsAlreadyInUse(
                                    email: _email,
                                  )
                                      ? Views.login
                                      : Views.signUp,
                                  arguments: <Object>[
                                    _email,
                                    StatusOption.stud,
                                  ],
                                )
                              : AlertService.showSnackBar(
                                  title: 'Ungültige Email-Adresse',
                                  description:
                                      'Bitte gib eine gültige Email-Adresse ein.',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
