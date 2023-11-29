import 'package:flutter/foundation.dart' show immutable;
import 'package:riverpod_app/state/login/models/login_result.dart';

/// author kevin
/// date 2023/11/3 11:45

@immutable
class LoginFormState {
  final LoginResult? loginResult;
  final bool isLoading;

  const LoginFormState({
    required this.loginResult,
    required this.isLoading,
  });

  const LoginFormState.unknown()
      : loginResult = null,
        isLoading = false;

  LoginFormState copyWithIsLoading(bool isLoading) => LoginFormState(
        loginResult: loginResult,
        isLoading: isLoading,
      );

  @override
  String toString() {
    return 'LoginFormState{loginResult: $loginResult, isLoading: $isLoading}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginFormState &&
        other.loginResult == loginResult &&
        other.isLoading == isLoading;
  }

  @override
  int get hashCode => Object.hash(loginResult, isLoading);
}
