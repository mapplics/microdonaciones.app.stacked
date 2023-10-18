import 'package:flutter/material.dart';
import 'package:microdonations/core/typedef/typedefs.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stacked/stacked.dart';

import 'quantity_picker_model.dart';

class QuantityPicker extends StackedView<QuantityPickerModel> {
  final int initialValue;
  final OnChangeQuantityPicker onChange;

  const QuantityPicker({
    required this.onChange,
    this.initialValue = 0,
    super.key,
  });

  @override
  Widget builder(
    BuildContext context,
    QuantityPickerModel viewModel,
    Widget? child,
  ) {
    return Row(
      children: [
        SizedBox(
          width: 35,
          height: 35,
          child: IconButton.filled(
            onPressed: viewModel.substractOne,
            style: const ButtonStyle(
              padding: MaterialStatePropertyAll(
                EdgeInsets.all(0.0),
              ),
              backgroundColor: MaterialStatePropertyAll(
                AppTheme.gray400,
              ),
            ),
            icon: const Icon(
              PhosphorIcons.minusBold,
              color: AppTheme.lightGreyColor,
              size: 12.0,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Text(
            viewModel.quantityValue.toString(),
            style: AppTheme.bold16_20.copyWith(
              color: AppTheme.tertiaryColor,
            ),
          ),
        ),
        SizedBox(
          width: 35,
          height: 35,
          child: IconButton.filled(
            onPressed: viewModel.addOne,
            style: const ButtonStyle(
              padding: MaterialStatePropertyAll(
                EdgeInsets.all(0.0),
              ),
              backgroundColor: MaterialStatePropertyAll(
                AppTheme.gray400,
              ),
            ),
            icon: const Icon(
              PhosphorIcons.plusBold,
              color: AppTheme.lightGreyColor,
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
      QuantityPickerModel(onChange, initialValue);
}
