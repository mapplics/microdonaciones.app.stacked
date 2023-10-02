import 'package:flutter/material.dart';
import 'package:microdonations/core/extensions/string.extension.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:microdonations/ui/widgets/new_donation/quantity_picker/quantity_picker.dart';
import 'package:stacked/stacked.dart';

import 'new_donation_item_quantity_model.dart';

class NewDonationItemQuantity extends StackedView<DonationItemQuantityModel> {
  const NewDonationItemQuantity({super.key});

  @override
  Widget builder(
    BuildContext context,
    DonationItemQuantityModel viewModel,
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
        Expanded(
          child: ListView.separated(
            itemBuilder: (_, index) {
              return Column(
                children: [
                  if (viewModel.shouldShoWFirstDivider(index))
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Divider(),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        viewModel.selectedItems[index].title.capitalize(),
                        style: CustomStylesTheme.regular16_20.copyWith(
                          color: CustomStylesTheme.blackColor,
                        ),
                      ),
                      QuantityPicker(
                        initialValue: viewModel.selectedItems[index].quantity,
                        onChange: (quantity) => viewModel.updateItemQuantity(
                          viewModel.selectedItems[index],
                          quantity,
                        ),
                      ),
                    ],
                  ),
                  if (viewModel.shouldShowLastDivider(index))
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Divider(),
                    )
                ],
              );
            },
            separatorBuilder: (_, __) => const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Divider(),
            ),
            itemCount: viewModel.selectedItems.length,
          ),
        ),
      ],
    );
  }

  @override
  void onViewModelReady(DonationItemQuantityModel viewModel) {
    viewModel.getSelectedItems();
    super.onViewModelReady(viewModel);
  }

  @override
  DonationItemQuantityModel viewModelBuilder(
    BuildContext context,
  ) =>
      DonationItemQuantityModel();
}
