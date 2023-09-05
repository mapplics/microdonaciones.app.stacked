import 'package:flutter/material.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:stacked/stacked.dart';

import 'donation_delivery_detail_model.dart';

class DonationDeliveryDetail extends StackedView<DonationDeliveryDetailModel> {
  const DonationDeliveryDetail({super.key});

  @override
  Widget builder(
    BuildContext context,
    DonationDeliveryDetailModel viewModel,
    Widget? child,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 38.0),
          child: Text(
            viewModel.deliverDescription,
            style: CustomStylesTheme.bold16_20,
          ),
        ),
        const Divider(),
        Text(
          viewModel.deliveryAddress,
          style: CustomStylesTheme.regular15_16.copyWith(
            color: CustomStylesTheme.tertiaryColor,
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 38.0),
          child: Text(
            'Horarios',
            style: CustomStylesTheme.bold16_20,
          ),
        ),
        const Divider(),
        Text(
          viewModel.deliveryTime,
          style: CustomStylesTheme.regular15_16.copyWith(
            color: CustomStylesTheme.tertiaryColor,
          ),
        )
      ],
    );
  }

  @override
  DonationDeliveryDetailModel viewModelBuilder(
    BuildContext context,
  ) =>
      DonationDeliveryDetailModel();
}
