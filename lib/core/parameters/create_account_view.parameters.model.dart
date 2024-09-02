import 'package:microdonations/core/models/user/firebase_user.model.dart';

class CreateAccountViewParameters {
  final FirebaseUser user;
  final String? onBackRoute;
  CreateAccountViewParameters({required this.user, this.onBackRoute = ''});
}
