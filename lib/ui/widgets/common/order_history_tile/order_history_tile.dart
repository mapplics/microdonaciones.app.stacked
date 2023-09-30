import 'package:flutter/material.dart';
import 'package:microdonations/core/abstracts/base_history_order.abstract.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:microdonations/ui/common/helpers/datetime.helpers.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stacked/stacked.dart';

import 'order_history_tile_model.dart';

class OrderHistoryTile extends StackedView<OrderHistoryTileModel> {
  final BaseHistoryOrder orderHistory;

  const OrderHistoryTile({required this.orderHistory, super.key});

  @override
  Widget builder(
    BuildContext context,
    OrderHistoryTileModel viewModel,
    Widget? child,
  ) {
    return Container(
      decoration: const BoxDecoration(
        color: CustomStylesTheme.gray400,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(5),
          decoration: const BoxDecoration(
            color: CustomStylesTheme.secondaryColor,
            borderRadius: BorderRadius.all(Radius.circular(80)),
          ),
          child: Icon(
            viewModel.isDeliveryOrder(orderHistory)
                ? PhosphorIcons.light.mapPinLine
                : PhosphorIcons.light.houseLine,
            color: CustomStylesTheme.backgroundColor,
            size: CustomStylesTheme.iconSizeLg,
          ),
        ),
        title: Text(
          'Donación del ${DateTimeHelper.formatDateTime(orderHistory.createAt)}',
          style: CustomStylesTheme.bold16_24,
        ),
        subtitle: Text(
          orderHistory.orderState.name,
          style: CustomStylesTheme.regular14_16,
        ),
        trailing: Icon(
          PhosphorIcons.light.caretRight,
        ),
        onTap: () {
          viewModel.showOrderDetail(orderHistory);
        },
      ),
    );
  }

  @override
  OrderHistoryTileModel viewModelBuilder(
    BuildContext context,
  ) =>
      OrderHistoryTileModel();
}
