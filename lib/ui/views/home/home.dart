import 'package:appflug/shared_utils/layout_service.dart';
import 'package:appflug/ui/shared_widgets.dart/custom_horizontal_devider.dart';
import 'package:appflug/ui/views/home/widgets/application_deadline_view.dart';
import 'package:appflug/ui/views/home/widgets/application_status_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: LayoutService.getSidePaddingDependingOnDeviceSize(
          context,
        ),
        child: ListView(
          shrinkWrap: true,
          controller: ScrollController(),
          children: [
            ApplicationDeadlineView(),
            SizedBox(
              height: 20,
            ),
            CustomHorizontalDevider(),
            ApplicationStatusView(),
          ],
        ),
      ),
    );
  }
}
