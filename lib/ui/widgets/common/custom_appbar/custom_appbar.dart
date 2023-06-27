import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../common/app_theme.dart';
import 'custom_appbar_model.dart';

class CustomAppbar extends StackedView<CustomAppbarModel>
    implements PreferredSizeWidget {
  final List<Widget>? actions;
  final String title;

  const CustomAppbar({required this.title, this.actions, super.key});

  @override
  Widget builder(
    BuildContext context,
    CustomAppbarModel viewModel,
    Widget? child,
  ) {
    return AppBar(
      title: Text(
        title,
        style: CustomStylesTheme.bold16_24.copyWith(
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      actions: actions,
    );
  }

  @override
  CustomAppbarModel viewModelBuilder(
    BuildContext context,
  ) =>
      CustomAppbarModel();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
