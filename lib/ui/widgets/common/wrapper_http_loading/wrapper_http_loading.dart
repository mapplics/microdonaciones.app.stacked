import 'package:flutter/material.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:microdonations/ui/widgets/empty_states/empty_state_with_button/empty_state_with_button.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stacked/stacked.dart';

import 'wrapper_http_loading_model.dart';

/// Widget que permite resolver de manera ordenada la transicion
/// de una llamada http.
///
/// Si [showLoading] es true el widget muestra un loading.
///
/// Si [showError] es true el widget muestra un empty state de error con un
/// boton que ejecuta el [retryFunction].
///
/// [retryFunction] deberia volver a ejecutar la llamada Http que
/// el widget padre ejecuto, para volver a empezar el flujo.
///
/// [mainContent] es el widget que se va a mostrar
/// una vez que la llamada http fue exitosa y no hubo ningun error.
class WrapperHttpLoading extends StackedView<WrapperHttpLoadingModel> {
  final Widget mainContent;
  final bool showLoading;
  final bool showError;
  final Function retryFunction;

  const WrapperHttpLoading({
    required this.mainContent,
    required this.showLoading,
    required this.showError,
    required this.retryFunction,
    super.key,
  });

  @override
  Widget builder(
    BuildContext context,
    WrapperHttpLoadingModel viewModel,
    Widget? child,
  ) {
    return (showLoading)
        ? const Center(
            child: CircularProgressIndicator(
              color: AppTheme.primaryColor,
            ),
          )
        : (showError)
            ? EmptyStateWithButton(
                title: 'Hago salio mal',
                body: 'Por favor, volver a intentarlo.',
                textButton: 'Volver a intentar',
                buttonAction: retryFunction,
                icon: PhosphorIcons.xCircleBold,
                colorIcon: AppTheme.errorColor,
              )
            : mainContent;
  }

  @override
  WrapperHttpLoadingModel viewModelBuilder(
    BuildContext context,
  ) =>
      WrapperHttpLoadingModel();
}
