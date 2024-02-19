import 'package:eos_mobile/config/styles/app_styles.dart';
import 'package:eos_mobile/config/themes/app_theme.dart';
import 'package:eos_mobile/features/auth/presentation/pages/sign_in/sign_in_page.dart';
import 'package:eos_mobile/shared/shared.dart';

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  static AppStyle get style => _style;
  static final AppStyle _style = AppStyle();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EOS Mobile',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      home: const SignInPage(),
    );
  }
}
