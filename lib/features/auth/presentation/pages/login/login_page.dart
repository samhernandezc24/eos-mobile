import 'dart:convert';

import 'package:eos_mobile/core/constants/app_urls.dart';
import 'package:eos_mobile/core/validators/login_validator.dart';
import 'package:eos_mobile/features/auth/presentation/widgets/wave_container.dart';
import 'package:eos_mobile/ui/common/eos_logo.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Limpia el controlador cuando el widget es removido del
    // árbol de widgets.
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final email = _emailController.text;
    final password = _passwordController.text;

    try {
      final response = await http.post(
        Uri.parse('${AppUrls.aspNetUserApiBaseUrl}/LoginTreo'),
        body: json.encode({'email': email, 'password': password}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', data['token'].toString());
        await prefs.setString('id', data['id'].toString());
        await prefs.setString('key', data['key'].toString());
        await prefs.setString('nombre', data['nombre'].toString());

        GoRouter.of(context).go('/');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.body),
            backgroundColor: Colors.red.shade300,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red.shade300,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.zero,
        height: size.height,
        child: Stack(
          children: <Widget>[
            WaveContainer(
              waveHeight: 450,
              containerColor: Theme.of(context).primaryColor.withOpacity(.8),
              containerHeight: 220,
              reverse: false,
            ),
            WaveContainer(
              waveHeight: 50,
              containerColor: Theme.of(context).primaryColor.withOpacity(.3),
              containerHeight: 180,
              reverse: true,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: size.height * .2),
                    const EOSLogo(
                      width: 82,
                    ),
                    const SizedBox(height: 12.5),
                    const Text(
                      'Iniciar Sesión',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 40),
                    Form(
                      key: _formKey,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text('Usuario'),
                            const SizedBox(height: 6),
                            TextFormField(
                              controller: _emailController,
                              decoration: const InputDecoration(
                                hintText: 'ejem@plo.com',
                                isDense: true,
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: LoginValidator.validateEmail,
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(height: 24),
                            const Text('Contraseña'),
                            const SizedBox(height: 6),
                            TextFormField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                isDense: true,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordVisible = !_isPasswordVisible;
                                    });
                                  },
                                  icon: FaIcon(
                                    _isPasswordVisible
                                        ? FontAwesomeIcons.eyeSlash
                                        : FontAwesomeIcons.eye,
                                  ),
                                ),
                              ),
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: !_isPasswordVisible,
                              validator: LoginValidator.validatePassword,
                              textInputAction: TextInputAction.done,
                            ),
                            GestureDetector(
                              onTap: () => context.go('/forgot-password'),
                              child: Container(
                                alignment: Alignment.centerRight,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: Text(
                                  '¿Has olvidado tu contraseña?',
                                  style: TextStyle(
                                    color: Theme.of(context).indicatorColor,
                                  ),
                                ),
                              ),
                            ),
                            FilledButton(
                              onPressed: login,
                              style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all(
                                  const Size(double.infinity, 48),
                                ),
                              ),
                              child: const Text(
                                'Ingresar',
                                style: TextStyle(fontSize: 16),
                              ),
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
