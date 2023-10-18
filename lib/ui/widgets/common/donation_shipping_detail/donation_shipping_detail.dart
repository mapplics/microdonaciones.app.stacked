import 'package:flutter/material.dart';
import 'package:microdonations/core/models/reception_point.model.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:microdonations/ui/widgets/new_donation/shipping_segmented_buttons/shipping_segmented_buttons_model.dart';
import 'package:stacked/stacked.dart';

import 'donation_shipping_detail_model.dart';

class DonationShippingDetail extends StackedView<DonationShippingDetailModel> {
  final String? userAddress;
  final ReceptionPoint? receptionPoint;
  final ShippingMethod type;
  final String? pickupDetail;

  const DonationShippingDetail({
    required this.userAddress,
    required this.receptionPoint,
    required this.type,
    required this.pickupDetail,
    super.key,
  });

  @override
  Widget builder(
    BuildContext context,
    DonationShippingDetailModel viewModel,
    Widget? child,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 38.0),
          child: Text(
            viewModel.deliverDescription,
            style: AppTheme.bold16_20,
          ),
        ),
        const Divider(),
        Text(
          viewModel.deliveryAddress,
          style: AppTheme.regular15_16.copyWith(
            color: AppTheme.tertiaryColor,
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 38.0),
          child: Text(
            'Horarios',
            style: AppTheme.bold16_20,
          ),
        ),
        const Divider(),
        Text(
          viewModel.deliveryTime,
          style: AppTheme.regular15_16.copyWith(
            color: AppTheme.tertiaryColor,
          ),
        )
      ],
    );
  }

  @override
  DonationShippingDetailModel viewModelBuilder(
    BuildContext context,
  ) =>
      DonationShippingDetailModel(
        pickupPresentation: pickupDetail,
        receptionPoint: receptionPoint,
        type: type,
        userAddress: userAddress,
      );
}
