import 'package:appflug/constants/app_colors.dart';
import 'package:appflug/constants/measurements.dart';
import 'package:appflug/constants/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldWithRoundedBorder extends StatefulWidget {
  final String? hintText;
  final Function(String) onChanged;
  final bool focusOnInit;
  final TextInputType textInputType;
  final bool readOnly;
  final String? initValue;
  final VoidCallback? onTap;

  const TextFieldWithRoundedBorder({
    Key? key,
    required this.onChanged,
    this.hintText,
    this.focusOnInit = false,
    this.textInputType = TextInputType.text,
    this.readOnly = false,
    this.initValue,
    this.onTap,
  }) : super(key: key);

  @override
  State<TextFieldWithRoundedBorder> createState() =>
      _TextFieldWithRoundedBorderState();
}

class _TextFieldWithRoundedBorderState
    extends State<TextFieldWithRoundedBorder> {
  final FocusNode _focusNode = FocusNode();
  bool _showPassword = false;

  @override
  void initState() {
    super.initState();
    if (widget.focusOnInit) {
      WidgetsBinding.instance!.addPostFrameCallback(
        (_) {
          _focusNode.requestFocus();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.initValue,
      onTap: widget.onTap,
      readOnly: widget.readOnly,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(
            color: AppColors.blue,
            width: 3.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(
            color: AppColors.blue,
            width: 3.0,
          ),
        ),
        suffixIconColor: AppColors.blue,
        hintText: widget.hintText,
        suffixIcon: widget.textInputType == TextInputType.visiblePassword
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    _showPassword = !_showPassword;
                  });
                },
                child: Icon(
                  _showPassword
                      ? CupertinoIcons.eye_slash_fill
                      : CupertinoIcons.eye_fill,
                  color: AppColors.blue,
                ),
              )
            : null,
      ),
      obscureText: widget.textInputType == TextInputType.visiblePassword &&
          !_showPassword,
      enableSuggestions: widget.textInputType != TextInputType.visiblePassword,
      autocorrect: widget.textInputType != TextInputType.visiblePassword,
      style: AppTextStyles.montserratH6Regular,
      onChanged: widget.onChanged,
      focusNode: _focusNode,
      keyboardType: widget.textInputType,
    );
  }
}
