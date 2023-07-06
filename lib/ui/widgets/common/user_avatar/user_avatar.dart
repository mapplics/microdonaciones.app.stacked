import 'package:flutter/material.dart';
import 'package:microdonations/core/models/base_user.abstract.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stacked/stacked.dart';

import '../../../common/app_theme.dart';
import 'user_avatar_model.dart';

class UserAvatar extends StackedView<UserAvatarModel> {
  final bool canUploadImg;
  final BaseUser user;

  const UserAvatar({
    required this.user,
    this.canUploadImg = false,
    super.key,
  });

  @override
  Widget builder(
    BuildContext context,
    UserAvatarModel viewModel,
    Widget? child,
  ) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 60),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: CustomStylesTheme.blackColor.withOpacity(0.3),
                  blurRadius: 10,
                )
              ],
              color: CustomStylesTheme.blackColor),
          child: CircleAvatar(
            backgroundColor: CustomStylesTheme.primaryColor,
            radius: 61,
            child: Text(
              user.getInitials(),
              style: CustomStylesTheme.bold34_44.copyWith(color: Colors.white),
            ),
          ),
        ),
        if (canUploadImg)
          Positioned(
            bottom: -10,
            right: 0,
            child: CircleAvatar(
              backgroundColor: CustomStylesTheme.gray100,
              child: IconButton(
                onPressed: () {},
                color: CustomStylesTheme.gray200,
                icon: Icon(
                  PhosphorIcons.bold.camera,
                ),
              ),
            ),
          )
      ],
    );
  }

  @override
  UserAvatarModel viewModelBuilder(
    BuildContext context,
  ) =>
      UserAvatarModel();
}
