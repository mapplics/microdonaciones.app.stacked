import 'package:microdonations/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';

class LoginViewModel extends BaseViewModel {
  final _firebaseAuthenticationService = locator<FirebaseAuthenticationService>;

  Future<void> useGoogleAuthentication() async {
    final result =
        await _firebaseAuthenticationService.call().signInWithGoogle();
    _handleAuthenticationResponse(result);
  }

  void _handleAuthenticationResponse(FirebaseAuthenticationResult authResult) {
    if (!authResult.hasError) {
      print('error al loguearme');
    } else {
      print(authResult.user!.email);
      print(authResult.user!.displayName);
      print(authResult.user!.phoneNumber);
      print(authResult.user!.photoURL);
      print(authResult.user!.emailVerified);
      print(authResult.user!.refreshToken);
      print(authResult.user!.getIdToken());
      print(authResult.user!.uid);
    }
  }
}
