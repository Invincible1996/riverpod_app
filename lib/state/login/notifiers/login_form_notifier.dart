import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/login_form_state.dart';

/// author kevin
/// date 2023/11/3 11:42

class LoginFormNotifier extends StateNotifier<LoginFormState> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  var isLoading = false;

  LoginFormNotifier()
      : super(
          const LoginFormState.unknown(),
        );

  void login() async {
    // state = state.copyWithIsLoading(true);
    isLoading = true;
    // Future.delayed(
    //   const Duration(seconds: 2),
    // );
    // state = const LoginFormState(
    //   loginResult: LoginResult.success,
    //   isLoading: false,
    // );
    isLoading = false;
  }
}
