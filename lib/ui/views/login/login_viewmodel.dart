import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:microdonations/app/app.locator.dart';
import 'package:microdonations/app/app.router.dart';
import 'package:microdonations/core/constants/constant_data.dart';
import 'package:microdonations/core/models/user/firebase_user.model.dart';
import 'package:microdonations/core/models/user/social_login_response.model.dart';
import 'package:microdonations/core/parameters/create_account_view.parameters.model.dart';
import 'package:microdonations/core/parameters/login_view.parameters.model.dart';
import 'package:microdonations/services/auth_service.dart';
import 'package:microdonations/ui/common/helpers/messege.helper.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

class LoginViewModel extends BaseViewModel {
  final _authService = locator<AuthService>;
  final _navigationService = locator<NavigationService>();
  final LoginViewParameters viewParameters;
  final _secureStorage = const FlutterSecureStorage();

  LoginViewModel({required this.viewParameters});

  /// Inicia el flujo de iniciar sesion con Google.
  /// Abre el popUp para que el usuario eliga una cuenta
  /// de la cual iniciar sesion.
  Future<void> useGoogleAuthentication(BuildContext context) async {
    try {
      context.loaderOverlay.show();
      final result = await FirebaseAuthenticationService().signInWithGoogle();
      await _handleAuthenticationResponse(result);
    } catch (e) {
      MessegeHelper.showErrorSnackBar(
        context,
        'No se pudimos iniciar sesión con tu cuenta. Por favor, volve a intentarlo.',
      );
    } finally {
      context.loaderOverlay.hide();
    }
  }

  /// Recibe un [FirebaseAuthenticationResult] y si la respuesta fue exitosa
  /// navega al home y se guarda la sesion del usuario. Sino no hace nada.
  Future<void> _handleAuthenticationResponse(
      FirebaseAuthenticationResult authResult) async {
    /// Recupero mi social login token.
    final _firebaseToken = await authResult.user!.getIdToken();

    /// Hago login contra API.
    final _socialLoginResp = await _authService.call().login(
          authResult.user!.email!,
          _firebaseToken!,
        );

    /// Si el customer es null entonces tengo que hacerlo crear un cuenta.
    if (_socialLoginResp.customerIsNull) {
      _navigationService
          .navigateToCreateAccountView(
            viewParameters: CreateAccountViewParameters(
                FirebaseUser.createOne(authResult.user!)),
          )
          .then((_) {
            login();
            _onBackCreateAccount(_socialLoginResp);
          } );
    } else {
      login();
      /// Navego a la pagina de home.
      _finishLogin(_socialLoginResp);
      _goBackHandled();
    }
  }

  /// Resuelve a que pagina se debe navegar despues de terminar el login
  _goBackHandled() {
    if (viewParameters.returnedView != null) {
      _navigationService.back();
      _navigationService.navigateToView(viewParameters.returnedView!);
    } else if (viewParameters.popUntilFirst) {
      _navigationService.popUntil((route) => route.isFirst);
    } else if (viewParameters.popWhenFinish) {
      _navigationService.back();
    } else {
      /// caso por default
      _navigationService.back();
    }
  }

  /// Funcion que se ejecuta al volver de la pantalla de crear cuenta.
  /// Valida si el usuario creo su cuenta y termina de loguearlo.
  void _onBackCreateAccount(SocialLoginResponse socialLoginResp) {
    if (!_authService.call().isUserLogged) {
      /// El usuario cancelo la creacion de su cuenta.
      /// Limpio cualquier dato basura.
      _authService.call().clearAuth();
    } else {
      _finishLogin(socialLoginResp);
    }
  }

  /// Termina de loguear al usuario.
  void _finishLogin(SocialLoginResponse socialLoginResp) {
    /// Guardo mi token.
    _authService.call().setAuthModel(socialLoginResp.token);

    /// Seteo el usuario logueado en el servicio.
    _authService.call().setLoggedUser = socialLoginResp.customer!;
  }

  /// Inicia el flujo de iniciar sesion con Apple.
  /// Abre el popUp para que el usuario eliga una cuenta
  /// de la cual iniciar sesion.
  Future<void> useAppleAuthentication(BuildContext context) async {
    try {
      final result = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      context.loaderOverlay.show();
      await _handleAppleAuthenticationResponse(result);
    } catch (e) {
      MessegeHelper.showErrorSnackBar(
        context,
        'No se pudimos iniciar sesión con tu cuenta. Por favor, volve a intentarlo.',
      );
    } finally {
      context.loaderOverlay.hide();
    }
  }

  /// si la respuesta fue exitosa
  /// navega al home y se guarda la sesion del usuario. Sino no hace nada.
  Future<void> _handleAppleAuthenticationResponse(
      AuthorizationCredentialAppleID credential) async {
    final oAuthProvider = OAuthProvider('apple.com');
    final credential1 = oAuthProvider.credential(
      idToken: credential.identityToken!,
      accessToken: credential.authorizationCode,
    );
    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential1);

    final _firebaseToken = await userCredential.user!.getIdToken();

    /// Hago login contra API.
    final _socialLoginResp = await _authService.call().login(
          userCredential.user!.email!,
          _firebaseToken!,
        );

    /// Si el customer es null entonces tengo que hacerlo crear un cuenta.
    if (_socialLoginResp.customerIsNull) {
      _navigationService
          .navigateToCreateAccountView(
            viewParameters: CreateAccountViewParameters(
                FirebaseUser.createOne(userCredential.user!)),
          )
          .then((_) {
            login();
            _onBackCreateAccount(_socialLoginResp);
          });
    } else {
      login();
      /// Navego a la pagina de home.
      _finishLogin(_socialLoginResp);

      _goBackHandled();
    }
  }

  bool isApple() {
    return defaultTargetPlatform == TargetPlatform.iOS;
  }

    Future<void> getToken() async {
    FirebaseMessaging.instance.getToken().then((token) async {
      await _secureStorage.write(key: ConstantData.deviceToken, value: token);
    });
  }

  Future<bool?> login() async {
    try {
      var storedToken = await _secureStorage.read(key: ConstantData.deviceToken);
      if (storedToken == null) {
        var token = await FirebaseMessaging.instance.getToken();
        await _secureStorage.write(key: ConstantData.deviceToken, value: token);
      } 
    } catch (e) {
      rethrow;
    }

    return false;
  }
}
