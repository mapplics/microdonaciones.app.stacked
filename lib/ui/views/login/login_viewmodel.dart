import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:microdonations/app/app.locator.dart';
import 'package:microdonations/app/app.router.dart';
import 'package:microdonations/core/models/firebase_user.model.dart';
import 'package:microdonations/core/parameters/create_account_view.parameters.model.dart';
import 'package:microdonations/core/services/auth_service.dart';
import 'package:microdonations/core/services/user_service.dart';
import 'package:microdonations/ui/common/helpers/logger.helpers.dart';
import 'package:microdonations/ui/common/helpers/storage.helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  final _authService = locator<AuthService>;
  final _userService = locator<UserService>;
  final _navigationService = locator<NavigationService>();

  /// Inicia el flujo de iniciar sesion con Google.
  /// Abre el popUp para que el usuario eliga una cuenta
  /// de la cual iniciar sesion.
  Future<void> useGoogleAuthentication(BuildContext context) async {
    context.loaderOverlay.show();
    final result = await FirebaseAuthenticationService().signInWithGoogle();
    await _handleAuthenticationResponse(result);
    context.loaderOverlay.hide();
  }

  /// Recibe un [FirebaseAuthenticationResult] y si la respuesta fue exitosa
  /// navega al home y se guarda la sesion del usuario. Sino no hace nada.
  Future<void> _handleAuthenticationResponse(
      FirebaseAuthenticationResult authResult) async {
    if (authResult.hasError) {
      logError('Social login error ${authResult.errorMessage}');
    } else {
      try {
        /// Recupero mi social login token.
        final _firebaseToken = await authResult.user!.getIdToken();

        /// Hago login contra API.
        final _socialLoginResp = await _authService.call().login(
              authResult.user!.email!,
              _firebaseToken,
            );

        /// Seteo mi AuthModel.
        _authService.call().setAuthModel(_socialLoginResp.token);

        //// Guardo en el storage el inicio de sesion.
        StorageHelper.saveAuthModel(_authService.call().authModel!);

        /// Si es customer es null entonces tengo que navegar el formulario
        if (_socialLoginResp.customerIsNull) {
          _navigationService.navigateToCreateAccountView(
            viewParameters: CreateAccountViewParameters(
              FirebaseUser.createOne(authResult.user!),
            ),
          );
        } else {
          /// Seteo el usuario logueado en el servicio.
          _userService.call().setLoggedUser = _socialLoginResp.customer!;

          /// Navego a la pagina de home.
          _navigationService.navigateToHomeView();
        }
      } catch (e) {
        logError('Error al iniciar sesion! ${e.toString()}');
      }
    }
  }
}
