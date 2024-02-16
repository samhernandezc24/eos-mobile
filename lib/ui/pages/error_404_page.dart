import 'package:eos_mobile/ui/common/eos_logo.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Error404Page extends StatelessWidget {
  const Error404Page(this.url, {super.key});

  final String url;

  @override
  Widget build(BuildContext context) {
    void handleHomePressed() => context.go('/');

    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            EOSLogo(),
          ],
        ),
      ),
    );
  }
}
