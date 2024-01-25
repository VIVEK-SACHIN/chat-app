import 'package:flutter/material.dart';

class SplashSCreen extends StatelessWidget {
  const SplashSCreen({super.key});
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('FlutterChat'),
        ),
        body: const Center(
          child: Text('Loading'),
        ),
      );
  }
}
