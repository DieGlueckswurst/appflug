import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/box_decoration.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/data/classes/university.dart';
import 'package:appflug/enums/views.dart';
import 'package:appflug/routes/views.dart';
import 'package:appflug/shared_utils/review._service.dart';
import 'package:appflug/ui/shared_widgets.dart/university_hero_logo.dart';
import 'package:appflug/ui/shared_widgets.dart/university_information.dart';
import 'package:appflug/ui/views/navigation/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'flag_emoji.dart';

class UniversityCard extends StatelessWidget {
  final University university;

  const UniversityCard({
    Key? key,
    required this.university,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            Views.universityDetail,
            arguments: university,
          );
        },
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 400,
          ),
          child: Container(
            decoration: defaultBoxDecoration,
            child: Padding(
              padding: EdgeInsets.all(
                15,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      UniversityHeroLogo(
                        university: university,
                        width: 200,
                        height: 30,
                        isHeroEnabled: NavBarService.getSelectedView(context) ==
                            NavBarView.university,
                      ),
                      Spacer(),
                      FlagEmoji(
                        countryCode: university.countryCode,
                        size: 25,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  UniversityInformation(
                    university: university,
                    showWebsite: false,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/star.svg',
                        height: 15,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        university.reviews.isNotEmpty
                            ? ReviewService.getReviewAverage(university.reviews)
                                .toString()
                            : 'keine Bewertungen',
                        style: AppTextStyles.montserratH6SemiBold,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '( ${university.reviews.length.toString()} )',
                        style: AppTextStyles.montserratH6Regular.copyWith(
                          color: AppColors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
