import 'package:flutter/material.dart';
import 'package:microdonations/core/models/reception_point.model.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:stacked/stacked.dart';

import 'reception_point_list_model.dart';

class ReceptionPointList extends StackedView<ReceptionPointListModel> {
  final List<ReceptionPoint> receptionPoints;

  const ReceptionPointList({required this.receptionPoints, super.key});

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
              (receptionPoint) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 4.0),
                          child: Icon(
                            Icons.circle,
                            size: 8,
                            color: CustomStylesTheme.tertiaryColor,
                          ),
                        ),
                        Text(
                          '${receptionPoint.name} | ${receptionPoint.address}',
                          style: CustomStylesTheme.regular14_20.copyWith(
                            color: CustomStylesTheme.blackColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Horarios: ${receptionPoint.extraInfo}',
                      style: CustomStylesTheme.regular14_20.copyWith(
                        color: CustomStylesTheme.blackColor,
                      ),
                    ),
                  ],
                ),
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
      ReceptionPointListModel();
}
