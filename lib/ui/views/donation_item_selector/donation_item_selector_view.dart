import 'package:flutter/material.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:microdonations/ui/widgets/common/custom_appbar/custom_appbar.dart';
import 'package:microdonations/ui/widgets/common/custom_scaffold/custom_scaffold.dart';
import 'package:microdonations/ui/widgets/common/donation_item_card/donation_item_card.dart';
import 'package:stacked/stacked.dart';

import 'donation_item_selector_viewmodel.dart';

class DonationItemSelectorView
    extends StackedView<DonationItemSelectorViewModel> {
  const DonationItemSelectorView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    DonationItemSelectorViewModel viewModel,
    Widget? child,
  ) {
    return CustomScaffold(
      appbar: const CustomAppbar(title: 'Que necesitamos?'),
      body: Column(
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
                          onChange: (newValue) =>
                              viewModel.handleToggleDonation(
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
      ),
    );
  }

  @override
  DonationItemSelectorViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      DonationItemSelectorViewModel();
}
