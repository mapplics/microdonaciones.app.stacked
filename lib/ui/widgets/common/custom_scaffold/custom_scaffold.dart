import 'package:flutter/material.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';
import 'package:stacked/stacked.dart';

import '../../../common/app_theme.dart';
import '../custom_appbar/custom_appbar.dart';
import '../rounded_body/rounded_body.dart';
import 'custom_scaffold_model.dart';

class CustomScaffold extends StackedView<CustomScaffoldModel> {
  final CustomAppbar appbar;
  final Widget body;
  final EdgeInsets? padding;

  const CustomScaffold({
    required this.appbar,
    required this.body,
    this.padding,
    super.key,
  });

  @override
  Widget builder(
    BuildContext context,
    CustomScaffoldModel viewModel,
    Widget? child,
  ) {
    return ScaffoldGradientBackground(
      gradient: const LinearGradient(
        colors: <Color>[
          CustomStylesTheme.secondaryColor,
          CustomStylesTheme.tertiaryColor
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      appBar: appbar,
      body: SizedBox(
        width: double.infinity,
        child: RoundedBody(
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 30),
          widgetContent: body,
        ),
      ),
    );
  }

  @override
  CustomScaffoldModel viewModelBuilder(
    BuildContext context,
  ) =>
      CustomScaffoldModel();
}
