import 'package:appflug/ui/views/start/widgets/check_box.dart';
import 'package:appflug/ui/views/start/widgets/terms_of_service_text.dart';
import 'package:flutter/material.dart';

class TermsOfServiceView extends StatelessWidget {
  final Function(bool) onIsCheckedChanged;

  const TermsOfServiceView({required this.onIsCheckedChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CheckBox(
          onCheckedChanged: onIsCheckedChanged,
        ),
        Flexible(
          child: TermsOfServiceText(),
        ),
      ],
    );
  }
}
