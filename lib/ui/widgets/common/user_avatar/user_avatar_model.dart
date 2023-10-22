import 'package:flutter/material.dart';
import 'package:microdonations/app/app.locator.dart';
import 'package:microdonations/services/auth_service.dart';
import 'package:microdonations/services/user_service.dart';
import 'package:microdonations/ui/common/app_theme.dart';
import 'package:microdonations/ui/widgets/common/user_avatar/user_avatar.dart';
import 'package:stacked/stacked.dart';

class UserAvatarModel extends ReactiveViewModel {
  final _authService = locator<AuthService>();
  final _userService = locator<UserService>();

  final UserAvatarSize size;

  UserAvatarModel(this.size);

  @override
  List<ListenableServiceMixin> get listenableServices => [
        _authService,
        _userService,
      ];

  /// Devuelve el radius que debe tener el avatar segun el [UserAvatarSize]
  double get getRadius => (UserAvatarSize.small == size) ? 21 : 61;

  /// Devuelve el TextStyle que debe tener las iniciales del usuario
  /// segun el [UserAvatarSize]
  TextStyle get initialsTextStyle => (UserAvatarSize.small == size)
      ? AppTheme.bold14_20.copyWith(
          color: Colors.white,
        )
      : AppTheme.bold34_44.copyWith(
          color: Colors.white,
        );
}
