import 'dart:async';

import 'package:agenda/simple_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserAuth extends SimpleBloc<String?> {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> login(String email, String senha) async {
    final r =
        await auth.signInWithEmailAndPassword(email: email, password: senha);
    add(r.user?.uid);
  }

  Future<void> create(String email, String senha) async {
    final r = await auth.createUserWithEmailAndPassword(
        email: email, password: senha);
    super.add(r.user?.uid);
  }

  fetchLogedUserId() {
    String? r = auth.currentUser?.uid;
    super.add(r);
  }

  Future<void> signOut() {
    super.add(null);
    return auth.signOut();
  }
}
