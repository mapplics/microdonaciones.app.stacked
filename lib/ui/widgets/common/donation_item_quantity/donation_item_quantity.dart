import 'package:flutter/material.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:microdonations/ui/widgets/common/quantity_picker/quantity_picker.dart';
import 'package:stacked/stacked.dart';

import 'donation_item_quantity_model.dart';

class DonationItemQuantity extends StackedView<DonationItemQuantityModel> {
  const DonationItemQuantity({super.key});

  @override
  Widget builder(
    BuildContext context,
    DonationItemQuantityModel viewModel,
    Widget? child,
  ) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 19.0),
          child: Text(
            'Seleccioná que alimentos son los que vas a donar',
            style: CustomStylesTheme.regular14_16,
          ),
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Arroz\nIntegral',
                    style: CustomStylesTheme.regular16_20.copyWith(
                      color: CustomStylesTheme.blackColor,
                    ),
                  ),
                  const QuantityPicker()
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  DonationItemQuantityModel viewModelBuilder(
    BuildContext context,
  ) =>
      DonationItemQuantityModel();
}
