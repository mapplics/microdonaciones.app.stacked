import 'package:flutter/material.dart';
import 'package:microdonations/ui/widgets/common/custom_appbar/custom_appbar.dart';
import 'package:microdonations/ui/widgets/common/custom_scaffold/custom_scaffold.dart';
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
    return const CustomScaffold(
      appbar: CustomAppbar(
        title: 'Historial de donaciones',
        showActions: false,
      ),
      body: SingleChildScrollView(
        child: ListTile(),
      ),
    );
  }

  @override
  DonationHistoryViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      DonationHistoryViewModel();
}
