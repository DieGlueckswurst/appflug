import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/measurements.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/routes/views.dart';
import 'package:appflug/ui/shared_widgets.dart/custom_list_tile.dart';
import 'package:flutter/material.dart';

class PreferenceListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: sidePadding,
        ),
        Text(
          'Schnellzugriff',
          style: AppTextStyles.montserratH3Bold.copyWith(
            color: AppColors.blue,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        CustomListTile(
          title: 'Präferenzliste',
          onTap: () {
            Navigator.pushNamed(
              context,
              Views.preferenceList,
            );
          },
        ),
        SizedBox(
          height: sidePadding,
        )
      ],
    );
  }
}
