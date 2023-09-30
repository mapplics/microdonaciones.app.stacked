import 'package:flutter/material.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:stacked/stacked.dart';

import 'empty_state_model.dart';

class EmptyState extends StackedView<EmptyStateModel> {
  final String title;
  final String body;
  final IconData icon;

  const EmptyState({
    Key? key,
    required this.title,
    required this.body,
    required this.icon,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    EmptyStateModel viewModel,
    Widget? child,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: CustomStylesTheme.tertiaryColor,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Icon(
              icon,
              color: CustomStylesTheme.errorColor,
              size: 70.0,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: CustomStylesTheme.bold20_24.copyWith(
              color: CustomStylesTheme.blackColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            body,
            textAlign: TextAlign.center,
            style: CustomStylesTheme.regular16_24.copyWith(
              color: CustomStylesTheme.lightGreyColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  EmptyStateModel viewModelBuilder(
    BuildContext context,
  ) =>
      EmptyStateModel();
}
