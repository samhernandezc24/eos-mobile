import 'package:eos_mobile/core/common/widgets/eos_mobile_logo.dart';
import 'package:eos_mobile/core/common/widgets/wave_clipper.dart';
import 'package:eos_mobile/features/auth/presentation/widgets/sign_in_form.dart';
import 'package:eos_mobile/shared/shared.dart';

class AuthSignInPage extends StatefulWidget {
  const AuthSignInPage({Key? key}) : super(key: key);

  @override
  State<AuthSignInPage> createState() => _AuthSignInPageState();
}

class _AuthSignInPageState extends State<AuthSignInPage> {
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
                    // ==== SIGN IN FORM ====
                    const SignInForm(),
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
