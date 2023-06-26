import 'package:microdonations/app/app.locator.dart';
import 'package:microdonations/app/app.router.dart';
import 'package:microdonations/core/services/auth_service.dart';
import 'package:microdonations/ui/common/helpers/logger.helpers.dart';
import 'package:microdonations/ui/common/helpers/storage.helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  final _firebaseAuthenticationService = locator<FirebaseAuthenticationService>;
  final _authService = locator<AuthService>;
  final _navigationService = locator<NavigationService>();

  /// Inicia el flujo de iniciar sesion con Google.
  /// Abre el popUp para que el usuario eliga una cuenta
  /// de la cual iniciar sesion.
  Future<void> useGoogleAuthentication() async {
    final result =
        await _firebaseAuthenticationService.call().signInWithGoogle();
    _handleAuthenticationResponse(result);
  }

  /// Recibe un [FirebaseAuthenticationResult] y si la respuesta fue exitosa
  /// navega al home y se guarda la sesion del usuario. Sino no hace nada.
  Future<void> _handleAuthenticationResponse(
      FirebaseAuthenticationResult authResult) async {
    if (authResult.hasError) {
      logError(
        '<LoginViewModel> Error al hacer el login ${authResult.errorMessage}',
      );
    } else {
      try {
        /// Recupero mi token.
        final _firebaseToken = await authResult.user!.getIdToken();

        /// Seteo mi [AuthModel]
        _authService.call().setAuthModel(_firebaseToken);

        /// Guardo en el storage el inicio de sesion.
        StorageHelper.saveAuthModel(_authService.call().authModel!);

        logInfo('Inicio de sesion exitoso!');

        /// Navego al home.
        _navigationService.replaceWithHomeView();
      } catch (e) {
        logError('Error al iniciar sesion! $e');
      }
    }
  }
}
