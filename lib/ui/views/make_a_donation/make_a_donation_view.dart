import 'package:flutter/material.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:microdonations/ui/widgets/common/custom_appbar/custom_appbar.dart';
import 'package:microdonations/ui/widgets/common/custom_scaffold/custom_scaffold.dart';
import 'package:microdonations/ui/widgets/common/donation_item_quantity/donation_item_quantity.dart';
import 'package:microdonations/ui/widgets/common/donation_items_selector/donation_items_selector.dart';
import 'package:microdonations/ui/widgets/common/dot_indicator/dot_indicator_model.dart';
import 'package:microdonations/ui/widgets/common/link_button/link_button.dart';
import 'package:microdonations/ui/widgets/common/page_indicator/page_indicator.dart';
import 'package:stacked/stacked.dart';

import 'make_a_donation_viewmodel.dart';

class MakeADonationView extends StackedView<MakeADonationViewModel> {
  const MakeADonationView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    MakeADonationViewModel viewModel,
    Widget? child,
  ) {
    return WillPopScope(
      onWillPop: viewModel.onBackBtnAppbar,
      child: CustomScaffold(
        appbar: const CustomAppbar(title: 'Que necesitamos?'),
        body: Stack(
          children: [
            PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: viewModel.pageController,
              onPageChanged: viewModel.onPageChange,
              children: const [
                DonationItemsSelector(),
                DonationItemQuantity(),
                Text('Nada'),
                Text('Nada'),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height / 24,
              ),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: viewModel.canShowGoBackBtn
                          ? MainAxisAlignment.spaceBetween
                          : MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (viewModel.canShowGoBackBtn)
                          Expanded(
                            child: LinkButton(
                              label: 'Atras',
                              action: viewModel.previousPage,
                              textStyle:
                                  CustomStylesTheme.regular16_20.copyWith(
                                color: CustomStylesTheme.lightGreyColor,
                              ),
                            ),
                          ),
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 26.0),
                              child: PageIndicator(
                                pageSize: viewModel.numPages,
                                currentPage: viewModel.currentPage,
                                dotIndicatorSize: DotIndicatorSize.small,
                              ),
                            ),
                            LinkButton(
                              label: 'Siguiente',
                              action: viewModel.canEnableNextPage()
                                  ? viewModel.nextPage
                                  : null,
                              textStyle: CustomStylesTheme.bold16_20.copyWith(
                                color: CustomStylesTheme.tertiaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void onDispose(MakeADonationViewModel viewModel) {
    viewModel.disposeService();
    super.onDispose(viewModel);
  }

  @override
  MakeADonationViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      MakeADonationViewModel();
}
