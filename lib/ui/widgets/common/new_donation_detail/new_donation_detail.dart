import 'package:flutter/material.dart';
import 'package:microdonations/core/extensions/string.extension.dart';
import 'package:microdonations/ui/common/app_theme.dart';
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(bottom: 37.0),
            child: Text(
              'Va a ingresar la siguiente donación',
              style: CustomStylesTheme.regular14_16,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const Text(
          'Productos',
          style: CustomStylesTheme.bold16_20,
          textAlign: TextAlign.left,
        ),
        ...viewModel.products
            .map((e) => Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
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
          padding: EdgeInsets.symmetric(vertical: 8.0),
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
      ],
    );
  }

  @override
  NewDonationDetailModel viewModelBuilder(
    BuildContext context,
  ) =>
      NewDonationDetailModel();
}
