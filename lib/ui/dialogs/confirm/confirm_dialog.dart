import 'package:flutter/material.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:microdonations/ui/widgets/common/custom_fill_button/custom_fill_button.dart';
import 'package:microdonations/ui/widgets/common/custom_outline_button/custom_outline_button.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'confirm_dialog_model.dart';

const double _graphicSize = 60;

class ConfirmDialog extends StackedView<ConfirmDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const ConfirmDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ConfirmDialogModel viewModel,
    Widget? child,
  ) {
    return Dialog(
      shadowColor: Colors.white,
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        request.title ?? 'No title found!',
                        style: AppTheme.bold20_24.copyWith(
                          color: AppTheme.blackColor,
                        ),
                      ),
                      if (request.description != null) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Text(
                            request.description!,
                            style: AppTheme.regular14_16.copyWith(
                              color: AppTheme.blackColor,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 120,
                  child: CustomFillButton(
                    label: request.secondaryButtonTitle ??
                        'MainButtonTitle not found!',
                    textStyle: AppTheme.regular16_14.copyWith(
                      color: Colors.white,
                    ),
                    backgroundColor: AppTheme.tertiaryColor,
                    action: () => completer(DialogResponse(confirmed: false)),
                  ),
                ),
                const Spacer(),
                CustomOutlineButton(
                  label:
                      request.mainButtonTitle ?? 'MainButtonTitle not found!',
                  mainColor: AppTheme.errorColor,
                  textStyle: AppTheme.regular16_14.copyWith(
                    color: AppTheme.errorColor,
                  ),
                  action: () => completer(DialogResponse(confirmed: true)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  ConfirmDialogModel viewModelBuilder(BuildContext context) =>
      ConfirmDialogModel();
}
