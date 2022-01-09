import 'package:appflug/constants/measurements.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:flutter/material.dart';

class FaqView extends StatefulWidget {
  @override
  _FaqViewState createState() => _FaqViewState();
}

class _FaqViewState extends State<FaqView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: sidePadding,
          ),
          child: Text(
            'FAQ',
            style: AppTextStyles.montserratH1Bold,
          )),
    );
  }
}
