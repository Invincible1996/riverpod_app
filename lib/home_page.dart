/// @Author: kevin
/// @Date: 2023-10-20 13:58:02
/// @Description:
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod Example'),
      ),
      body: ListView(
        children: [
          ListTile(
              title: const Text('Fetch Network Data'),
              onTap: () {
                context.push('/fetch');
              }),
        ],
      ),
    );
  }
}
