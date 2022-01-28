import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/data/backend/university.dart';
import 'package:appflug/data/classes/university.dart';
import 'package:appflug/shared_utils/layout_service.dart';
import 'package:appflug/ui/shared_widgets.dart/custom_horizontal_devider.dart';
import 'package:appflug/ui/shared_widgets.dart/hero_header.dart';
import 'package:appflug/ui/shared_widgets.dart/lottie_animations/loading_plane.dart';
import 'package:appflug/ui/views/university/widgets/university_card.dart';
import 'package:flutter/material.dart';

class UniversityView extends StatefulWidget {
  @override
  _UniversityViewState createState() => _UniversityViewState();
}

class _UniversityViewState extends State<UniversityView> {
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
                title: 'Universitäten',
                isEnabled: false,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Flexible(
                    child: Text(
                      'Nur für meinen Studiengang zulässige Universitäten anzeigen',
                      style: AppTextStyles.montserratH6Regular,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Switch.adaptive(
                      value: true,
                      activeColor: AppColors.green,
                      onChanged: (enabled) {}),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              CustomHorizontalDevider(),
              SizedBox(
                height: 20,
              ),
              FutureBuilder(
                future: UniversityBackendService().getUniversities(),
                builder: (
                  context,
                  AsyncSnapshot<List<University>> universitiesSnapshot,
                ) {
                  return universitiesSnapshot.hasData
                      ? Column(
                          children: [
                            ...List.generate(
                              universitiesSnapshot.data!.length,
                              (index) => UniversityCard(
                                university: universitiesSnapshot.data![index],
                              ),
                            ),
                          ],
                        )
                      : LoadingPlane();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
