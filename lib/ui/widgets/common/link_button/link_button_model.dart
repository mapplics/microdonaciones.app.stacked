import 'package:flutter/material.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:stacked/stacked.dart';

class LinkButtonModel extends BaseViewModel {
  final TextStyle? textStyleParam;

  LinkButtonModel(this.textStyleParam);

  /// Tipografia por defecto si no se le pasa un [TextStyle] al Widget.
  final TextStyle defaultTextStyle = AppTheme.bold16_20.copyWith(
    color: AppTheme.tertiaryColor,
  );

  /// El color que tiene el texto del boton cuando esta deshabilitado.
  final Color _disabledTextColor = AppTheme.darkGreyColor;

  TextStyle get getDisabledTextStyle {
    return textStyleParam?.copyWith(color: _disabledTextColor) ??
        defaultTextStyle.copyWith(color: _disabledTextColor);
  }

  /// Devuelve el [TextStyle] que se debe mostrar
  /// segun esta habilitado o no el boton.
  TextStyle? getTextStyle(VoidCallback? btnAction) =>
      (btnAction != null) ? textStyleParam : getDisabledTextStyle;
}
