import 'package:flutter/material.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:microdonations/ui/widgets/new_donation/donation_item_card/donation_item_card.dart';
import 'package:stacked/stacked.dart';

import 'new_donation_items_selector_model.dart';

class NewDonationItemsSelector extends StackedView<DonationItemsSelectorModel> {
  const NewDonationItemsSelector({super.key});

  @override
  Widget builder(
    BuildContext context,
    DonationItemsSelectorModel viewModel,
    Widget? child,
  ) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 19.0),
            child: Text(
              'Seleccióná qué alimentos son los que vas a donar.',
              style: AppTheme.regular14_16,
              textAlign: TextAlign.center,
            ),
          ),
          ...viewModel.donationItemsOptions
              .map(
                (item) => Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 7.5,
                  ),
                  child: DonationItemCard(
                    product: item,
                    initialValue: viewModel.isSelectedItem(item),
                    onChange: (newValue) => viewModel.handleToggleDonation(
                      newValue,
                      item,
                    ),
                  ),
                ),
              )
              .toList(),
        ],
      ),
    );
  }

  @override
  DonationItemsSelectorModel viewModelBuilder(
    BuildContext context,
  ) =>
      DonationItemsSelectorModel();
}
