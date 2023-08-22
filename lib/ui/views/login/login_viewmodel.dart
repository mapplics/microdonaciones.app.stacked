import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:microdonations/app/app.locator.dart';
import 'package:microdonations/app/app.router.dart';
import 'package:microdonations/core/models/firebase_user.model.dart';
import 'package:microdonations/core/models/social_login_response.model.dart';
import 'package:microdonations/core/parameters/create_account_view.parameters.model.dart';
import 'package:microdonations/ui/common/helpers/messege.helper.dart';
import 'package:microdonations/ui/views/home/home_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../services/auth_service.dart';
import '../../../services/user_service.dart';

class LoginViewModel extends BaseViewModel {
  final _authService = locator<AuthService>;
  final _userService = locator<UserService>;
  final _navigationService = locator<NavigationService>();

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
          _firebaseToken,
        );

    /// Si es customer es null entonces tengo que hacerlo crear un cuenta.
    if (_socialLoginResp.customerIsNull) {
      _navigationService
          .navigateToCreateAccountView(
            viewParameters: CreateAccountViewParameters(
                FirebaseUser.createOne(authResult.user!)),
          )
          .then((_) => _onBackCreateAccount(_socialLoginResp));
    } else {
      /// Navego a la pagina de home.
      _finishLogin(_socialLoginResp);
      _navigationService.clearStackAndShowView(const HomeView());
    }
  }

  /// Funcion que se ejecuta al volver de la pantalla de crear cuenta.
  /// Valida si el usuario creo su cuenta y termina de loguearlo.
  void _onBackCreateAccount(SocialLoginResponse socialLoginResp) {
    if (_userService.call().haveUser) _finishLogin(socialLoginResp);
  }

  /// Termina de loguear al usuario.
  void _finishLogin(SocialLoginResponse socialLoginResp) {
    /// Guardo mi token.
    _authService.call().setAuthModel(socialLoginResp.token);

    /// Seteo el usuario logueado en el servicio.
    _userService.call().setLoggedUser = socialLoginResp.customer!;
  }
}
