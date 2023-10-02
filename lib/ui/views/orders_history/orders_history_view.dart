import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:microdonations/core/abstracts/base_history_order.abstract.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:microdonations/ui/widgets/common/custom_appbar/custom_appbar.dart';
import 'package:microdonations/ui/widgets/common/custom_scaffold/custom_scaffold.dart';
import 'package:microdonations/ui/widgets/empty_states/empty_state/empty_state.dart';
import 'package:microdonations/ui/widgets/empty_states/empty_state_with_button/empty_state_with_button.dart';
import 'package:microdonations/ui/widgets/order_history/order_history_tile/order_history_tile.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stacked/stacked.dart';

import 'orders_history_viewmodel.dart';

class OrdersHistoryView extends StackedView<OrdersHistoryViewModel> {
  const OrdersHistoryView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    OrdersHistoryViewModel viewModel,
    Widget? child,
  ) {
    return CustomScaffold(
      appbar: const CustomAppbar(
        title: 'Historial de donaciones',
        showActions: false,
      ),
      body: RefreshIndicator(
        backgroundColor: CustomStylesTheme.gray400,
        onRefresh: viewModel.refresHistoy,
        child: PagedListView<int, BaseHistoryOrder>(
          pagingController: viewModel.pagingController,
          padding: const EdgeInsets.only(bottom: 50),
          builderDelegate: PagedChildBuilderDelegate<BaseHistoryOrder>(
            itemBuilder: (_, item, __) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: OrderHistoryTile(orderHistory: item),
            ),
            noItemsFoundIndicatorBuilder: (_) => EmptyState(
              title: 'No hay donaciones para mostrar',
              body:
                  'Cuando hayas realizado alguna donación te las mostraremos aqui.',
              icon: PhosphorIcons.light.question,
              colorIcon: CustomStylesTheme.warningColor,
            ),
            firstPageErrorIndicatorBuilder: (_) => EmptyStateWithButton(
              title: 'Tuvimos un problema para mostrar tus donaciones',
              body: 'Por favor, volve a intentarlo mas tarde.',
              icon: PhosphorIcons.light.xCircle,
              colorIcon: CustomStylesTheme.errorColor,
              textButton: 'Volver a intentar',
              buttonAction: viewModel.refresHistoy,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void onViewModelReady(OrdersHistoryViewModel viewModel) {
    viewModel.init();
    super.onViewModelReady(viewModel);
  }

  @override
  OrdersHistoryViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      OrdersHistoryViewModel();
}