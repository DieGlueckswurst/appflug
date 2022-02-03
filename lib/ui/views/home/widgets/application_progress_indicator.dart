import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/enums/application_status_option.dart';
import 'package:flutter/material.dart';

class ApplicationProgressIndicator extends StatefulWidget {
  final ApplicationStatusOption currentApplicationStatus;

  const ApplicationProgressIndicator({
    required this.currentApplicationStatus,
  });

  @override
  State<ApplicationProgressIndicator> createState() =>
      _ApplicationProgressIndicatorState();
}

class _ApplicationProgressIndicatorState
    extends State<ApplicationProgressIndicator> {
  late int currentApplicationOptionIndex;

  @override
  Widget build(BuildContext context) {
    currentApplicationOptionIndex =
        ApplicationStatusOption.values.toList().indexWhere(
              (option) => option == widget.currentApplicationStatus,
            );

    if (widget.currentApplicationStatus ==
        ApplicationStatusOption.rejectedDocuments) {
      currentApplicationOptionIndex = 2;
    }
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 2,
          color: AppColors.blue,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            ApplicationStatusOption.values.length - 1,
            (index) => _buildDot(
              index: index,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildDot({
    required int index,
  }) {
    return Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: 2,
          color: AppColors.blue,
        ),
        color: currentApplicationOptionIndex == index
            ? AppColors.yellow
            : index < currentApplicationOptionIndex
                ? AppColors.green
                : AppColors.white,
      ),
    );
  }
}
