import 'package:flutter/material.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:microdonations/ui/common/helpers/logger.helpers.dart';
import 'package:microdonations/ui/widgets/common/delivery_segmented_buttons/delivery_segmented_buttons.dart';
import 'package:microdonations/ui/widgets/common/link_button/link_button.dart';
import 'package:stacked/stacked.dart';

import 'select_delivery_method_viewmodel.dart';

class SelectDeliveryMethodView
    extends StackedView<SelectDeliveryMethodViewModel> {
  const SelectDeliveryMethodView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SelectDeliveryMethodViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: Column(
        children: [
          /// Descripcion
          const Padding(
            padding: EdgeInsets.only(bottom: 19.0),
            child: Text(
              'Seleccioná el metodo de entrega que quieras utilizar para tu donación',
              style: CustomStylesTheme.regular14_16,
              textAlign: TextAlign.center,
            ),
          ),

          /// Segmented Buttons
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: SizedBox(
              width: double.infinity,
              child: DeliverySegmentedButtons(
                onChangeTypeDelivery: viewModel.onChangeTypeDelivery,
                initialValue: viewModel.typeDeliverySelected,
              ),
            ),
          ),

          /// Instrucciones para retiro por domicilio
          if (viewModel.isHomeDelivery)
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Vamos a retirar tu donación por',
                    style: CustomStylesTheme.bold16_20.copyWith(
                      color: CustomStylesTheme.blackColor,
                    ),
                  ),
                  Text(
                    viewModel.userAddress.fullAddress,
                    style: CustomStylesTheme.regular14_20.copyWith(
                      color: CustomStylesTheme.blackColor,
                    ),
                  ),
                  LinkButton(
                    label: 'Cambiar dirección',
                    action: viewModel.navigateToPersonalInformation,
                    buttonStyle: const ButtonStyle(
                      padding: MaterialStatePropertyAll(
                        EdgeInsets.all(0),
                      ),
                    ),
                    textStyle: CustomStylesTheme.regular14_20.copyWith(
                      color: CustomStylesTheme.tertiaryColor,
                    ),
                  ),
                ],
              ),
            )
          else
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (viewModel.loadingReceptionPoints)
                    const Padding(
                      padding: EdgeInsets.only(top: 60.0),
                      child: CircularProgressIndicator(),
                    )
                  else
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Puntos de entrega para dejar tu donación',
                          style: CustomStylesTheme.bold16_20.copyWith(
                            color: CustomStylesTheme.blackColor,
                          ),
                        ),
                        ...viewModel.receptionPoints
                            .map(
                              (receptionPoint) => Text(
                                '- ${receptionPoint.extraInfo}',
                                style: CustomStylesTheme.regular14_20.copyWith(
                                  color: CustomStylesTheme.blackColor,
                                ),
                              ),
                            )
                            .toList()
                      ],
                    )
                ],
              ),
            ),
        ],
      ),
    );
  }

  @override
  void onViewModelReady(SelectDeliveryMethodViewModel viewModel) {
    if (viewModel.receptionPoints.isEmpty) {
      logWarn('No tengo que cargar nada');
      viewModel.loadReceptionPoints();
    } else {
      logWarn('No tengo que cargar nada');
    }
    super.onViewModelReady(viewModel);
  }

  @override
  SelectDeliveryMethodViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SelectDeliveryMethodViewModel();
}
