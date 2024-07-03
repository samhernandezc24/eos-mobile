import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:eos_mobile/ui/common/eos_mobile_logo.dart';
import 'package:eos_mobile/ui/common/static_text_scale.dart';
import 'package:eos_mobile/ui/common/themed_text.dart';
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
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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
                        padding: EdgeInsets.fromLTRB($styles.insets.sm, $styles.insets.lg * 1.34, $styles.insets.sm, $styles.insets.sm),
                        child: Form(
                          key   : _formKey,
                          child : _AuthSignInForm(
                            emailController     : _emailController,
                            passwordController  : _passwordController,
                          ),
                        ),
                      ),

                      const Spacer(),
                    ],
                  ),
                )
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

class _AuthSignInForm extends StatefulWidget {
  const _AuthSignInForm({
    required this.emailController,
    required this.passwordController,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  State<_AuthSignInForm> createState() => _AuthSignInFormState();
}

class _AuthSignInFormState extends State<_AuthSignInForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // CAMPO: CORREO ELECTRÓNICO:
        LabeledTextFormField(
          controller    : widget.emailController,
          hintText      : 'ejem@plo.com',
          keyboardType  : TextInputType.emailAddress,
          label         : 'Usuario:',
        ),

        Gap($styles.insets.md),

        // CAMPO: CONTRASEÑA:
        LabeledPasswordFormField(
          controller      : widget.passwordController,
          label           : 'Contraseña:',
          textInputAction : TextInputAction.done,
        ),

        Gap($styles.insets.lg),

        FilledButton(
          onPressed : (){},
          style     : ButtonStyle(minimumSize: MaterialStateProperty.all(const Size(double.infinity, 48))),
          child     : Text(AppStrings.btnJoinText, style: $styles.textStyles.button),
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
        Gap($styles.insets.xs),
        StaticTextScale(
          child: Text(
            AppStrings.authSignInTitle,
            style: $styles.textStyles.eosTitle.copyWith(fontSize: 30 * $styles.scale, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
