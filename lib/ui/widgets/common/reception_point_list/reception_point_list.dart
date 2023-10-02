import 'package:flutter/material.dart';
import 'package:microdonations/core/models/reception_point.model.dart';
import 'package:microdonations/core/typedef/typedefs.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:microdonations/ui/widgets/forms/custom_radio_list_tile/custom_radio_list_tile.dart';
import 'package:stacked/stacked.dart';

import 'reception_point_list_model.dart';

class ReceptionPointList extends StackedView<ReceptionPointListModel> {
  final List<ReceptionPoint> receptionPoints;
  final OnChangeRadioButton onchange;
  final ReceptionPoint? initialValue;

  const ReceptionPointList({
    required this.receptionPoints,
    required this.onchange,
    this.initialValue,
    super.key,
  });

  @override
  Widget builder(
    BuildContext context,
    ReceptionPointListModel viewModel,
    Widget? child,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...receptionPoints
            .map(
              (receptionPoint) => CustomRadioListTile<ReceptionPoint>(
                title: Text(
                  '${receptionPoint.name} | ${receptionPoint.address}',
                  style: CustomStylesTheme.bold14_20.copyWith(
                    color: CustomStylesTheme.blackColor,
                  ),
                ),
                subtitle: Text(
                  'Horarios: ${receptionPoint.extraInfo}',
                  style: CustomStylesTheme.regular14_20.copyWith(
                    color: CustomStylesTheme.blackColor,
                  ),
                ),
                value: receptionPoint,
                selectedValue: viewModel.selectedValue,
                onchange: <ReceptionPoint>(dynamic newValue) =>
                    viewModel.onchangeValue(newValue),
              ),
            )
            .toList()
      ],
    );
  }

  @override
  ReceptionPointListModel viewModelBuilder(
    BuildContext context,
  ) =>
      ReceptionPointListModel(onchange, initialValue);
}
