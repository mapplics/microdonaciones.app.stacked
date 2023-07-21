import 'package:flutter/material.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:microdonations/core/typedef/typedefs.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:stacked/stacked.dart';

import 'delivery_segmented_buttons_model.dart';

class DeliverySegmentedButtons
    extends StackedView<DeliverySegmentedButtonsModel> {
  final OnChangeTypeDelivery onChangeTypeDelivery;
  final TypeDelivery initialValue;

  const DeliverySegmentedButtons({
    required this.initialValue,
    required this.onChangeTypeDelivery,
    super.key,
  });

  @override
  Widget builder(
    BuildContext context,
    DeliverySegmentedButtonsModel viewModel,
    Widget? child,
  ) {
    return MaterialSegmentedControl<TypeDelivery>(
      children: viewModel.buildSegmentedButtons(),
      selectionIndex: viewModel.deliverySelected,
      onSegmentTapped: viewModel.onChangeSelected,
      selectedColor: CustomStylesTheme.primaryColor,
      borderColor: CustomStylesTheme.gray100,
      unselectedColor: Colors.white,
      verticalOffset: 18.0,
      borderWidth: 0.7,
    );
  }

  @override
  DeliverySegmentedButtonsModel viewModelBuilder(
    BuildContext context,
  ) =>
      DeliverySegmentedButtonsModel(initialValue, onChangeTypeDelivery);
}
