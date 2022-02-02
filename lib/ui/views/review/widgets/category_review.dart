import 'package:appflug/constants/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CategoryReview extends StatelessWidget {
  final String title;
  final int reviewValue;

  const CategoryReview({
    Key? key,
    required this.title,
    required this.reviewValue,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 150,
          child: Text(
            title,
            style: AppTextStyles.montserratH6SemiBold,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        ...List.generate(
          5,
          (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 3,
              ),
              child: SvgPicture.asset(
                reviewValue > index
                    ? 'assets/icons/star_filled.svg'
                    : 'assets/icons/star_empty.svg',
                height: 15,
              ),
            );
          },
        ),
      ],
    );
  }
}
