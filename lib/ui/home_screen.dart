import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/login_controller_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Home Screen'),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(loginControllerProvider.notifier).logout();
            },
            icon: const Icon(Icons.logout_rounded),
          )
        ],
      ),
      body: const Center(child: Text('We are at home')),
    );
  }
}
