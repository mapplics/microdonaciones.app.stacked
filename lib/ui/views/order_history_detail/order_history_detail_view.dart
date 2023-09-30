import 'package:flutter/material.dart';
import 'package:microdonations/core/abstracts/base_history_order.abstract.dart';
import 'package:microdonations/core/models/pickup_weekday_range.model.dart';
import 'package:microdonations/core/models/pickup_weekday_range_presentation.model.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:microdonations/ui/widgets/common/custom_appbar/custom_appbar.dart';
import 'package:microdonations/ui/widgets/common/custom_scaffold/custom_scaffold.dart';
import 'package:microdonations/ui/widgets/common/donation_item_list_detail/donation_item_list_detail.dart';
import 'package:microdonations/ui/widgets/common/donation_shipping_detail/donation_shipping_detail.dart';
import 'package:stacked/stacked.dart';

import 'order_history_detail_viewmodel.dart';

class OrderHistoryDetailParameters {
  final BaseHistoryOrder historyOrder;
  OrderHistoryDetailParameters(this.historyOrder);
}

class OrderHistoryDetailView extends StackedView<OrderHistoryDetailViewModel> {
  final OrderHistoryDetailParameters viewParameters;

  const OrderHistoryDetailView({required this.viewParameters, Key? key})
      : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    OrderHistoryDetailViewModel viewModel,
    Widget? child,
  ) {
    return CustomScaffold(
      appbar: const CustomAppbar(
        title: 'Detalle de Donación',
        showActions: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 28.0),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'Ingresaste la siguiente donación',
                style: CustomStylesTheme.regular14_20,
              ),
            ),
          ),
          RichText(
            text: TextSpan(children: [
              TextSpan(
                text: 'Estado: ',
                style: CustomStylesTheme.bold16_20.copyWith(
                  color: CustomStylesTheme.blackColor,
                ),
              ),
              TextSpan(
                text: viewModel.order.orderState.name,
                style: CustomStylesTheme.regular15_16.copyWith(
                  color: viewModel.order.orderState.getStatusColor,
                ),
              )
            ]),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 28.0),
            child: DonationItemListDetail(
              donationItems: viewModel.order.products,
            ),
          ),
          DonationShippingDetail(
            receptionPoint: viewModel.deliveryOrder?.receptionPoint,
            type: viewModel.order.shippingMethod,
            userAddress: viewModel.pickupDonation?.address,
            range: viewModel.pickupDonation != null
                ? PickupWeekDayRangePresentation.createOne(
                    PickupWeekDayRange(
                      weekday: viewModel.pickupDonation!.weekday,
                      ranges: [viewModel.pickupDonation!.range],
                    ),
                    viewModel.pickupDonation!.range,
                  )
                : null,
          ),
        ],
      ),
    );
  }

  @override
  OrderHistoryDetailViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      OrderHistoryDetailViewModel(viewParameters.historyOrder);
}
