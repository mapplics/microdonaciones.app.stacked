import 'package:flutter/material.dart';

class LoginViewParameters {
  Widget? returnedView;
  bool popWhenFinish;
  bool popUntilFirst;

  LoginViewParameters({
    required this.popWhenFinish,
    required this.popUntilFirst,
    this.returnedView,
  }) : assert(
          (popWhenFinish && !popUntilFirst) ||
              (!popWhenFinish && popUntilFirst),
          'popWhenFinish and popUntilFirst cannot both be true',
        );
}
