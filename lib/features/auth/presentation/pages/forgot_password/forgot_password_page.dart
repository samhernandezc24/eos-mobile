import 'package:eos_mobile/shared/shared.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  // LISTENERS
  final GlobalKey<FormState> _formKey           = GlobalKey<FormState>();
  final TextEditingController _emailController  = TextEditingController();

  @override
  void dispose() {
    // Limpia el controlador cuando se elimina el widget.
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text($strings.forgotPasswordAppBarText,style: $styles.textStyles.h3),
      ),
      body: SizedBox(
        height: size.height,
        child: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset(
                      SvgPaths.forgotPassword,
                      fit: BoxFit.cover,
                      width: size.width,
                      semanticsLabel: $strings.forgotPasswordSemanticImage,
                    ),
                    Text($strings.forgotPasswordMessage),
                    Form(
                      key: _formKey,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // CORREO ELECTRÓNICO
                            LabeledTextField(
                              controller: _emailController, 
                              labelText: 'Correo electrónico',
                              hintText: 'ejem@plo.com',
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.done,
                              validator: FormValidators.emailValidator,
                            ),

                            Gap($styles.insets.lg),

                            FilledButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all<Size?>(
                                  const Size(double.infinity, 48),
                                ),
                              ),
                              child: Text($strings.forgotPasswordButtonText, style: $styles.textStyles.button),
                            ),
                          ],
                        ),
                      ),
                    ),
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
