import 'package:flutter/material.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:microdonations/ui/widgets/common/custom_appbar/custom_appbar.dart';
import 'package:microdonations/ui/widgets/common/custom_fill_button/custom_fill_button.dart';
import 'package:microdonations/ui/widgets/common/custom_scaffold/custom_scaffold.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stacked/stacked.dart';

import 'new_donation_confirmed_viewmodel.dart';

class NewDonationConfirmedView
    extends StackedView<NewDonationConfirmedViewModel> {
  const NewDonationConfirmedView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    NewDonationConfirmedViewModel viewModel,
    Widget? child,
  ) {
    return CustomScaffold(
      appbar: const CustomAppbar(
        title: 'Confirmación',
        showActions: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: Text(
              '¡Listo!',
              style: AppTheme.bold16_20.copyWith(
                color: AppTheme.tertiaryColor,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 8.0, bottom: 27),
            child: Text(
              'Ya cargaste tu donación',
              style: AppTheme.regular14_16,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 45.0),
            child: Icon(
              PhosphorIcons.checkCircleBold,
              color: AppTheme.tertiaryColor,
              size: 140,
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: CustomFillButton(
              label: 'Ir al inicio',
              action: viewModel.goHome,
              backgroundColor: AppTheme.tertiaryColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  NewDonationConfirmedViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      NewDonationConfirmedViewModel();
}
