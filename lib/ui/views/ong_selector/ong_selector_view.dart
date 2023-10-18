import 'package:flutter/material.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:microdonations/ui/widgets/common/custom_appbar/custom_appbar.dart';
import 'package:microdonations/ui/widgets/common/custom_scaffold/custom_scaffold.dart';
import 'package:microdonations/ui/widgets/common/ong_selector_card/ong_selector_card.dart';
import 'package:microdonations/ui/widgets/common/wrapper_http_loading/wrapper_http_loading.dart';
import 'package:stacked/stacked.dart';

import 'ong_selector_viewmodel.dart';

class OngSelectorView extends StackedView<OngSelectorViewModel> {
  const OngSelectorView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    OngSelectorViewModel viewModel,
    Widget? child,
  ) {
    return CustomScaffold(
      appbar: const CustomAppbar(
        title: 'Seleccioná una ONG',
        showActions: false,
      ),
      body: WrapperHttpLoading(
        showError: viewModel.haveError,
        showLoading: viewModel.isLoading,
        retryFunction: viewModel.getOngs,
        mainContent: !viewModel.isLoading
            ? Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 19.0),
                    child: Text(
                      '¿A que ONG te gustaria hacer tu donación?',
                      style: AppTheme.regular14_16,
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(bottom: 100),
                      child: Column(
                        children: [
                          ...viewModel.ongs
                              .map(
                                (e) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12.0),
                                  child: OngSelectorCard(ongModel: e),
                                ),
                              )
                              .toList()
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : const SizedBox(),
      ),
    );
  }

  @override
  void onViewModelReady(OngSelectorViewModel viewModel) {
    viewModel.getOngs();
    super.onViewModelReady(viewModel);
  }

  @override
  OngSelectorViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      OngSelectorViewModel();
}
