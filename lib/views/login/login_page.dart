import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../state/login/providers/login_form_provider.dart';

/// author kevin
/// date 2023/11/3 11:37

// login page with form

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = ref.watch(loginFormProvider.notifier).formKey;
    final emailController =
        ref.read(loginFormProvider.notifier).emailController;
    final passwordController =
        ref.read(loginFormProvider.notifier).passwordController;

    debugPrint(ref.watch(loginFormProvider.notifier).isLoading.toString());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email is required';
                }
                return null;
              },
            ),
            const Gap(20),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password is required';
                }
                return null;
              },
            ),
            const Gap(60),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  ref.read(loginFormProvider.notifier).login();
                }
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
