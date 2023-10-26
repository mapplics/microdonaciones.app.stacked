import 'package:flutter/material.dart';
import 'package:microdonations/core/models/ong/ong_reception_point.model.dart';
import 'package:microdonations/core/typedef/typedefs.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:microdonations/ui/widgets/forms/custom_radio_list_tile/custom_radio_list_tile.dart';
import 'package:stacked/stacked.dart';

import 'reception_point_list_model.dart';

class ReceptionPointList extends StackedView<ReceptionPointListModel> {
  final List<OngReceptionPoint> receptionPoints;
  final OnChangeRadioButton onchange;
  final OngReceptionPoint? initialValue;

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
              (receptionPoint) => CustomRadioListTile<OngReceptionPoint>(
                title: Text(
                  '${receptionPoint.name} | ${receptionPoint.address}',
                  style: AppTheme.bold14_20.copyWith(
                    color: AppTheme.blackColor,
                  ),
                ),
                subtitle: Text(
                  receptionPoint.extraInfo,
                  style: AppTheme.regular14_20.copyWith(
                    color: AppTheme.blackColor,
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
