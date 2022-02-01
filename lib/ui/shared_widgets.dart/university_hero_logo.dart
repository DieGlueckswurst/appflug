import 'package:appflug/constants/hero_key.dart';
import 'package:appflug/data/classes/university.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UniversityHeroLogo extends StatelessWidget {
  final University university;

  final double width;
  final double height;

  const UniversityHeroLogo({
    Key? key,
    required this.university,
    required this.width,
    required this.height,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: HeroKeys.getKeyFromUniversity(
        university,
      ),
      child: SvgPicture.network(
        university.logoDownloadUrl,
        placeholderBuilder: (BuildContext context) => Container(
          padding: const EdgeInsets.all(5.0),
          child: const CircularProgressIndicator.adaptive(),
        ),
        fit: BoxFit.contain,
        height: height,
        width: width,
      ),
    );
  }
}
