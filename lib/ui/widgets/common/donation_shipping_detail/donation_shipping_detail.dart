import 'package:flutter/material.dart';
import 'package:microdonations/core/models/pickup_weekday_range_presentation.model.dart';
import 'package:microdonations/core/models/reception_point.model.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:microdonations/ui/widgets/common/delivery_segmented_buttons/delivery_segmented_buttons_model.dart';
import 'package:stacked/stacked.dart';

import 'donation_shipping_detail_model.dart';

class DonationShippingDetail extends StackedView<DonationShippingDetailModel> {
  final String? userAddress;
  final ReceptionPoint? receptionPoint;
  final TypeDelivery type;
  final PickupWeekDayRangePresentation? range;

  const DonationShippingDetail({
    required this.userAddress,
    required this.receptionPoint,
    required this.type,
    required this.range,
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
  DonationShippingDetailModel viewModelBuilder(
    BuildContext context,
  ) =>
      DonationShippingDetailModel(
        pickupPresentation: range,
        receptionPoint: receptionPoint,
        type: type,
        userAddress: userAddress,
      );
}
