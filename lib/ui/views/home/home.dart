import 'package:appflug/constants/measurements.dart';
import 'package:appflug/ui/shared_widgets.dart/buttons/rounded_corner_text_button.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: sidePadding,
        ),
        child: RoundedCornersTextButton(
          title: 'Logout',
          onTap: () {},
        ),
      ),
    );
  }
}
