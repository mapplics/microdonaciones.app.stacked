import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stacked/stacked.dart';

import 'custom_tile_model.dart';

class CustomTile extends StackedView<CustomTileModel> {
  final Function action;
  final String label;
  final String svgPath;

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
      leading: SizedBox(
        height: 37,
        width: 37,
        child: SvgPicture.asset(svgPath),
      ),
      title: Text(
        label,
        style: CustomStylesTheme.regular14_20,
      ),
      trailing: const Icon(
        PhosphorIcons.caretRightLight,
        color: CustomStylesTheme.blackColor,
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
