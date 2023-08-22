import 'package:flutter/material.dart';
import 'package:microdonations/ui/common/app_theme.dart';
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
          const Padding(
            padding: EdgeInsets.only(bottom: 19.0),
            child: Text(
              'Seleccioná el metodo de entrega que quieras utilizar para tu donación',
              style: CustomStylesTheme.regular14_16,
              textAlign: TextAlign.center,
            ),
          ),
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
            ),
        ],
      ),
    );
  }

  @override
  SelectDeliveryMethodViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SelectDeliveryMethodViewModel();
}
