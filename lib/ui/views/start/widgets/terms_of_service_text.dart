import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/shared_utils/url_launch_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TermsOfServiceText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle defaultStyle = AppTextStyles.montserratH7SemiBold;
    TextStyle linkStyle = AppTextStyles.montserratH7SemiBold.copyWith(
      decoration: TextDecoration.underline,
    );
    return RichText(
      text: TextSpan(
        style: defaultStyle,
        children: <TextSpan>[
          TextSpan(
            text: 'Ich willige den ',
          ),
          TextSpan(
            text: 'Datenschutzrichtlinien',
            style: linkStyle,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                openURL(context, url: 'https://pointerpointer.com/');
              },
          ),
          TextSpan(
            text: ' und ',
          ),
          TextSpan(
            text: 'Privatsphäreeinstellungen',
            style: linkStyle,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                openURL(context, url: 'https://google.com/');
              },
          ),
          TextSpan(
            text: ' der App ein.',
          ),
        ],
      ),
    );
  }
}
