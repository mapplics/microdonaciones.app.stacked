import 'package:flutter/material.dart';
import 'package:microdonations/core/extensions/string.extension.dart';
import 'package:microdonations/core/models/donation_item.model.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:stacked/stacked.dart';

import 'donation_item_list_detail_model.dart';

class DonationItemListDetail extends StackedView<DonationItemListDetailModel> {
  final List<DonationItem> donationItems;

  const DonationItemListDetail({required this.donationItems, super.key});

  @override
  Widget builder(
    BuildContext context,
    DonationItemListDetailModel viewModel,
    Widget? child,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Productos',
          style: AppTheme.bold16_20,
          textAlign: TextAlign.left,
        ),
        ...viewModel.donationItems
            .map((e) => Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.0),
                      child: Divider(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Text(
                            e.title.capitalize(),
                            style: AppTheme.regular15_16,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: Text(
                            e.quantity.toString(),
                            style: AppTheme.bold16_20.copyWith(
                              color: AppTheme.tertiaryColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ))
            .toList(),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 4.0),
          child: Divider(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'total de productos'.toUpperCase(),
              style: AppTheme.regular15_16.copyWith(
                color: AppTheme.primaryColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Text(
                viewModel.totalProducts.toString(),
                style: AppTheme.bold16_20.copyWith(
                  color: AppTheme.primaryColor,
                ),
              ),
            )
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 4.0),
          child: Divider(),
        ),
      ],
    );
  }

  @override
  DonationItemListDetailModel viewModelBuilder(
    BuildContext context,
  ) =>
      DonationItemListDetailModel(donationItems);
}
