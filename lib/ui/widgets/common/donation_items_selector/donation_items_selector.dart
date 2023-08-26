import 'package:flutter/material.dart';
import 'package:microdonations/ui/widgets/common/donation_item_card/donation_item_card.dart';
import 'package:stacked/stacked.dart';

import 'donation_items_selector_model.dart';

class DonationItemsSelector extends StackedView<DonationItemsSelectorModel> {
  const DonationItemsSelector({super.key});

  @override
  Widget builder(
    BuildContext context,
    DonationItemsSelectorModel viewModel,
    Widget? child,
  ) {
    return SingleChildScrollView(
      child: Column(
        children: [
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
