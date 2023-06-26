import 'package:flutter/material.dart';
import 'package:microdonations/ui/common/app_theme.dart';

class CustomFillButton extends StatelessWidget {
  final String label;
  final Function action;
  final Widget? icon;
  final TextStyle? textStyle;
  final Colors? backgroundColor;

  const CustomFillButton({
    required this.label,
    required this.action,
    this.icon,
    this.textStyle,
    this.backgroundColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      label: Text(
        label,
        style: textStyle ?? CustomStylesTheme.regular16_20,
      ),
      icon: (icon != null) ? icon! : const SizedBox(),
      onPressed: () => action(),
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(
          (backgroundColor ?? CustomStylesTheme.primaryColor) as Color?,
        ),
        shape: const MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            ),
          ),
        ),
      ),
    );
  }
}
