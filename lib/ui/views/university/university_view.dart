import 'package:appflug/constants/measurements.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:flutter/material.dart';

class UniversityView extends StatefulWidget {
  @override
  _UniversityViewState createState() => _UniversityViewState();
}

class _UniversityViewState extends State<UniversityView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: sidePadding,
          ),
          child: Text(
            'University',
            style: AppTextStyles.montserratH1Bold,
          )),
    );
  }
}
