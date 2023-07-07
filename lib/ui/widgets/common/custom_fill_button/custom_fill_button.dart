import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../common/app_theme.dart';
import 'custom_fill_button_model.dart';

class CustomFillButton extends StackedView<CustomFillButtonModel> {
  final String label;
  final Function action;
  final Widget? icon;
  final TextStyle? textStyle;
  final Color? backgroundColor;

  const CustomFillButton({
    required this.label,
    required this.action,
    this.icon,
    this.textStyle,
    this.backgroundColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    CustomFillButtonModel viewModel,
    Widget? child,
  ) {
    return SizedBox(
      height: 37,
      child: ElevatedButton.icon(
        label: Text(
          label,
          style: textStyle ??
              CustomStylesTheme.bold14_20.copyWith(
                color: Colors.white,
              ),
        ),
        icon: (icon != null) ? icon! : const SizedBox(),
        onPressed: () => action(),
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(
            (backgroundColor ?? CustomStylesTheme.primaryColor),
          ),
          shape: const MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(6),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  CustomFillButtonModel viewModelBuilder(
    BuildContext context,
  ) =>
      CustomFillButtonModel();
}
