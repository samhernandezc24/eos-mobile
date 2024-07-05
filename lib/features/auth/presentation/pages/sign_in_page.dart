import 'package:eos_mobile/features/auth/domain/entities/sign_in_entity.dart';
import 'package:eos_mobile/features/auth/presentation/bloc/remote/remote_auth_bloc.dart';
import 'package:eos_mobile/features/auth/presentation/cubit/local/local_auth_cubit.dart';

import 'package:eos_mobile/shared/shared_libs.dart';

import 'package:eos_mobile/ui/common/wave_clipper.dart';

class AuthSignInPage extends StatefulWidget {
  const AuthSignInPage({Key? key}) : super(key: key);

  @override
  State<AuthSignInPage> createState() => _AuthSignInPageState();
}

class _AuthSignInPageState extends State<AuthSignInPage> {
  // GLOBAL KEY
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // CONTROLLERS
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  // STATE
  @override
  void initState() {
    super.initState();
    _emailController      = TextEditingController();
    _passwordController   = TextEditingController();

    context.read<LocalAuthCubit>().onGetCredentials();
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

  Future<void> _showServerErrorDialog(BuildContext context, String? errorMessage) async {
    return showDialog<void>(
      context: context,
      builder: (_) => ServerErrorDialog(message: errorMessage ?? AppStrings.errorGenericMessage),
    );
  }

  // METHODS
  Future<void> _signIn() async {
    final SignInEntity credentials = SignInEntity(
      email     : _emailController.text,
      password  : _passwordController.text,
    );
    context.read<RemoteAuthBloc>().add(SignIn(credentials));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTextColor(
        color: Theme.of(context).colorScheme.onBackground,
        child: ColoredBox(
          color: Theme.of(context).colorScheme.background,
          child: SafeArea(
            child: Stack(
              children: <Widget>[
                // WAVE CLIPPERS:
                Positioned.fill(child: _buildClipperDecoration(context)),

                ExcludeSemantics(
                  excluding: false,
                  child: Column(
                    children: <Widget>[
                      const Spacer(),

                      // LOGO:
                      Semantics(
                        header  : true,
                        child   : Container(
                          alignment : Alignment.center,
                          child     : _AuthSignInLogo(),
                        ),
                      ),

                      // FORM:
                      Padding(
                        padding: EdgeInsets.fromLTRB($stylesShell.insets.sm, $stylesShell.insets.lg * 1.34, $stylesShell.insets.sm, $stylesShell.insets.sm),
                        child: BlocBuilder<LocalAuthCubit, LocalAuthState>(
                          builder: (BuildContext context, LocalAuthState state) {
                            if (state is LocalAuthGetCredentials) {
                              _emailController.text     = state.credentials?.email    ?? '';
                              _passwordController.text  = state.credentials?.password ?? '';
                            }
                            return Form(
                              key   : _formKey,
                              child : Column(
                                children: <Widget>[
                                  // CAMPO: CORREO ELECTRÓNICO:
                                  LabeledTextFormField(
                                    controller    : _emailController,
                                    hintText      : 'ejem@plo.com',
                                    keyboardType  : TextInputType.emailAddress,
                                    label         : 'Usuario:',
                                    validator     : FormValidators.emailValidator,
                                  ),

                                  Gap($stylesShell.insets.md),

                                  // CAMPO: CONTRASEÑA:
                                  LabeledPasswordFormField(
                                    controller      : _passwordController,
                                    label           : 'Contraseña:',
                                    textInputAction : TextInputAction.done,
                                    validator       : FormValidators.passwordValidator,
                                  ),

                                  Gap($stylesShell.insets.lg),

                                  BlocConsumer<RemoteAuthBloc, RemoteAuthState>(
                                    listener: (BuildContext context, RemoteAuthState state) {
                                      // ERROR
                                      if (state is RemoteAuthServerError) {
                                        _showServerErrorDialog(context, state.error?.errorMessage);
                                      }

                                      // SUCCESS
                                      if (state is RemoteAuthSuccess) {
                                        final localAuthCubit = context.read<LocalAuthCubit>();

                                        // GUARDAR CREDENCIALES
                                        localAuthCubit.onStoreCredentials(
                                          SignInEntity(
                                            email     : _emailController.text,
                                            password  : _passwordController.text,
                                          ),
                                        );

                                        // GUARDAR TOKEN
                                        localAuthCubit.onStoreUserSession(state.objResponse!.token);

                                        // GUARDAR INFORMACIÓN DEL USUARIO
                                        localAuthCubit.onStoreUserInfo(state.objResponse!);

                                        // NAVEGAR A LA PAGINA PRINCIPAL
                                        context.go(AppRoutes.home);
                                        settingsLogic.hasAuthenticated.value = true;
                                      }
                                    },
                                    builder: (BuildContext context, RemoteAuthState state) {
                                      // LOADING
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
                                        child     : Text(AppStrings.btnJoinText, style: $stylesShell.textStyles.button),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildClipperDecoration(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper : WaveClipper(),
          child   : Container(
            alignment : Alignment.center,
            padding   : const EdgeInsets.only(bottom: 450),
            color     : Theme.of(context).primaryColor.withOpacity(0.8),
            height    : 220,
          ),
        ),
        ClipPath(
          clipper : WaveClipper(reverse: true),
          child   : Container(
            alignment : Alignment.center,
            padding   : const EdgeInsets.only(bottom: 50),
            color     : Theme.of(context).primaryColor.withOpacity(0.6),
            height    : 180,
          ),
        ),
      ],
    );
  }
}

class _AuthSignInLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment : MainAxisAlignment.center,
      children          : <Widget>[
        const ExcludeSemantics(child: EOSMobileLogo(width: 96)),
        Gap($stylesShell.insets.xs),
        StaticTextScale(
          child: Text(
            AppStrings.authSignInTitle,
            style: $stylesShell.textStyles.eosTitle.copyWith(fontSize: 30 * $stylesShell.scale, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
