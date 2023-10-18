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
        color: AppTheme.gray400,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(5),
          decoration: const BoxDecoration(
            color: AppTheme.secondaryColor,
            borderRadius: BorderRadius.all(Radius.circular(80)),
          ),
          child: Icon(
            viewModel.isDeliveryOrder(orderHistory)
                ? PhosphorIcons.mapPinLineLight
                : PhosphorIcons.houseLineLight,
            color: AppTheme.backgroundColor,
            size: AppTheme.iconSizeLg,
          ),
        ),
        title: Text(
          'Donación del ${DateTimeHelper.formatDateTime(orderHistory.createAt)}',
          style: AppTheme.bold16_24,
        ),
        subtitle: Text(
          orderHistory.orderState.name,
          style: AppTheme.regular14_16,
        ),
        trailing: const Icon(
          PhosphorIcons.caretRightLight,
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
