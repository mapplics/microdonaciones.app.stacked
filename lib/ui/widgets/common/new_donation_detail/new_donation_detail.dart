import 'package:flutter/material.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:microdonations/ui/widgets/common/donation_delivery_detail/donation_delivery_detail.dart';
import 'package:microdonations/ui/widgets/common/donation_item_list_detail/donation_item_list_detail.dart';
import 'package:stacked/stacked.dart';

import 'new_donation_detail_model.dart';

class NewDonationDetail extends StackedView<NewDonationDetailModel> {
  const NewDonationDetail({super.key});

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
        const DonationDeliveryDetail(),
      ],
    );
  }

  @override
  NewDonationDetailModel viewModelBuilder(
    BuildContext context,
  ) =>
      NewDonationDetailModel();
}
