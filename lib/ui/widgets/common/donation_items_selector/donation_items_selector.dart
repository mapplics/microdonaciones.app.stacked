import 'package:flutter/material.dart';
import 'package:microdonations/core/models/donation_item.model.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:microdonations/ui/widgets/common/donation_item_card/donation_item_card.dart';
import 'package:stacked/stacked.dart';

import 'donation_items_selector_model.dart';

typedef OnChangeSelectedItems = void Function(List<DonationItem>);

class DonationItemsSelector extends StackedView<DonationItemsSelectorModel> {
  const DonationItemsSelector({super.key});

  @override
  Widget builder(
    BuildContext context,
    DonationItemsSelectorModel viewModel,
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
              ...viewModel.donationItems
                  .map(
                    (item) => Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 7.5,
                      ),
                      child: DonationItemCard(
                        donationItem: item,
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
        ),
      ],
    );
  }

  @override
  DonationItemsSelectorModel viewModelBuilder(
    BuildContext context,
  ) =>
      DonationItemsSelectorModel();
}
