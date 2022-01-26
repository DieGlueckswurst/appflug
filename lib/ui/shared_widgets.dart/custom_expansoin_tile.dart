import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/measurements.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:flutter/material.dart';

class CustomExpansionTile extends StatefulWidget {
  final String title;
  final String description;
  final String content;

  const CustomExpansionTile({
    Key? key,
    required this.title,
    required this.description,
    required this.content,
  }) : super(key: key);

  @override
  State<CustomExpansionTile> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ExpansionTile(
      tilePadding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 15,
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            widget.title,
            style: AppTextStyles.montserratH4SemiBold.copyWith(
              color: AppColors.blue,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            widget.description,
            style: AppTextStyles.montserratH5SemiBold,
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
      collapsedIconColor: AppColors.blue,
      iconColor: AppColors.blue,
      children: [
        ListTile(
          enableFeedback: false,
          title: Padding(
            padding: const EdgeInsets.only(
              bottom: sidePadding,
            ),
            child: Text(
              widget.content,
              style: AppTextStyles.montserratH6Regular,
            ),
          ),
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
