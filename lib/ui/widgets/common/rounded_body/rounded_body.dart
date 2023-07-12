import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'rounded_body_model.dart';

/// Containter con los border redondeados.
/// Lo utilizamos como hijo en los scaffold para dar la forma redondeada
/// del contenido.
class RoundedBody extends StackedView<RoundedBodyModel> {
  final Widget widgetContent;
  final EdgeInsets? padding;

  const RoundedBody({required this.widgetContent, this.padding, super.key});

  @override
  Widget builder(
    BuildContext context,
    RoundedBodyModel viewModel,
    Widget? child,
  ) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 26.0),
        child: widgetContent,
      ),
    );
  }

  @override
  RoundedBodyModel viewModelBuilder(
    BuildContext context,
  ) =>
      RoundedBodyModel();
}
