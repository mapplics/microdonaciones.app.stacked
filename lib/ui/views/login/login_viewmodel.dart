import 'package:microdonations/app/app.locator.dart';
import 'package:microdonations/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  final _firebaseAuthenticationService = locator<FirebaseAuthenticationService>;
  final _navigationService = locator<NavigationService>();

  Future<void> useGoogleAuthentication() async {
    final result =
        await _firebaseAuthenticationService.call().signInWithGoogle();
    _handleAuthenticationResponse(result);
  }

  void _handleAuthenticationResponse(FirebaseAuthenticationResult authResult) {
    if (authResult.hasError) {
      print('error al loguearme');
    } else {
      _navigationService.replaceWithHomeView();
    }
  }
}
