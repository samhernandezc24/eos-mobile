import 'package:eos_mobile/core/common/widgets/controls/loading_indicator.dart';
import 'package:eos_mobile/core/validators/form_validators.dart';
import 'package:eos_mobile/features/auth/domain/entities/sign_in_entity.dart';
import 'package:eos_mobile/features/auth/presentation/bloc/sign_in/remote/remote_sign_in_bloc.dart';
import 'package:eos_mobile/features/auth/presentation/bloc/sign_in/remote/remote_sign_in_event.dart';
import 'package:eos_mobile/features/auth/presentation/bloc/sign_in/remote/remote_sign_in_state.dart';
import 'package:eos_mobile/features/auth/presentation/pages/forgot_password/forgot_password_page.dart';
import 'package:eos_mobile/features/home/presentation/home_page.dart';
import 'package:eos_mobile/shared/shared.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  // LISTENERS
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // STATES
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    // Limpia el controlador cuando se elimina el widget.
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
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
                    builder: (context) => const ForgotPasswordPage(),
                  ),
                );
              },
              child: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  '¿Has olvidado tu contraseña?',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
            BlocConsumer<RemoteSignInBloc, RemoteSignInState>(
              listener: (context, state) {
                if (state is RemoteSignInFailure) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          state.failure?.response?.data.toString() ?? '',
                        ),
                        backgroundColor: Theme.of(context).colorScheme.error,
                      ),
                    );
                  });
                }

                if (state is RemoteSignInSuccess) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute<void>(
                      builder: (context) => const HomePage(),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is RemoteSignInLoading) {
                  return FilledButton(
                    onPressed: null,
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                        const Size(double.infinity, 48),
                      ),
                    ),
                    child: LoadingIndicator(
                      color: Theme.of(context).disabledColor,
                      width: 20,
                      height: 20,
                      strokeWidth: 2,
                    ),
                  );
                }

                return FilledButton(
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Formulario incompleto'),
                          backgroundColor: Theme.of(context).colorScheme.error,
                        ),
                      );
                      return;
                    } else {
                      final signInData = SignInEntity(
                          email: _emailController.text,
                          password: _passwordController.text);
                      context.read<RemoteSignInBloc>().add(SignIn(signInData));
                    }
                  },
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(
                      const Size(double.infinity, 48),
                    ),
                  ),
                  child: const Text(
                    'Ingresar',
                    style: TextStyle(fontSize: 16),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
