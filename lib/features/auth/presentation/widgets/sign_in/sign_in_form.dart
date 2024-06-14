import 'package:eos_mobile/core/di/injection_container.dart';
import 'package:eos_mobile/features/auth/domain/entities/sign_in_entity.dart';
import 'package:eos_mobile/features/auth/presentation/bloc/auth/local/local_auth_bloc.dart';
import 'package:eos_mobile/features/auth/presentation/bloc/auth/remote/remote_auth_bloc.dart';
import 'package:eos_mobile/features/auth/presentation/pages/forgot_password/forgot_password_page.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';

class AuthSignInForm extends StatefulWidget {
  const AuthSignInForm({Key? key}) : super(key: key);

  @override
  State<AuthSignInForm> createState() => _AuthSignInFormState();
}

class _AuthSignInFormState extends State<AuthSignInForm> {
  // GLOBAL KEY
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // CONTROLLERS
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController    = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // EVENTS
  void _handleSignInPressed() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text($strings.alertWarningInvalidFormTitle, style: $styles.textStyles.bodyBold),
              const Text('Por favor, revisa los campos del formulario.', softWrap: true),
            ],
          ),
          backgroundColor : const Color(0xfff89406),
          elevation       : 0,
          behavior        : SnackBarBehavior.fixed,
          showCloseIcon   : true,
        ),
      );
      return;
    } else {
      _formKey.currentState!.save();
      _signIn();
    }
  }

  Future<void> _showServerFailedDialog(BuildContext context, String? errorMessage) async {
    return showDialog<void>(
      context : context,
      builder: (BuildContext context)  => ServerFailedDialog(
        errorMessage: errorMessage ?? 'Se produjo un error inesperado. Intenta de nuevo iniciar sesión.',
      ),
    );
  }

  /// METHODS
  Future<void> _signIn() async {
    final SignInEntity credentials = SignInEntity(email: _emailController.text, password: _passwordController.text);
    BlocProvider.of<RemoteAuthBloc>(context).add(SignIn(credentials));
  }

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
                  LabeledTextFormField(
                    controller    : _emailController,
                    label         : 'Usuario:',
                    hintText      : 'ejem@plo.com',
                    keyboardType  : TextInputType.emailAddress,
                    validator     : FormValidators.emailValidator,
                  ),

                  Gap($styles.insets.md),

                  // USUARIO / CORREO ELECTRÓNICO:
                  LabeledPasswordFormField(
                    controller      : _passwordController,
                    label           : 'Contraseña',
                    validator       : FormValidators.passwordValidator,
                    textInputAction : TextInputAction.done,
                  ),

                  Gap($styles.insets.lg),

                  // ¿HAS OLVIDADO TU CONTRASEÑA?:
                  // GestureDetector(
                  //   onTap: _buildForgotPasswordPage,
                  //   child: Container(
                  //     alignment: Alignment.centerRight,
                  //     padding: EdgeInsets.symmetric(vertical: $styles.insets.sm),
                  //     child: Text(
                  //       '¿Has olvidado tu contraseña?',
                  //       style: TextStyle(color: Theme.of(context).primaryColor),
                  //     ),
                  //   ),
                  // ),

                  BlocConsumer<RemoteAuthBloc, RemoteAuthState>(
                    listener: (BuildContext context, RemoteAuthState state) {
                      if (state is RemoteAuthServerFailure) {
                        _showServerFailedDialog(context, state.failure?.errorMessage);
                      }

                      if (state is RemoteAuthSuccess) {
                        // final SignInEntity objSignIn = SignInEntity(email: _emailController.text, password: _passwordController.text);
                        // // GUARDADO DE CREDENCIALES EN ALMACENAMIENTO LOCAL
                        // context.read<LocalAuthBloc>().add(SaveCredentials(objSignIn));

                        // // GUARDADO DE INFORMACIÓN DEL USUARIO EN ALMACENAMIENTO LOCAL
                        // context.read<LocalAuthBloc>().add(
                        //       SaveUserInfo(
                        //         id            : state.account!.id,
                        //         user          : state.account!.user,
                        //         expiration    : state.account!.expiration,
                        //         nombre        : state.account!.nombre.toProperCase(),
                        //         key           : state.account!.key,
                        //         privilegies   : state.account!.privilegies,
                        //         foto          : state.account!.foto,
                        //       ),
                        //     );

                        // // GUARDADO DE SESIÓN DEL USUARIO EN ALMACENAMIENTO LOCAL
                        // context.read<LocalAuthBloc>().add(SaveUserSession(state.account!.token));

                        // // NAVEGAR EXITOSAMENTE AL HOMEPAGE
                        // context.go(ScreenPaths.home);
                        // settingsLogic.hasAuthenticated.value = true;
                      }
                    },
                    builder: (BuildContext context, RemoteAuthState state) {
                      if (state is RemoteAuthLoading) {
                        return FilledButton(
                          onPressed : null,
                          style     : ButtonStyle(minimumSize: MaterialStateProperty.all(const Size(double.infinity, 48))),
                          child     : const AppLoadingIndicator(width: 20, height: 20),
                        );
                      }
                      return FilledButton(
                        onPressed : _handleSignInPressed,
                        style     : ButtonStyle(minimumSize: MaterialStateProperty.all(const Size(double.infinity, 48))),
                        child     : Text($strings.signInButtonText, style: $styles.textStyles.button),
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
