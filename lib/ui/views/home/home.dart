import 'package:appflug/data/classes/student.dart';
import 'package:appflug/shared_utils/student_service.dart';
import 'package:appflug/shared_utils/layout_service.dart';
import 'package:appflug/ui/shared_widgets.dart/custom_horizontal_devider.dart';
import 'package:appflug/ui/shared_widgets.dart/lottie_animations/loading_plane.dart';
import 'package:appflug/ui/views/home/widgets/application_deadline_view.dart';
import 'package:appflug/ui/views/home/widgets/application_status_view.dart';
import 'package:appflug/ui/views/home/widgets/preference_list_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    Student? _student = StudentService.getStudent(
      context,
      listen: true,
    );
    return SafeArea(
      child: Padding(
        padding: LayoutService.getSidePaddingDependingOnDeviceSize(
          context,
        ),
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 400),
          child: _student != null
              ? ListView(
                  shrinkWrap: true,
                  controller: ScrollController(),
                  children: [
                    ApplicationDeadlineView(),
                    SizedBox(
                      height: 20,
                    ),
                    CustomHorizontalDevider(),
                    ApplicationStatusView(
                      student: _student,
                    ),
                    CustomHorizontalDevider(),
                    PreferenceListView(),
                  ],
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LoadingPlane(),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
