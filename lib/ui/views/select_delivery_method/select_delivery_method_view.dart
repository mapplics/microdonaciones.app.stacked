import 'package:flutter/material.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:microdonations/ui/widgets/common/delivery_segmented_buttons/delivery_segmented_buttons.dart';
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
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 19.0),
            child: Text(
              'Seleccioná que metodo de entrega quieres utilizar para tu donación',
              style: CustomStylesTheme.regular14_16,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: DeliverySegmentedButtons(
              onChangeTypeDelivery: viewModel.onChangeTypeDelivery,
              initialValue: viewModel.typeDeliverySelected,
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
                    // textAlign: TextAlign.start,
                  ),
                  Text(
                    viewModel.userAddress.fullAddress,
                    style: CustomStylesTheme.regular16_20.copyWith(
                      color: CustomStylesTheme.blackColor,
                    ),
                    // textAlign: TextAlign.start,
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
