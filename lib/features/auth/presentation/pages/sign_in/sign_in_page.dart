import 'package:eos_mobile/core/di/injection_container.dart';
import 'package:eos_mobile/features/auth/domain/entities/sign_in_entity.dart';
import 'package:eos_mobile/features/auth/domain/entities/user_info_entity.dart';
import 'package:eos_mobile/features/auth/presentation/bloc/auth/local/local_auth_bloc.dart';
import 'package:eos_mobile/features/auth/presentation/bloc/auth/remote/remote_auth_bloc.dart';
import 'package:eos_mobile/features/auth/presentation/pages/forgot_password/forgot_password_page.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

import 'package:eos_mobile/ui/common/eos_mobile_logo.dart';
import 'package:eos_mobile/ui/common/wave_clipper.dart';

part '../../widgets/sign_in/create/_create_form.dart';

class AuthSignInPage extends StatefulWidget {
  const AuthSignInPage({Key? key}): super(key: key);

  @override
  State<AuthSignInPage> createState() => _AuthSignInPageState();
}

class _AuthSignInPageState extends State<AuthSignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: DefaultTextColor(
        color: Theme.of(context).colorScheme.onBackground,
        child: ColoredBox(
          color: Theme.of(context).colorScheme.background,
          child: Stack(
            children: <Widget>[
              ClipPath(
                clipper: WaveClipper(),
                child: Container(
                  alignment : Alignment.center,
                  padding   : const EdgeInsets.only(bottom: 450),
                  color     : Theme.of(context).primaryColor.withOpacity(.8),
                  height    : 220,
                ),
              ),
              ClipPath(
                clipper: WaveClipper(reverse: true),
                child: Container(
                  alignment : Alignment.center,
                  padding   : const EdgeInsets.only(bottom: 50),
                  color     : Theme.of(context).primaryColor.withOpacity(.6),
                  height    : 180,
                ),
              ),
              Column(
                children: <Widget>[
                  const Spacer(),

                  // LOGO:
                  _EosMobileLogo(),

                  Gap($styles.insets.md),

                  // FORMULARIO DE INICIO DE SESIÓN:
                  const _CreateSignInForm(),

                  const Spacer(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EosMobileLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const ExcludeSemantics(child: EOSMobileLogo(width: 96)),
        Gap($styles.insets.xs),
        StaticTextScale(
          child: Text(
            $strings.signInTitleHeading,
            style: $styles.textStyles.h1.copyWith(fontSize: 30 * $styles.scale, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
