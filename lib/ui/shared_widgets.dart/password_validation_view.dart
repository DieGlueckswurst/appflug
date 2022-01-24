import 'package:appflug/ui/views/sign_up/utils/regex_for_password.dart';
import 'package:appflug/ui/views/sign_up/widgets/password_validator.dart';
import 'package:flutter/material.dart';

class PasswordValidationView extends StatelessWidget {
  final String password;

  const PasswordValidationView({
    Key? key,
    required this.password,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: 10,
          ),
          child: PasswordValidator(
            password: password,
            regExp: PasswordRegex.atLeastOneUpperAndOneLowerCaseLetter,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 10,
          ),
          child: PasswordValidator(
            password: password,
            regExp: PasswordRegex.atLeastOneDigit,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 10,
          ),
          child: PasswordValidator(
            password: password,
            regExp: PasswordRegex.atLeast8Characters,
          ),
        ),
      ],
    );
  }
}
