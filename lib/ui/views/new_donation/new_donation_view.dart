import 'package:flutter/material.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:microdonations/ui/common/helpers/focus.helpers.dart';
import 'package:microdonations/ui/widgets/common/custom_appbar/custom_appbar.dart';
import 'package:microdonations/ui/widgets/common/custom_scaffold/custom_scaffold.dart';
import 'package:microdonations/ui/widgets/common/dot_indicator/dot_indicator_model.dart';
import 'package:microdonations/ui/widgets/common/link_button/link_button.dart';
import 'package:microdonations/ui/widgets/new_donation/new_donation_detail/new_donation_detail.dart';
import 'package:microdonations/ui/widgets/new_donation/new_donation_item_quantity/new_donation_item_quantity.dart';
import 'package:microdonations/ui/widgets/new_donation/new_donation_items_selector/new_donation_items_selector.dart';
import 'package:microdonations/ui/widgets/new_donation/new_donation_shipping_method/new_donation_shipping_method.dart';
import 'package:microdonations/ui/widgets/common/page_indicator/page_indicator.dart';
import 'package:microdonations/ui/widgets/common/wrapper_http_loading/wrapper_http_loading.dart';
import 'package:stacked/stacked.dart';

import 'new_donation_viewmodel.dart';

class NewDonationView extends StackedView<NewDonationViewModel> {
  const NewDonationView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    NewDonationViewModel viewModel,
    Widget? child,
  ) {
    return WillPopScope(
      onWillPop: viewModel.onBackBtnAppbar,
      child: GestureDetector(
        onTap: () => FocusHelper.closeKeyboard(),
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
                    NewDonationItemsSelector(),
                    NewDonationItemQuantity(),
                    NewDonationShippingMethod(),
                    NewDonationSummary(),
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: viewModel.canShowGoBackBtn
                                    ? LinkButton(
                                        label: 'Atras',
                                        action: viewModel.previousPage,
                                        textStyle: CustomStylesTheme
                                            .regular16_20
                                            .copyWith(
                                          color:
                                              CustomStylesTheme.lightGreyColor,
                                        ),
                                      )
                                    : const SizedBox(),
                              ),
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: PageIndicator(
                                  totalSlides: viewModel.numPages,
                                  currentSlide: viewModel.currentSlide,
                                  dotIndicatorSize: DotIndicatorSize.small,
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: viewModel.isLastSlide
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
                              ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     Padding(
                              //       padding: const EdgeInsets.symmetric(
                              //           horizontal: 26.0),
                              //       child: PageIndicator(
                              //         totalSlides: viewModel.numPages,
                              //         currentSlide: viewModel.currentSlide,
                              //         dotIndicatorSize: DotIndicatorSize.small,
                              //       ),
                              //     ),
                              //     viewModel.isLastSlide
                              //         ? LinkButton(
                              //             label: 'Finalizar',
                              //             action: () =>
                              //                 viewModel.createDonation(context),
                              //             textStyle: CustomStylesTheme.bold16_20
                              //                 .copyWith(
                              //               color:
                              //                   CustomStylesTheme.tertiaryColor,
                              //             ),
                              //           )
                              //         : LinkButton(
                              //             label: 'Siguiente',
                              //             action: () =>
                              //                 viewModel.nextPage(context),
                              //             textStyle: CustomStylesTheme.bold16_20
                              //                 .copyWith(
                              //               color:
                              //                   CustomStylesTheme.tertiaryColor,
                              //             ),
                              //           ),
                              //   ],
                              // ),
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
      ),
    );
  }

  @override
  void onViewModelReady(NewDonationViewModel viewModel) {
    viewModel.initNewDonation();
    super.onViewModelReady(viewModel);
  }

  @override
  void onDispose(NewDonationViewModel viewModel) {
    viewModel.disposeService();
    super.onDispose(viewModel);
  }

  @override
  NewDonationViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      NewDonationViewModel();
}
