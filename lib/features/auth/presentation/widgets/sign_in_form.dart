import 'package:eos_mobile/core/common/widgets/controls/loading_indicator.dart';
import 'package:eos_mobile/features/auth/domain/entities/sign_in_entity.dart';
import 'package:eos_mobile/features/auth/presentation/bloc/sign_in/remote/remote_sign_in_bloc.dart';
import 'package:eos_mobile/features/auth/presentation/pages/forgot_password/forgot_password_page.dart';
import 'package:eos_mobile/shared/shared.dart';

class AuthSignInForm extends StatefulWidget {
  const AuthSignInForm({Key? key}) : super(key: key);

  @override
  State<AuthSignInForm> createState() => _AuthSignInFormState();
}

class _AuthSignInFormState extends State<AuthSignInForm> {
  // LISTENERS
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // Limpia el controlador cuando se elimina el widget.
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSignInSubmitted() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Formulario incompleto'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    } else {
      final signInData = SignInEntity(
        email: _emailController.text,
        password: _passwordController.text,
      );
      context.read<RemoteSignInBloc>().add(SignInSubmitted(signInData));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RemoteSignInBloc, RemoteSignInState>(
      listener: (context, state) {
        if (state is RemoteSignInFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(
                  state.failure?.response?.data.toString() ??
                      'Ha ocurrido un error al iniciar sesión.',
                ),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
        }

        if (state is RemoteSignInSuccess) {
          context.go(ScreenPaths.home);
          settingsLogic.isLoggedIn.value = true;
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.all($styles.insets.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // USUARIO:
                LabeledTextField(
                  controller: _emailController,
                  hintText: 'ejem@plo.com',
                  labelText: 'Usuario',
                  keyboardType: TextInputType.emailAddress,
                  validator: FormValidators.emailValidator,
                ),

                Gap($styles.insets.md),

                // CONTRASEÑA:
                LabeledTextField(
                  controller: _passwordController,
                  labelText: 'Contraseña',
                  isPassword: true,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  validator: FormValidators.passwordValidator,
                ),

                // ¿HAS OLVIDADO TU CONTRASEÑA?:
                GestureDetector(
                  onTap: () {
                    Navigator.push<void>(
                      context,
                      PageRouteBuilder<void>(
                        transitionDuration: $styles.times.pageTransition,
                        pageBuilder: (BuildContext context,
                            Animation<double> animation,
                            Animation<double> secondaryAnimation) {
                          const Offset begin = Offset(0, 1);
                          const Offset end = Offset.zero;
                          const Cubic curve = Curves.ease;

                          final Animatable<Offset> tween =
                              Tween<Offset>(begin: begin, end: end)
                                  .chain(CurveTween(curve: curve));

                          return SlideTransition(
                            position: animation.drive<Offset>(tween),
                            child: const ForgotPasswordPage(),
                          );
                        },
                      ),
                    );
                  },
                  child: Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(vertical: $styles.insets.sm),
                    child: Text(
                      '¿Has olvidado tu contraseña?',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),

                // INICIAR SESIÓN BOTON:
                _SignInButton(handleSignInSubmitted: _handleSignInSubmitted),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SignInButton extends StatelessWidget {
  const _SignInButton({required this.handleSignInSubmitted, Key? key})
      : super(key: key);

  final VoidCallback handleSignInSubmitted;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RemoteSignInBloc, RemoteSignInState>(
      builder: (context, state) {
        return state is RemoteSignInLoading
            ? FilledButton(
                onPressed: null,
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size?>(
                    const Size(double.infinity, 48),
                  ),
                ),
                child: LoadingIndicator(
                  color: Theme.of(context).disabledColor,
                  width: 20,
                  height: 20,
                  strokeWidth: 2,
                ),
              )
            : FilledButton(
                onPressed: handleSignInSubmitted,
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size?>(
                    const Size(double.infinity, 48),
                  ),
                ),
                child: Text(
                  'Ingresar',
                  style: $styles.textStyles.button,
                ),
              );
      },
    );
  }
}
