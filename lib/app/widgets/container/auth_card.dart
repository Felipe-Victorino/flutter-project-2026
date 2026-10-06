import 'package:flutter/material.dart';

class AuthCard extends StatelessWidget {
  final Widget child;

  const AuthCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .all(24),
      child: Card(
        child: Padding(padding: .all(24), child: child),
      ),
    );
  }
}
