import 'package:appflug/constants/measurements.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/data/backend/university.dart';
import 'package:appflug/data/classes/university.dart';
import 'package:appflug/shared_utils/layout_service.dart';
import 'package:appflug/shared_utils/string_service.dart';
import 'package:appflug/ui/shared_widgets.dart/hero_header.dart';
import 'package:appflug/ui/shared_widgets.dart/lottie_animations/loading_plane.dart';
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
                height: 30,
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
                            Text(
                              'CA'.toFlagEmoji(),
                              style: AppTextStyles.montserratH1Bold,
                            ),
                            Image.network(
                              universitiesSnapshot.data!.first.logoDownloadUrl,
                              fit: BoxFit.fill,
                              loadingBuilder: (
                                BuildContext context,
                                Widget child,
                                ImageChunkEvent? loadingProgress,
                              ) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            ),
                            Image.network(
                              universitiesSnapshot
                                  .data!.first.images.first.downloadUrl,
                              fit: BoxFit.fill,
                              loadingBuilder: (
                                BuildContext context,
                                Widget child,
                                ImageChunkEvent? loadingProgress,
                              ) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
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
