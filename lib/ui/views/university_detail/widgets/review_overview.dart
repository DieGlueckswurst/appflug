import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/data/classes/university.dart';
import 'package:appflug/shared_utils/review._service.dart';
import 'package:appflug/shared_utils/url_launch_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ReviewOverview extends StatelessWidget {
  final University university;

  const ReviewOverview({
    Key? key,
    required this.university,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _average = ReviewService.getReviewAverage(
      university.reviews,
    );
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(
              5,
              (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 3,
                  ),
                  child: SvgPicture.asset(
                    !_average.isNaN && _average.round() > index
                        ? 'assets/icons/star_filled.svg'
                        : 'assets/icons/star_empty.svg',
                    height: 15,
                  ),
                );
              },
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        RichText(
          text: TextSpan(
            style: AppTextStyles.montserratH5SemiBold.copyWith(
              color: AppColors.blue,
            ),
            children: <TextSpan>[
              TextSpan(
                text: _average.isNaN ? 'keine Bewertungen' : '$_average aus ',
              ),
              if (!_average.isNaN)
                TextSpan(
                  text: 'Bewertungen',
                  style: AppTextStyles.montserratH5SemiBold.copyWith(
                    color: AppColors.blue,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      openURL(context, url: 'https://pointerpointer.com/');
                    },
                ),
            ],
          ),
        ),
      ],
    );
  }
}
