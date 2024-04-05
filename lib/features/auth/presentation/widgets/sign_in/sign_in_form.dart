import 'package:eos_mobile/core/common/widgets/controls/loading_indicator.dart';
import 'package:eos_mobile/core/di/injection_container.dart';
import 'package:eos_mobile/features/auth/domain/entities/sign_in_entity.dart';
import 'package:eos_mobile/features/auth/presentation/bloc/auth/local/local_auth_bloc.dart';
import 'package:eos_mobile/features/auth/presentation/bloc/auth/remote/remote_auth_bloc.dart';
import 'package:eos_mobile/features/auth/presentation/pages/forgot_password/forgot_password_page.dart';
import 'package:eos_mobile/shared/shared.dart';

class AuthSignInForm extends StatefulWidget {
  const AuthSignInForm({Key? key}) : super(key: key);

  @override
  State<AuthSignInForm> createState() => _AuthSignInFormState();
}

class _AuthSignInFormState extends State<AuthSignInForm> {
  // GENERAL INSTANCES
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // CONTROLLERS
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    _emailController    = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // METHODS
  Future<void> _buildForgotPasswordPage() {
    return Navigator.push<void>(
      context,
      PageRouteBuilder<void>(
        transitionDuration: $styles.times.pageTransition,
        pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
          const Offset begin = Offset(0, 1);
          const Offset end = Offset.zero;
          const Cubic curve = Curves.ease;

          final Animatable<Offset> tween = Tween<Offset>(begin: begin, end: end)
              .chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive<Offset>(tween),
            child: const ForgotPasswordPage(),
          );
        },
      ),
    );
  }

  Future<void> _showErrorDialog(RemoteSignInFailure state) {
    return showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: const SizedBox.shrink(),
        content: Row(
          children: <Widget>[
            Icon(Icons.error, color: Theme.of(context).colorScheme.error),
            SizedBox(width: $styles.insets.xs + 2),
            Flexible(
              child: Text(
                state.failure?.response?.data.toString() ??
                    'Se produjo un error inesperado. Intenta iniciar sesión de nuevo.',
                style: $styles.textStyles.title2.copyWith(
                  height: 1.5,
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => context.pop(),
            child: Text($strings.acceptButtonText, style: $styles.textStyles.button),
          ),
        ],
      ),
    );
  }

  void _handleSignIn() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Formulario incompleto'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    } else {
      _formKey.currentState!.save();
      final SignInEntity objSignIn = SignInEntity(email: _emailController.text, password: _passwordController.text);
      context.read<RemoteAuthBloc>().add(SignInSubmitted(objSignIn));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LocalAuthBloc>()..add(GetCredentials()),
      child: BlocConsumer<LocalAuthBloc, LocalAuthState>(
        listener: (BuildContext context, LocalAuthState state) {
          if (state is LocalCredentialsSuccess) {
            _emailController.text = state.credentials?['email'] ?? '';
          }
        },
        builder: (BuildContext context, LocalAuthState state) {
          return Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.all($styles.insets.sm),
              child: Column(
                children: <Widget>[
                  // USUARIO / CORREO ELECTRÓNICO:
                  LabeledTextField(
                    controller: _emailController,
                    hintText: 'ejem@plo.com',
                    labelText: 'Usuario:',
                    keyboardType: TextInputType.emailAddress,
                    validator: FormValidators.emailValidator,
                  ),

                  Gap($styles.insets.md),

                  // USUARIO / CORREO ELECTRÓNICO:
                  LabeledTextField(
                    controller: _passwordController,
                    labelText: 'Contraseña:',
                    isPassword: true,
                    keyboardType: TextInputType.visiblePassword,
                    validator: FormValidators.passwordValidator,
                    textInputAction: TextInputAction.done,
                  ),

                  // ¿HAS OLVIDADO TU CONTRASEÑA?:
                  GestureDetector(
                    onTap: _buildForgotPasswordPage,
                    child: Container(
                      alignment: Alignment.centerRight,
                      padding:
                          EdgeInsets.symmetric(vertical: $styles.insets.sm),
                      child: Text(
                        '¿Has olvidado tu contraseña?',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),

                  // BOTÓN PARA ENVIAR LAS CREDENCIALES:
                  BlocConsumer<RemoteAuthBloc, RemoteAuthState>(
                    listener: (BuildContext context, RemoteAuthState state) {
                      if (state is RemoteSignInSuccess) {
                        final SignInEntity objSignIn = SignInEntity(email: _emailController.text, password: _passwordController.text);
                        // GUARDADO DE CREDENCIALES EN ALMACENAMIENTO LOCAL
                        context.read<LocalAuthBloc>().add(SaveCredentials(objSignIn));

                        // GUARDADO DE INFORMACIÓN DEL USUARIO EN ALMACENAMIENTO LOCAL
                        context.read<LocalAuthBloc>().add(
                              SaveUserInfo(
                                id: state.account!.id,
                                user: state.account!.user,
                                expiration: state.account!.expiration,
                                nombre: state.account!.nombre.toProperCase(),
                                key: state.account!.key,
                                privilegies: state.account!.privilegies,
                                foto: state.account!.foto,
                              ),
                            );

                        // GUARDADO DE SESIÓN DEL USUARIO EN ALMACENAMIENTO LOCAL
                        context.read<LocalAuthBloc>().add(SaveUserSession(state.account!.token));

                        // NAVEGAR EXITOSAMENTE AL HOMEPAGE
                        context.go(ScreenPaths.home);
                        settingsLogic.hasAuthenticated.value = true;
                      } else if (state is RemoteSignInFailure) {
                        _showErrorDialog(state);
                      }
                    },
                    builder: (BuildContext context, RemoteAuthState state) {
                      if (state is RemoteSignInLoading) {
                        return FilledButton(
                          onPressed: null,
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(
                              const Size(double.infinity, 48),
                            ),
                          ),
                          child: LoadingIndicator(
                            color: Theme.of(context).primaryColor,
                            width: 20,
                            height: 20,
                            strokeWidth: 2,
                          ),
                        );
                      }

                      return FilledButton(
                        onPressed: _handleSignIn,
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(
                            const Size(double.infinity, 48),
                          ),
                        ),
                        child: Text($strings.signInButtonText, style: $styles.textStyles.button),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
