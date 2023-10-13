import 'package:flutter/material.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:microdonations/core/typedef/typedefs.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:stacked/stacked.dart';

import 'shipping_segmented_buttons_model.dart';

class ShippingSegmentedButtons
    extends StackedView<ShippingSegmentedButtonsModel> {
  final OnChangeTypeDelivery onChangeTypeDelivery;
  final ShippingMethod initialValue;
  final bool showReceptionPoint;

  const ShippingSegmentedButtons({
    required this.initialValue,
    required this.onChangeTypeDelivery,
    required this.showReceptionPoint,
    super.key,
  });

  @override
  Widget builder(
    BuildContext context,
    ShippingSegmentedButtonsModel viewModel,
    Widget? child,
  ) {
    return MaterialSegmentedControl<ShippingMethod>(
      children: viewModel.buildSegmentedButtons(),
      selectionIndex: viewModel.selectedDelivery,
      onSegmentTapped: viewModel.onChangeSelected,
      selectedColor: CustomStylesTheme.tertiaryColor,
      borderColor: CustomStylesTheme.gray100,
      unselectedColor: Colors.white,
      verticalOffset: 18.0,
      borderWidth: 0.7,
      horizontalPadding: const EdgeInsets.all(0),
    );
  }

  @override
  ShippingSegmentedButtonsModel viewModelBuilder(
    BuildContext context,
  ) =>
      ShippingSegmentedButtonsModel(
        initialValue: initialValue,
        onChangeTypeDelivery: onChangeTypeDelivery,
        showReceptionPoint: showReceptionPoint,
      );
}
