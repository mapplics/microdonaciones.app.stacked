import 'package:flutter/material.dart';
import 'package:microdonations/core/models/donation_item.model.dart';
import 'package:microdonations/core/typedef/typedefs.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:stacked/stacked.dart';

import 'donation_item_card_model.dart';

class DonationItemCard extends StackedView<DonationItemCardModel> {
  final DonationItem donationItem;
  final OnChangeCheckbox onChange;
  final bool initialValue;

  const DonationItemCard({
    required this.donationItem,
    required this.onChange,
    this.initialValue = false,
    super.key,
  });

  @override
  Widget builder(
    BuildContext context,
    DonationItemCardModel viewModel,
    Widget? child,
  ) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 110,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(donationItem.pathImg),
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
        Positioned.fill(
          child: Material(
            child: InkWell(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              onTap: viewModel.toggleCheckbox,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                donationItem.title,
                style: CustomStylesTheme.regular14_20.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
            Checkbox(
              value: viewModel.checkboxValue,
              onChanged: (_) => viewModel.toggleCheckbox(),
              side: MaterialStateBorderSide.resolveWith(
                (states) => BorderSide(
                  color: states.contains(MaterialState.selected)
                      ? CustomStylesTheme.primaryColor
                      : Colors.white,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  @override
  DonationItemCardModel viewModelBuilder(
    BuildContext context,
  ) =>
      DonationItemCardModel(onChange, initialValue);
}