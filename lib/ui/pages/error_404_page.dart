import 'package:eos_mobile/core/constants/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class Error404Page extends StatelessWidget {
  const Error404Page(this.url, {super.key});

  final String url;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    void handleHomePressed() => context.go('/');

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppAssets.error404,
              fit: BoxFit.cover,
              width: size.width,
              semanticsLabel: 'Error 404',
            ),
            const Gap(10),
            const Text(
              '404',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
            ),
            const Text(
              'La página que está buscando no existe.',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const Gap(35),
            ElevatedButton(
              onPressed: handleHomePressed,
              child: const Text(
                'Volver a Inicio',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
