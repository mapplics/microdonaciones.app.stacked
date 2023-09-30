import 'package:flutter/material.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:microdonations/ui/common/helpers/datetime.helpers.dart';
import 'package:microdonations/ui/widgets/common/custom_appbar/custom_appbar.dart';
import 'package:microdonations/ui/widgets/common/custom_scaffold/custom_scaffold.dart';
import 'package:microdonations/ui/widgets/common/wrapper_http_loading/wrapper_http_loading.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
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
          itemBuilder: (ctx, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
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
                    viewModel.isDeliveryOrder(viewModel.ordersHistory[index])
                        ? PhosphorIcons.light.mapPinLine
                        : PhosphorIcons.light.houseLine,
                    color: CustomStylesTheme.backgroundColor,
                    size: CustomStylesTheme.iconSizeLg,
                  ),
                ),
                title: Text(
                  'Donación del ${DateTimeHelper.formatDateTime(viewModel.ordersHistory[index].createAt)}',
                  style: CustomStylesTheme.bold16_24,
                ),
                subtitle: Text(
                  viewModel.ordersHistory[index].orderState.name,
                  style: CustomStylesTheme.regular14_16,
                ),
                trailing: Icon(
                  PhosphorIcons.light.caretRight,
                ),
                onTap: () {
                  viewModel.showOrderDetail(viewModel.ordersHistory[index]);
                },
              ),
            ),
          ),
          itemCount: viewModel.ordersHistory.length,
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
