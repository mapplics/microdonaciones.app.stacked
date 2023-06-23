import 'package:flutter/material.dart';

/// Containter con los border redondeados.
/// Lo utilizamos como hijo en los scaffold para dar la forma redondeada
/// del contenido.
class RoundedBody extends StatelessWidget {
  final Widget child;

  const RoundedBody({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26.0),
        child: child,
      ),
    );
  }
}
