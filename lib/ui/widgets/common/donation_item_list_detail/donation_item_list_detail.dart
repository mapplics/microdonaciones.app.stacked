import 'package:flutter/material.dart';
import 'package:microdonations/core/extensions/string.extension.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:stacked/stacked.dart';

import 'donation_item_list_detail_model.dart';

class DonationItemListDetail extends StackedView<DonationItemListDetailModel> {
  const DonationItemListDetail({super.key});

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
          style: CustomStylesTheme.bold16_20,
          textAlign: TextAlign.left,
        ),
        ...viewModel.products
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
                            style: CustomStylesTheme.regular15_16,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: Text(
                            e.quantity.toString(),
                            style: CustomStylesTheme.bold16_20.copyWith(
                              color: CustomStylesTheme.tertiaryColor,
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
              style: CustomStylesTheme.regular15_16.copyWith(
                color: CustomStylesTheme.primaryColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Text(
                viewModel.totalProducts.toString(),
                style: CustomStylesTheme.bold16_20.copyWith(
                  color: CustomStylesTheme.primaryColor,
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
      DonationItemListDetailModel();
}
