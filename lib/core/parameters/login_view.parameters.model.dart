class LoginViewParameters {
  bool popWhenFinish;
  final String? onBackRoute;

  LoginViewParameters({
    required this.popWhenFinish,
    this.onBackRoute = '',
  });
}
