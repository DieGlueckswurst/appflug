import 'package:appflug/constants/measurements.dart';
import 'package:appflug/shared_utils/layout_service.dart';
import 'package:appflug/ui/shared_widgets.dart/hero_header.dart';
import 'package:flutter/material.dart';

class HomeViewForEmpl extends StatefulWidget {
  @override
  _HomeViewForEmplState createState() => _HomeViewForEmplState();
}

class _HomeViewForEmplState extends State<HomeViewForEmpl> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: LayoutService.getSidePaddingDependingOnDeviceSize(
              context,
            ),
            child: Column(
              children: [
                HeroHeader(
                  isEnabled: true,
                  title: 'Offene Anträge',
                ),
                SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: ConstrainedBox(
                    constraints: webMaxWidthConstraint * 2,
                    child: ListView(
                      // crucial to provide a default scrollcontroller else ->
                      // Exeption: "The provided ScrollController is currently attached to more than one ScrollPosition.",
                      // if Home View is scrollable as well
                      controller: ScrollController(),
                      shrinkWrap: true,
                      children: [],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
