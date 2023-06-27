import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'rounded_body_model.dart';

/// Containter con los border redondeados.
/// Lo utilizamos como hijo en los scaffold para dar la forma redondeada
/// del contenido.
class RoundedBody extends StackedView<RoundedBodyModel> {
  final Widget widgetContent;

  const RoundedBody({required this.widgetContent, super.key});

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
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26.0),
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
