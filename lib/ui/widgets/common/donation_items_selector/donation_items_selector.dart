import 'package:flutter/material.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:microdonations/ui/widgets/common/donation_item_card/donation_item_card.dart';
import 'package:microdonations/ui/widgets/common/empty_state_with_button/empty_state_with_button.dart';
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
    return (viewModel.isLoading)
        ? const Center(
            child: CircularProgressIndicator(
              color: CustomStylesTheme.primaryColor,
            ),
          )
        : (viewModel.httpHaveFailed)
            ? EmptyStateWithButton(
                title: 'Hago salio mal',
                body: 'Por favor, volver a intentarlo.',
                textButton: 'Volver a intentar',
                buttonAction: viewModel.getDonationsItems,
              )
            : Column(
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
                        ...viewModel.donationItemsOptions
                            .map(
                              (item) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 7.5,
                                ),
                                child: DonationItemCard(
                                  product: item,
                                  initialValue: viewModel.isSelectedItem(item),
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
              );
  }

  @override
  void onViewModelReady(DonationItemsSelectorModel viewModel) {
    viewModel.getDonationsItems();
    super.onViewModelReady(viewModel);
  }

  @override
  DonationItemsSelectorModel viewModelBuilder(
    BuildContext context,
  ) =>
      DonationItemsSelectorModel();
}
