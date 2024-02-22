import 'package:eos_mobile/shared/shared.dart';

class Error500Page extends StatelessWidget {
  const Error500Page({super.key});

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
              SvgPaths.error500,
              fit: BoxFit.cover,
              width: size.width,
              semanticsLabel: 'Error 500',
            ),
            const Gap(35),
            const Text(
              '¡Algo ha salido mal!',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
            ),
            const Gap(10),
            const Text(              
              'Error de servidor 500. Nuestro personal ha sido notificado, gracias por su comprensión.',
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
