import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../common/app_theme.dart';
import 'custom_outline_button_model.dart';

class CustomOutlineButton extends StackedView<CustomOutlineButtonModel> {
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
  Widget builder(
    BuildContext context,
    CustomOutlineButtonModel viewModel,
    Widget? child,
  ) {
    return OutlinedButton.icon(
      label: Text(
        label,
        style: CustomStylesTheme.regular16_20,
      ),
      icon: (icon != null) ? icon! : const SizedBox(),
      onPressed: () => action(),
      style: const ButtonStyle(
        side: MaterialStatePropertyAll(
          BorderSide(
            color: CustomStylesTheme.tertiaryColor,
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

  @override
  CustomOutlineButtonModel viewModelBuilder(
    BuildContext context,
  ) =>
      CustomOutlineButtonModel();
}
