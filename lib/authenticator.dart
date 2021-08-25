import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authenticator extends InheritedWidget {
  Authenticator(
    this._id, {
    required Widget child,
  }) : super(child: child) {
    // _id = FirebaseAuth.instance.currentUser!.uid;
    _id = 'MeuIdBarril';
  }
  late final String _id;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static Authenticator of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<Authenticator>()!;

  String get id => _id;
}
