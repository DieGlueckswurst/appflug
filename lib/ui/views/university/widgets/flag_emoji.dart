import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/shared_utils/string_service.dart';
import 'package:flutter/material.dart';

class FlagEmoji extends StatelessWidget {
  final String countryCode;
  final double size;

  const FlagEmoji({
    Key? key,
    required this.countryCode,
    required this.size,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      countryCode.toFlagEmoji(),
      style: AppTextStyles.montserratH1Bold.copyWith(
        fontSize: size,
      ),
    );
  }
}
