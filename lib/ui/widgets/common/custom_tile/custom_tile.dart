import 'package:flutter/material.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stacked/stacked.dart';

import 'custom_tile_model.dart';

class CustomTile extends StackedView<CustomTileModel> {
  final Function action;
  final String label;
  final IconData svgPath;

  const CustomTile({
    required this.action,
    required this.label,
    required this.svgPath,
    super.key,
  });

  @override
  Widget builder(
    BuildContext context,
    CustomTileModel viewModel,
    Widget? child,
  ) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(6),
        decoration: const BoxDecoration(
          color: AppTheme.tertiaryColor,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Icon(
          svgPath,
          color: Colors.white,
        ),
      ),
      title: Text(
        label,
        style: AppTheme.regular14_20,
      ),
      trailing: const Icon(
        PhosphorIcons.caretRightLight,
        color: AppTheme.blackColor,
      ),
      onTap: () => action(),
    );
  }

  @override
  CustomTileModel viewModelBuilder(
    BuildContext context,
  ) =>
      CustomTileModel();
}
