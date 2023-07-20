import 'package:flutter/material.dart';
import 'package:microdonations/ui/widgets/common/user_avatar/user_avatar.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stacked/stacked.dart';

import '../../../common/app_theme.dart';
import 'custom_appbar_model.dart';

class CustomAppbar extends StackedView<CustomAppbarModel>
    implements PreferredSizeWidget {
  final List<Widget>? actions;
  final bool showActions;
  final String title;

  const CustomAppbar({
    required this.title,
    this.actions,
    this.showActions = true,
    super.key,
  });

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
      actions: showActions
          ? actions ??
              [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: viewModel.showAvatarWithInitials
                      ? InkWell(
                          onTap: viewModel.navigateToPersonalInformation,
                          child: UserAvatar(
                            user: viewModel.user,
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: CustomStylesTheme.blackColor.withOpacity(
                                  0.1,
                                ),
                                offset: Offset.fromDirection(-150.0),
                                spreadRadius: 0.01,
                                blurRadius: 7,
                              )
                            ],
                          ),
                          child: InkWell(
                            onTap: viewModel.navigateToLogin,
                            child: IconButton.filled(
                              onPressed: null,
                              style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                  CustomStylesTheme.secondaryColor,
                                ),
                              ),
                              icon: Icon(
                                PhosphorIcons.bold.user,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                )
              ]
          : [],
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
