import 'package:flutter/material.dart';
import 'package:microdonations/ui/widgets/common/custom_appbar/custom_appbar.dart';
import 'package:microdonations/ui/widgets/common/custom_scaffold/custom_scaffold.dart';
import 'package:microdonations/ui/widgets/common/order_history_tile/order_history_tile.dart';
import 'package:microdonations/ui/widgets/common/wrapper_http_loading/wrapper_http_loading.dart';
import 'package:stacked/stacked.dart';

import 'donation_history_viewmodel.dart';

class DonationHistoryView extends StackedView<DonationHistoryViewModel> {
  const DonationHistoryView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    DonationHistoryViewModel viewModel,
    Widget? child,
  ) {
    return CustomScaffold(
      appbar: const CustomAppbar(
        title: 'Historial de donaciones',
        showActions: false,
      ),
      body: WrapperHttpLoading(
        showLoading: viewModel.isLoading,
        showError: viewModel.haveError,
        retryFunction: viewModel.getHistory,
        mainContent: ListView.builder(
          itemCount: viewModel.ordersHistory.length,
          itemBuilder: (ctx, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child:
                OrderHistoryTile(orderHistory: viewModel.ordersHistory[index]),
          ),
        ),
      ),
    );
  }

  @override
  void onViewModelReady(DonationHistoryViewModel viewModel) {
    viewModel.getHistory();
    super.onViewModelReady(viewModel);
  }

  @override
  DonationHistoryViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      DonationHistoryViewModel();
}
