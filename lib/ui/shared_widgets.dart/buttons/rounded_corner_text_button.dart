import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/box_decoration.dart';
import 'package:appflug/constants/measurements.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

class RoundedCornersTextButton extends StatefulWidget {
  final VoidCallback onTap;
  final String title;
  final Color textColor;
  final bool isLoading;
  final Color backgroundColor;
  final Color? borderColor;
  final double? width;
  final String? leadingIconPath;
  final Color? iconColor;
  final bool isEnabled;
  final double iconSize;
  final String? heroKey;

  const RoundedCornersTextButton({
    required this.title,
    required this.onTap,
    this.textColor = AppColors.yellow,
    this.isLoading = false,
    this.backgroundColor = AppColors.blue,
    this.borderColor,
    this.width,
    this.leadingIconPath,
    this.iconColor,
    this.isEnabled = true,
    this.iconSize = 23,
    this.heroKey,
  });

  @override
  _RoundedCornersTextButtonState createState() =>
      _RoundedCornersTextButtonState();
}

class _RoundedCornersTextButtonState extends State<RoundedCornersTextButton>
    with SingleTickerProviderStateMixin {
  late double _scale;
  late AnimationController _controller;
  bool isTapped = false;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      lowerBound: 0.0,
      upperBound: 0.05,
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    return Material(
      color: AppColors.transparent,
      child: HeroMode(
        enabled: widget.heroKey != null,
        child: Hero(
          transitionOnUserGestures: true,
          tag: widget.heroKey ?? '',
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Listener(
              onPointerDown: (PointerDownEvent event) {
                _onTapDown();
              },
              onPointerUp: (PointerUpEvent event) {
                _onTapCancel();
              },
              child: GestureDetector(
                onTap: () {
                  if (widget.isEnabled && !widget.isLoading) {
                    widget.onTap();
                  }
                },
                onTapCancel: () {
                  _onTapCancel();
                },
                child: Transform.scale(
                  scale: _scale,
                  child: Container(
                    height: 55,
                    width: widget.width,
                    decoration: BoxDecoration(
                      borderRadius: borderRadius,
                      color: widget.isEnabled
                          ? widget.backgroundColor
                          : widget.backgroundColor.withOpacity(0.5),
                      border: widget.borderColor != null
                          ? Border.all(
                              color: widget.borderColor!,
                              width: defaultBorderWith,
                            )
                          : null,
                    ),
                    child: Center(
                      child: widget.isLoading
                          ? Padding(
                              padding: EdgeInsets.only(bottom: 4),
                              child: Lottie.asset(
                                'assets/lottie/loading_dots_secondary.json',
                                animate: true,
                                repeat: true,
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                if (widget.leadingIconPath != null)
                                  SvgPicture.asset(
                                    widget.leadingIconPath!,
                                    height: widget.iconSize,
                                    width: widget.iconSize,
                                    color: isTapped
                                        ? (widget.iconColor ?? AppColors.blue)
                                            .withOpacity(0.5)
                                        : widget.iconColor ?? AppColors.blue,
                                    fit: BoxFit.contain,
                                  ),
                                Expanded(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Material(
                                      color: AppColors.transparent,
                                      child: Text(
                                        widget.title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                        textAlign: TextAlign.center,
                                        style: AppTextStyles
                                            .montserratH6SemiBold
                                            .copyWith(
                                          color: isTapped || !widget.isEnabled
                                              ? widget.textColor
                                                  .withOpacity(0.5)
                                              : widget.textColor,
                                          height: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                if (widget.leadingIconPath != null)
                                  SizedBox(
                                    width: widget.iconSize,
                                  ),
                                SizedBox(
                                  width: 20,
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapDown() {
    _controller.forward();

    setState(() {
      isTapped = true;
    });
  }

  void _onTapCancel() {
    _controller.reverse();
    setState(() {
      isTapped = false;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
