import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../common/app_theme.dart';
import 'custom_outline_button_model.dart';

class CustomOutlineButton extends StackedView<CustomOutlineButtonModel> {
  final String label;
  final Function action;
  final TextStyle? textStyle;
  final Widget? icon;
  final Color? mainColor;

  const CustomOutlineButton({
    required this.label,
    required this.action,
    this.icon,
    this.mainColor,
    this.textStyle,
    Key? key,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    CustomOutlineButtonModel viewModel,
    Widget? child,
  ) {
    return OutlinedButton.icon(
      label: Text(
        label,
        style: textStyle ??
            AppTheme.regular16_20.copyWith(
              color: mainColor ?? AppTheme.tertiaryColor,
            ),
      ),
      icon: (icon != null) ? icon! : const SizedBox(),
      onPressed: () => action(),
      style: ButtonStyle(
        side: MaterialStatePropertyAll(
          BorderSide(
            color: mainColor ?? AppTheme.tertiaryColor,
          ),
        ),
        minimumSize: MaterialStatePropertyAll(AppTheme.minimumBtnSize),
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

  @override
  CustomOutlineButtonModel viewModelBuilder(
    BuildContext context,
  ) =>
      CustomOutlineButtonModel();
}
