import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'test_alert_sheet_model.dart';

class TestAlertSheet extends StackedView<TestAlertSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const TestAlertSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    TestAlertSheetModel viewModel,
    Widget? child,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            request.title ?? 'Hello Stacked Sheet!!',
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
          ),
          if (request.description != null) ...[
            Text(
              request.description!,
              style: const TextStyle(fontSize: 14),
              maxLines: 3,
              softWrap: true,
            ),
          ],
        ],
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
    );
  }

  @override
  TestAlertSheetModel viewModelBuilder(BuildContext context) =>
      TestAlertSheetModel();
}
