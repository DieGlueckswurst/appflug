import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/measurements.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:appflug/routes/views.dart';
import 'package:appflug/shared_utils/layout_service.dart';
import 'package:appflug/ui/shared_widgets.dart/custom_list_tile.dart';
import 'package:flutter/material.dart';

class FastAccessView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: sidePadding,
        ),
        Row(
          children: [
            Text(
              'Schnellzugriff',
              style: AppTextStyles.montserratH3Bold.copyWith(
                color: AppColors.blue,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: LayoutService.isDesktop(context) ? 400 : double.infinity,
          ),
          child: Column(
            children: [
              CustomListTile(
                title: 'Präferenzliste',
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    Views.preferenceList,
                  );
                },
              ),
            ],
          ),
        ),
        SizedBox(
          height: sidePadding,
        )
      ],
    );
  }
}
