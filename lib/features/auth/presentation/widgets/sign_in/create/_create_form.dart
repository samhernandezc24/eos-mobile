part of '../../../pages/sign_in/sign_in_page.dart';

class _CreateSignInForm extends StatefulWidget {
  const _CreateSignInForm({Key? key}) : super(key: key);

  @override
  State<_CreateSignInForm> createState() => _CreateSignInFormState();
}

class _CreateSignInFormState extends State<_CreateSignInForm> {
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
    if (_formKey.currentState!.validate()) {
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

  // METHODS
  Future<void> _signIn() async {
    final SignInEntity credentials = SignInEntity(email: _emailController.text, password: _passwordController.text);
    BlocProvider.of<RemoteAuthBloc>(context).add(SignIn(credentials));
  }

  void _buildForgotPasswordPage() {
    Navigator.push<void>(
      context,
      PageRouteBuilder<void>(
        transitionDuration: $styles.times.pageTransition,
        pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation)
            => const ForgotPasswordPage(),
        transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
          const Offset begin    = Offset(1, 0);
          const Offset end      = Offset.zero;
          const Cubic curve     = Curves.ease;
          final Animatable<Offset> tween = Tween<Offset>(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(position: animation.drive<Offset>(tween), child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LocalAuthBloc>()..add(GetCredentials()),
      child: BlocConsumer<LocalAuthBloc, LocalAuthState>(
        listener: (BuildContext context, LocalAuthState state) {
          if (state is LocalAuthGetCredentialsSuccess) {
            _emailController.text     = state.credentials?.email ?? '';
            _passwordController.text  = state.credentials?.password ?? '';
          }
        },
        builder: (context, state) {
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
                    label           : 'Contraseña:',
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
                        // GUARDADO DE CREDENCIALES
                        BlocProvider.of<LocalAuthBloc>(context).add(
                          StoreCredentials(
                            SignInEntity(
                              email     : _emailController.text,
                              password  : _passwordController.text,
                            ),
                          ),
                        );

                        // GUARDADO DE INFORMACION DEL USUARIO
                        BlocProvider.of<LocalAuthBloc>(context).add(
                          StoreUserInfo(
                            UserInfoEntity(
                              id          : state.objResponse?.id ?? '',
                              user        : state.objResponse!.user,
                              expiration  : state.objResponse!.expiration,
                              nombre      : state.objResponse?.nombre ?? '',
                              privilegies : state.objResponse?.privilegies ?? '',
                              foto        : state.objResponse?.foto ?? '',
                            ),
                          ),
                        );

                        // GUARDADO DE SESION DEL USUARIO
                        BlocProvider.of<LocalAuthBloc>(context).add(StoreUserSession(state.objResponse?.token ?? ''));

                        // NAVEGAR AL HOME
                        context.go(ScreenPaths.home);
                        settingsLogic.hasAuthenticated.value = true;
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
