import 'package:flutter/material.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stacked/stacked.dart';

import 'quantity_picker_model.dart';

class QuantityPicker extends StackedView<QuantityPickerModel> {
  const QuantityPicker({super.key});

  @override
  Widget builder(
    BuildContext context,
    QuantityPickerModel viewModel,
    Widget? child,
  ) {
    return Row(
      children: [
        SizedBox(
          width: 30,
          height: 30,
          child: IconButton.filled(
            onPressed: viewModel.substractOne,
            style: const ButtonStyle(
              padding: MaterialStatePropertyAll(
                EdgeInsets.all(0.0),
              ),
              backgroundColor: MaterialStatePropertyAll(
                CustomStylesTheme.gray400,
              ),
            ),
            icon: Icon(
              PhosphorIcons.bold.minus,
              color: CustomStylesTheme.lightGreyColor,
              size: 12.0,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Text(
            viewModel.quantity.toString(),
            style: CustomStylesTheme.bold16_20.copyWith(
              color: CustomStylesTheme.tertiaryColor,
            ),
          ),
        ),
        SizedBox(
          width: 30,
          height: 30,
          child: IconButton.filled(
            onPressed: viewModel.addOne,
            style: const ButtonStyle(
              padding: MaterialStatePropertyAll(
                EdgeInsets.all(0.0),
              ),
              backgroundColor: MaterialStatePropertyAll(
                CustomStylesTheme.gray400,
              ),
            ),
            icon: Icon(
              PhosphorIcons.bold.plus,
              color: CustomStylesTheme.lightGreyColor,
              size: 12.0,
            ),
          ),
        ),
      ],
    );
  }

  @override
  QuantityPickerModel viewModelBuilder(
    BuildContext context,
  ) =>
      QuantityPickerModel();
}
