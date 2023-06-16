import 'package:flutter/material.dart';
import 'package:microdonations/ui/common/app_colors.dart';

class CustomOutlineButton extends StatelessWidget {
  final String label;
  final Function action;
  final Widget? icon;

  const CustomOutlineButton({
    required this.label,
    required this.action,
    this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      label: Text(label),
      icon: (icon != null) ? icon! : const SizedBox(),
      onPressed: () => action(),
      style: const ButtonStyle(
        side: MaterialStatePropertyAll(
          BorderSide(
            color: kcPrimaryColor,
          ),
        ),
        shape: MaterialStatePropertyAll(
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
