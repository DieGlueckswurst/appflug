import 'package:appflug/constants/measurements.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: sidePadding,
          ),
          child: Text(
            'Profil',
            style: AppTextStyles.montserratH1Bold,
          )),
    );
  }
}
