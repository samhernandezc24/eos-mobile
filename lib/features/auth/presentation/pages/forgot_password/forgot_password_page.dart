import 'package:eos_mobile/shared/shared.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  // LISTENERS
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    // Limpia el controlador cuando se elimina el widget.
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '¿Has olvidado tu contraseña?',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
        margin: EdgeInsets.zero,
        height: size.height,
        child: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset(
                      'assets/images/pages/forgot_password.svg',
                      fit: BoxFit.cover,
                      width: size.width,
                      semanticsLabel: 'Olvidaste tu contraseña',
                    ),
                    const Text(
                      'Completa el formulario para restablecer su contraseña',
                    ),
                    Form(
                      key: _formKey,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text('Correo electrónico'),
                            const Gap(6),
                            TextFormField(
                              controller: _emailController,
                              decoration: const InputDecoration(
                                hintText: 'ejem@plo.com',
                                isDense: true,
                              ),
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.done,
                            ),
                            const Gap(32),
                            FilledButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all(
                                  const Size(double.infinity, 48),
                                ),
                              ),
                              child: const Text(
                                'Enviar enlace',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
