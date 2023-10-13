import 'package:flutter/material.dart';
import 'package:microdonations/core/models/base_user.abstract.dart';
import 'package:stacked/stacked.dart';

import '../../../common/app_theme.dart';
import 'user_avatar_model.dart';

enum UserAvatarSize { small, bigger }

class UserAvatar extends StackedView<UserAvatarModel> {
  final bool canUploadImg;
  final BaseUser user;
  final UserAvatarSize size;

  const UserAvatar({
    required this.user,
    this.canUploadImg = false,
    this.size = UserAvatarSize.small,
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
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: CustomStylesTheme.blackColor,
            boxShadow: [
              BoxShadow(
                color: CustomStylesTheme.blackColor.withOpacity(0.3),
                blurRadius: 10,
              )
            ],
          ),
          child: CircleAvatar(
            backgroundColor: CustomStylesTheme.primaryColor,
            radius: viewModel.getRadius,
            child: Text(
              user.getInitials,
              style: viewModel.initialsTextStyle,
            ),
          ),
        ),
        // if (canUploadImg)
        //   Positioned(
        //     bottom: -10,
        //     right: 0,
        //     child: CircleAvatar(
        //       backgroundColor: CustomStylesTheme.gray100,
        //       child: IconButton(
        //         onPressed: () {},
        //         color: CustomStylesTheme.gray200,
        //         icon: Icon(
        //           PhosphorIcons.bold.camera,
        //         ),
        //       ),
        //     ),
        //   )
      ],
    );
  }

  @override
  UserAvatarModel viewModelBuilder(
    BuildContext context,
  ) =>
      UserAvatarModel(size);
}
