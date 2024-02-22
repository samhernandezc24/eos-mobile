import 'package:eos_mobile/shared/shared.dart';

class Error404Page extends StatelessWidget {
  const Error404Page({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    void handleHomePressed() => context.go('/');

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              SvgPaths.error404,
              fit: BoxFit.cover,
              width: size.width,
              semanticsLabel: 'Error 404',
            ),
            const Gap(35),
            const Text(
              '¡Oops! 404',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
            ),
            const Gap(10),
            const Text(
              'La página que estás buscando no se encuentra aquí. ¿Quieres volver a nuestra página principal?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const Gap(35),
            FilledButton(
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
