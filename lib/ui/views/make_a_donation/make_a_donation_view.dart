import 'package:flutter/material.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:microdonations/ui/views/select_delivery_method/select_delivery_method_view.dart';
import 'package:microdonations/ui/widgets/common/custom_appbar/custom_appbar.dart';
import 'package:microdonations/ui/widgets/common/custom_scaffold/custom_scaffold.dart';
import 'package:microdonations/ui/widgets/common/donation_item_quantity/donation_item_quantity.dart';
import 'package:microdonations/ui/widgets/common/donation_items_selector/donation_items_selector.dart';
import 'package:microdonations/ui/widgets/common/dot_indicator/dot_indicator_model.dart';
import 'package:microdonations/ui/widgets/common/link_button/link_button.dart';
import 'package:microdonations/ui/widgets/common/new_donation_detail/new_donation_detail.dart';
import 'package:microdonations/ui/widgets/common/page_indicator/page_indicator.dart';
import 'package:microdonations/ui/widgets/common/wrapper_http_loading/wrapper_http_loading.dart';
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
        appbar: const CustomAppbar(
          title: 'Que necesitamos?',
          showActions: false,
        ),
        body: WrapperHttpLoading(
          showLoading: viewModel.isLoading,
          showError: viewModel.haveError,
          retryFunction: viewModel.initNewDonation,
          mainContent: Stack(
            children: [
              PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: viewModel.pageController,
                onPageChanged: viewModel.onPageChange,
                children: const [
                  DonationItemsSelector(),
                  DonationItemQuantity(),
                  SelectDeliveryMethodView(),
                  NewDonationDetail(),
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
                      Container(
                        decoration: const BoxDecoration(
                          color: CustomStylesTheme.gray400,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Row(
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 26.0),
                                  child: PageIndicator(
                                    totalSlides: viewModel.numPages,
                                    currentSlide: viewModel.currentSlide,
                                    dotIndicatorSize: DotIndicatorSize.small,
                                  ),
                                ),
                                viewModel.isLastSlide
                                    ? LinkButton(
                                        label: 'Finalizar',
                                        action: () =>
                                            viewModel.createDonation(context),
                                        textStyle: CustomStylesTheme.bold16_20
                                            .copyWith(
                                          color:
                                              CustomStylesTheme.tertiaryColor,
                                        ),
                                      )
                                    : LinkButton(
                                        label: 'Siguiente',
                                        action: () =>
                                            viewModel.nextPage(context),
                                        textStyle: CustomStylesTheme.bold16_20
                                            .copyWith(
                                          color:
                                              CustomStylesTheme.tertiaryColor,
                                        ),
                                      ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onViewModelReady(MakeADonationViewModel viewModel) {
    viewModel.initNewDonation();
    super.onViewModelReady(viewModel);
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
