import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/measurements.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/data/classes/application.dart';
import 'package:appflug/routes/view_for_empl.dart';
import 'package:appflug/shared_utils/application_service.dart';
import 'package:appflug/shared_utils/layout_service.dart';
import 'package:appflug/shared_utils/string_service.dart';
import 'package:appflug/ui/shared_widgets.dart/custom_list_tile.dart';
import 'package:appflug/ui/shared_widgets.dart/hero_header.dart';
import 'package:appflug/ui/shared_widgets.dart/lottie_animations/loading_plane.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeViewForEmpl extends StatefulWidget {
  @override
  _HomeViewForEmplState createState() => _HomeViewForEmplState();
}

class _HomeViewForEmplState extends State<HomeViewForEmpl> {
  @override
  Widget build(BuildContext context) {
    List<Application>? _applications = ApplicationService.getApplications(
      context: context,
      listen: true,
    );
    if (_applications != null) {
      _applications.sort(
        (appA, appB) => appA.dateTimeInMilliSecondsSinceEpoch.compareTo(
          appB.dateTimeInMilliSecondsSinceEpoch,
        ),
      );
    }
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: LayoutService.getSidePaddingDependingOnDeviceSize(
              context,
            ),
            child: Column(
              children: [
                Flexible(
                  child: Row(
                    children: [
                      Flexible(
                        child: HeroHeader(
                          title: 'Offene Anträge',
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      AnimatedSwitcher(
                        duration: kThemeAnimationDuration,
                        child: _applications != null
                            ? Text(
                                '( ' + _applications.length.toString() + ' )',
                                style:
                                    AppTextStyles.montserratH4SemiBold.copyWith(
                                  color: AppColors.blue,
                                ),
                              )
                            : SizedBox(
                                child: CircularProgressIndicator.adaptive(
                                  strokeWidth: 2,
                                ),
                              ),
                      ),
                      SizedBox(
                        width: sidePadding,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                _applications != null
                    ? Expanded(
                        child: ConstrainedBox(
                          constraints: webMaxWidthConstraint * 2,
                          child: ListView(
                            controller: ScrollController(),
                            shrinkWrap: true,
                            children: [
                              if (_applications.isEmpty) ...[
                                SizedBox(
                                  height: 50,
                                ),
                                Text(
                                  'Derzeit gibt es keine offenen Bewerbungen. \nDu hast dir eine Pause verdient!',
                                  style: AppTextStyles.montserratH5SemiBold,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                              ..._applications
                                  .map(
                                    (application) => Padding(
                                      padding: EdgeInsets.only(
                                        bottom: 20,
                                      ),
                                      child: CustomListTile(
                                        title: StringService.getNameFromEmail(
                                          application.student.email!,
                                        ),
                                        description: 'Beworben am: ' +
                                            DateFormat('dd.MM.yyy').format(
                                              DateTime
                                                  .fromMillisecondsSinceEpoch(
                                                application
                                                    .dateTimeInMilliSecondsSinceEpoch,
                                              ),
                                            ),
                                        onTap: () {
                                          Navigator.pushNamed(
                                            context,
                                            ViewsForEmpl.applicationOverview,
                                            arguments: application,
                                          );
                                        },
                                      ),
                                    ),
                                  )
                                  .toList()
                            ],
                          ),
                        ),
                      )
                    : Column(
                        children: [
                          SizedBox(
                            height: 150,
                          ),
                          LoadingPlane(),
                        ],
                      ),
              ],
            )),
      ),
    );
  }
}
