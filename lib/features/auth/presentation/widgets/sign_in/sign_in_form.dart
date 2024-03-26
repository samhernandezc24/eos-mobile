import 'package:eos_mobile/core/common/widgets/controls/loading_indicator.dart';
import 'package:eos_mobile/features/auth/domain/entities/sign_in_entity.dart';
import 'package:eos_mobile/features/auth/presentation/bloc/sign_in/sign_in_bloc.dart';
import 'package:eos_mobile/features/auth/presentation/pages/forgot_password/forgot_password_page.dart';
import 'package:eos_mobile/shared/shared.dart';

class AuthSignInForm extends StatefulWidget {
  const AuthSignInForm({Key? key}) : super(key: key);

  @override
  State<AuthSignInForm> createState() => _AuthSignInFormState();
}

class _AuthSignInFormState extends State<AuthSignInForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController    = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSignInComplete() {
    context.go(ScreenPaths.home);
    settingsLogic.isLoggedIn.value = true;

    // Recuperar datos del usuario (perfil, etc).
  }

  void _handleSubmitSignIn() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Formulario incompleto'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    } else {
      final SignInEntity objSignInData = SignInEntity(
        email     : _emailController.text,
        password  : _passwordController.text,
      );
      // EVENTO DE INICIO DE SESIÓN
      context.read<SignInBloc>().add(SignInSubmitted(objSignInData));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInBloc, SignInState>(
      listener: (BuildContext context, SignInState state) {
        if (state is SignInFailure) {
          showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  state.failure?.response?.data.toString() ?? 'Se produjo un error inesperado. Intenta iniciar sesión de nuevo.',
                  style: $styles.textStyles.h3,
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Aceptar', style: $styles.textStyles.button),
                  ),
                ],
              );
            },
          );
        }

        // if (state is SignInNoConnection) {
        //   showDialog<void>(
        //     context: context,
        //     builder: (BuildContext context) {
        //       return AlertDialog(
        //         title: Text('No se puede iniciar sesión', style: $styles.textStyles.h3),
        //         content: Text(
        //           'Se produjo un error inesperado. Intenta iniciar sesión de nuevo.',
        //           style: $styles.textStyles.body,
        //         ),
        //         actions: <Widget>[
        //           TextButton(
        //             onPressed: () {
        //               Navigator.of(context).pop();
        //             },
        //             child: Text('Aceptar', style: $styles.textStyles.button),
        //           )
        //         ],
        //       );
        //     },
        //   );
        // }

        if (state is SignInSuccess) {  _handleSignInComplete(); }
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
                _SignInButton(handleSubmitSignIn: _handleSubmitSignIn),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SignInButton extends StatelessWidget {
  const _SignInButton({required this.handleSubmitSignIn, Key? key})
      : super(key: key);

  final VoidCallback handleSubmitSignIn;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      builder: (context, state) {
        return state is SignInLoading
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
                onPressed: handleSubmitSignIn,
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
