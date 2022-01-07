import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/ui/views/sign_up/utils/regex_map_with_descriptions_for_password.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PasswordValidator extends StatefulWidget {
  final String password;
  final RegExp regExp;

  const PasswordValidator({
    Key? key,
    required this.password,
    required this.regExp,
  });
  @override
  _PasswordValidatorState createState() => _PasswordValidatorState();
}

class _PasswordValidatorState extends State<PasswordValidator> {
  @override
  Widget build(BuildContext context) {
    final bool _isvalid = widget.regExp.hasMatch(widget.password);
    return Row(
      children: [
        SizedBox(
          height: 15,
          width: 15,
          child: Center(
            child: SvgPicture.asset(
              _isvalid
                  ? 'assets/icons/correct.svg'
                  : 'assets/icons/multiply.svg',
              color: _isvalid ? AppColors.green : AppColors.red,
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        AutoSizeText(
          regexMapWithDescriptionsForPassword[widget.regExp]!,
          style: AppTextStyles.montserratH7Regular,
          maxLines: 1,
        ),
      ],
    );
  }
}
