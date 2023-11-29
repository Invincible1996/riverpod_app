import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/auth_repository.dart';

class LoginController extends ChangeNotifier {
  final Ref ref;
  bool isLoggedIn = false;
  LoginController(this.ref) {
    _checkIsAuthed();
  }

  void _checkIsAuthed() async {
    final isAuthed = ref.watch(getIsAuthedProvider);
    if (isAuthed.value ?? false) {
      // state = const LoginStateSuccess();
      isLoggedIn = true;
    } else {
      // state = const LoginStateInitial();
      isLoggedIn = false;
    }
    notifyListeners();
  }

  void login(String email, String password) async {
    // state = const LoginStateLoading();
    try {
      await ref.read(authRepositoryProvider).login(email, password);
      ref.read(setIsAuthedProvider(true));
      isLoggedIn = true;
      // state = const LoginStateSuccess();
    } catch (e) {
      isLoggedIn = false;
      // state = LoginStateError(e.toString());
    }
    notifyListeners();
  }

  void logout() {
    ref.read(setIsAuthedProvider(false));
    ref.read(clearIsAuthedProvider);
    // state = const LoginStateInitial();
    isLoggedIn = false;
    notifyListeners();
  }
}

final loginControllerProvider = ChangeNotifierProvider((ref) {
  return LoginController(ref);
});
