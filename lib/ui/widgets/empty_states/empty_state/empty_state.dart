import 'package:flutter/material.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:stacked/stacked.dart';

import 'empty_state_model.dart';

class EmptyState extends StackedView<EmptyStateModel> {
  final String title;
  final String body;
  final IconData icon;
  final Color colorIcon;

  const EmptyState({
    Key? key,
    required this.title,
    required this.body,
    required this.icon,
    required this.colorIcon,
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
            decoration: BoxDecoration(
              color: AppTheme.tertiaryColor,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Icon(
                icon,
                color: colorIcon,
                size: 45.0,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: AppTheme.bold20_24.copyWith(
              color: AppTheme.blackColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            body,
            textAlign: TextAlign.center,
            style: AppTheme.regular16_24.copyWith(
              color: AppTheme.lightGreyColor,
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
