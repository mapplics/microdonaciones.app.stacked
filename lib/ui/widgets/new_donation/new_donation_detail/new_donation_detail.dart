import 'package:flutter/material.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:microdonations/ui/widgets/new_donation/shipping_segmented_buttons/shipping_segmented_buttons_model.dart';
import 'package:microdonations/ui/widgets/common/donation_item_list_detail/donation_item_list_detail.dart';
import 'package:microdonations/ui/widgets/common/donation_shipping_detail/donation_shipping_detail.dart';
import 'package:stacked/stacked.dart';

import 'new_donation_detail_model.dart';

class NewDonationSummary extends StackedView<NewDonationDetailModel> {
  const NewDonationSummary({super.key});

  @override
  Widget builder(
    BuildContext context,
    NewDonationDetailModel viewModel,
    Widget? child,
  ) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 37.0),
          child: Text(
            'Va a ingresar la siguiente donación',
            style: CustomStylesTheme.regular14_16,
            textAlign: TextAlign.center,
          ),
        ),

        /// Detalle con los items que se van a donar.
        DonationItemListDetail(donationItems: viewModel.products),

        /// Detalle de como se va a entregar la donación.
        DonationShippingDetail(
          receptionPoint: viewModel.receptionPoint,
          type: viewModel.shippingMethod,
          userAddress: viewModel.userAddres,
          pickupDetail: viewModel.shippingMethod == ShippingMethod.pickup
              ? viewModel.presentation
              : null,
        ),
      ],
    );
  }

  @override
  NewDonationDetailModel viewModelBuilder(
    BuildContext context,
  ) =>
      NewDonationDetailModel();
}
