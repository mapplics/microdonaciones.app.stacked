import 'package:flutter/material.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
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
          SegmentedButton(
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                CustomStylesTheme.secondaryColor,
              ),
              side: MaterialStatePropertyAll(
                BorderSide(
                  color: CustomStylesTheme.primaryColor,
                ),
              ),
              foregroundColor: MaterialStatePropertyAll(
                CustomStylesTheme.errorColor,
              ),
              shadowColor: MaterialStatePropertyAll(
                CustomStylesTheme.sucessColor,
              ),
            ),
            segments: [
              ButtonSegment(
                label: Text(
                  'Test',
                  style: CustomStylesTheme.bold12_16.copyWith(
                    color: Colors.white,
                  ),
                ),
                icon: Icon(PhosphorIcons.bold.houseLine),
                value: TypeDelivery.home,
              ),
              ButtonSegment(
                label: Text(
                  'Test',
                  style: CustomStylesTheme.bold12_16.copyWith(
                    color: Colors.white,
                  ),
                ),
                icon: Icon(PhosphorIcons.bold.mapPinLine),
                value: TypeDelivery.branch,
              ),
            ],
            selected: viewModel.deliveryTypeSelected,
            onSelectionChanged: viewModel.onchangeDeliveryType,
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
