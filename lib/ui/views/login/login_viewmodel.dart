import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:microdonations/app/app.locator.dart';
import 'package:microdonations/app/app.router.dart';
import 'package:microdonations/core/constants/constant_data.dart';
import 'package:microdonations/core/models/user/firebase_user.model.dart';
import 'package:microdonations/core/models/user/social_login_response.model.dart';
import 'package:microdonations/core/parameters/create_account_view.parameters.model.dart';
import 'package:microdonations/core/parameters/login_view.parameters.model.dart';
import 'package:microdonations/services/auth_service.dart';
import 'package:microdonations/ui/common/helpers/messege.helper.dart';

class LoginViewModel extends BaseViewModel {
  final _authService = locator<AuthService>();
  final _navigationService = locator<NavigationService>();
  final LoginViewParameters viewParameters;
  final _secureStorage = const FlutterSecureStorage();

  LoginViewModel({required this.viewParameters});

  Future<void> useGoogleAuthentication(BuildContext context) async {
    await _authenticateWithProvider(
        context, FirebaseAuthenticationService().signInWithGoogle());
  }

  Future<void> useAppleAuthentication(BuildContext context) async {
    try {
      final result = await SignInWithApple.getAppleIDCredential(scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ]);
      context.loaderOverlay.show();
      final oAuthProvider = OAuthProvider('apple.com');
      final credential = oAuthProvider.credential(
        idToken: result.identityToken!,
        accessToken: result.authorizationCode,
      );
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      context.loaderOverlay.hide();
      await _handleAuthenticationResponse(userCredential);
    } catch (e) {
      _showError(context);
    }
  }

  Future<void> _authenticateWithProvider(BuildContext context,
      Future<FirebaseAuthenticationResult> authProvider) async {
    try {
      context.loaderOverlay.show();
      final result = await authProvider;
      context.loaderOverlay.hide();
      await _handleAuthenticationResponse(result);
    } catch (e) {
      _showError(context);
    }
  }

  Future<void> _handleAuthenticationResponse(dynamic authResult) async {
    final firebaseToken = await authResult.user!.getIdToken();
    final socialLoginResp =
        await _authService.login(authResult.user!.email!, firebaseToken!);

    if (!socialLoginResp.customerIsNull) {
      await _navigationService.navigateToCreateAccountView(
        viewParameters: CreateAccountViewParameters(
          user: FirebaseUser.createOne(authResult.user!),
          onBackRoute: viewParameters.onBackRoute,
        ),
      );
      _onBackCreateAccount(socialLoginResp);
    } else {
      _completeLogin(socialLoginResp);
      _goBackHandled();
    }

    await _deviceTokenLogin();
  }

  void _onBackCreateAccount(SocialLoginResponse socialLoginResp) {
    if (!_authService.isUserLogged) {
      _authService.clearAuth();
    } else {
      _completeLogin(socialLoginResp);
      _goBackHandled();
    }
  }

  void _completeLogin(SocialLoginResponse socialLoginResp) {
    _authService.setAuthModel(socialLoginResp.token);
    _authService.setLoggedUser = socialLoginResp.customer!;
  }

  void _goBackHandled() {
    if (viewParameters.onBackRoute?.isNotEmpty ?? false) {
      _navigationService
          .popUntil(ModalRoute.withName(viewParameters.onBackRoute!));
    } else {
      _navigationService.back();
    }
  }

  Future<void> _deviceTokenLogin() async {
    try {
      String? storedToken =
          await _secureStorage.read(key: ConstantData.deviceToken);
      if (storedToken == null) {
        storedToken = await FirebaseMessaging.instance.getToken();
        await _secureStorage.write(
            key: ConstantData.deviceToken, value: storedToken);
      }
    } catch (e) {
      rethrow;
    }
  }

  void _showError(BuildContext context) {
    MessegeHelper.showErrorSnackBar(
      context,
      'No se pudimos iniciar sesión con tu cuenta. Por favor, volve a intentarlo.',
    );
  }

  bool isApple() {
    return defaultTargetPlatform == TargetPlatform.iOS;
  }
}
