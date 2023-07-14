import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'link_button_model.dart';

class LinkButton extends StackedView<LinkButtonModel> {
  final String label;
  final TextStyle? textStyle;
  final VoidCallback? action;

  /// boton sin relleno y sin borde
  ///
  /// recibe como parametro un titulo [label], una funcion [action] que se ejecuta en el click
  /// y [textStyle] es el estilo del texto que es opcional
  const LinkButton({
    required this.label,
    required this.action,
    this.textStyle,
    Key? key,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    LinkButtonModel viewModel,
    Widget? child,
  ) {
    return TextButton(
      onPressed: action,
      child: Text(
        label,
        style: viewModel.getTextStyle(action),
      ),
    );
  }

  @override
  LinkButtonModel viewModelBuilder(
    BuildContext context,
  ) =>
      LinkButtonModel(textStyle);
}
