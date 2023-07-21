import 'package:flutter/material.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:stacked/stacked.dart';

import 'select_delivery_method_viewmodel.dart';
import 'package:material_segmented_control/material_segmented_control.dart';

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
          SizedBox(
            width: double.infinity,
            child: MaterialSegmentedControl<TypeDelivery>(
              children: viewModel.buildSegmentedButtons(),
              selectionIndex: viewModel.deliverySelected,
              onSegmentTapped: viewModel.onChangeSelected,
              selectedColor: CustomStylesTheme.primaryColor,
              borderColor: CustomStylesTheme.gray100,
              unselectedColor: Colors.white,
              verticalOffset: 18.0,
              borderWidth: 0.7,
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
