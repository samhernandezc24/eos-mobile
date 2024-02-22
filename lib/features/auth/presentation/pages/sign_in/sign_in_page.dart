import 'package:eos_mobile/core/common/widgets/eos_mobile_logo.dart';
import 'package:eos_mobile/core/common/widgets/wave_clipper.dart';
import 'package:eos_mobile/core/validators/form_validators.dart';
import 'package:eos_mobile/features/auth/presentation/pages/forgot_password/forgot_password.dart';
import 'package:eos_mobile/shared/shared.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  // LISTENERS
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // PROPIEDADES
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  @override
  void dispose() {
    // Limpia el controlador cuando se elimina el widget.
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        margin: EdgeInsets.zero,
        height: size.height,
        child: Stack(
          children: <Widget>[
            ClipPath(
              clipper: WaveClipper(),
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(bottom: 450),
                color: Theme.of(context).primaryColor.withOpacity(.8),
                height: 220,
              ),
            ),
            ClipPath(
              clipper: WaveClipper(reverse: true),
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(bottom: 50),
                color: Theme.of(context).primaryColor.withOpacity(.6),
                height: 180,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Gap(size.height * .2),
                    const EOSMobileLogo(width: 96),
                    const Gap(16),
                    const Text(
                      'Iniciar Sesión',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Gap(32),
                    Form(
                      key: _formKey,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // Form Control: Usuario
                            const Text('Usuario'),
                            const Gap(6),
                            TextFormField(
                              controller: _emailController,
                              decoration: const InputDecoration(
                                hintText: 'ejem@plo.com',
                                isDense: true,
                              ),
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              validator: FormValidators.emailValidator,
                            ),
                            // Form Control: Contraseña
                            const Gap(24),
                            const Text('Contraseña'),
                            const Gap(6),
                            TextFormField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                isDense: true,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordVisible = !_isPasswordVisible;
                                    });
                                  },
                                  color: Theme.of(context).hintColor,
                                  icon: FaIcon(
                                    _isPasswordVisible
                                        ? FontAwesomeIcons.eyeSlash
                                        : FontAwesomeIcons.eye,
                                  ),
                                ),
                              ),
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: !_isPasswordVisible,
                              textInputAction: TextInputAction.done,
                              validator: FormValidators.passwordValidator,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (context) =>
                                        const ForgotPasswordPage(),
                                  ),
                                );
                              },
                              child: Container(
                                alignment: Alignment.centerRight,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: Text(
                                  '¿Has olvidado tu contraseña?',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                            ),
                            FilledButton(
                              onPressed: () {
                                if (!_formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content:
                                          const Text('Formulario incompleto'),
                                      backgroundColor:
                                          Theme.of(context).colorScheme.error,
                                    ),
                                  );
                                  return;
                                }

                                setState(() {
                                  _isLoading = true;
                                });

                                Future.delayed(const Duration(seconds: 2), () {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                });
                              },
                              style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all(
                                  const Size(double.infinity, 48),
                                ),
                              ),
                              child: _isLoading
                                  ? const CircularProgressIndicator(
                                    color: Colors.white70,
                                  )
                                  : const Text(
                                      'Ingresar',
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
