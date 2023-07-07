import 'package:flutter/material.dart';

class FocusHelper {
  /// Cierra el teclado.
  static void closeKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
