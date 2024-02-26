import 'package:eos_mobile/core/common/pages/errors/error_404_page.dart';
import 'package:eos_mobile/features/auth/presentation/pages/forgot_password/forgot_password_page.dart';
import 'package:eos_mobile/features/auth/presentation/pages/sign_in/sign_in_page.dart';
import 'package:eos_mobile/features/home/presentation/home_page.dart';
import 'package:eos_mobile/features/inspecciones/presentation/pages/index/index_page.dart';
import 'package:eos_mobile/shared/shared.dart';

class ScreenPaths {
  static String home = '/home';
  static String welcome = '/welcome';
  static String signIn = '/sign-in';
  static String settings = '/settings';

  static String inspeccionTipo        = '$settings/inspecciones-tipo';
  static String inspeccionTipoCreate  = '$inspeccionTipo/create';

  static String inspeccionesIndex   = '/inspecciones';
  static String inspeccionesList    = '$inspeccionesIndex/list';

  static String inspeccionDetails(String id) => _appendToCurrentPath('$inspeccionesIndex/$id');

  static String _appendToCurrentPath(String newPath) {
    final newPathUri = Uri.parse(newPath);
    final currentUri = appRouter.routeInformationProvider.value.uri;
    final Map<String, dynamic> params = Map.of(currentUri.queryParameters);
    // ignore: cascade_invocations
    params.addAll(newPathUri.queryParameters);
    final Uri location = Uri(
      path: '${currentUri.path}/${newPathUri.path}'.replaceAll('//', '/'),
      queryParameters: params,
    );
    return location.toString();
  }
}

final GoRouter appRouter = GoRouter(
  redirect: _handleRedirect,
  errorPageBuilder: (context, state) => const MaterialPage(
    child: Error404Page(),
  ),
  routes: [
    ShellRoute(
      builder: (context, router, navigator) {
        return AppScaffold(child: navigator);
      },
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (context, state) {
            return const MaterialPage(child: HomePage());
          },
          routes: [
            GoRoute(
              path: 'inspecciones',
              pageBuilder: (context, state) {
                return CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: const InspeccionIndexPage(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: '/sign-in',
          pageBuilder: (context, state) {
            return const MaterialPage(child: AuthSignInPage());
          },
        ),
        GoRoute(
          path: '/forgot-password',
          pageBuilder: (context, state) {
            return const MaterialPage(child: ForgotPasswordPage());
          },
        ),
      ],
    ),
  ],
);

String? get initialDepplink => _initialDeeplink;
String? _initialDeeplink;

Future<String?> _handleRedirect(
  BuildContext context,
  GoRouterState state,
) async {
  const secureStorage = FlutterSecureStorage();
  final accessToken = await secureStorage.read(key: 'access_token');

  if (accessToken != null && accessToken.isNotEmpty) {
    debugPrint('Redireccionando desde ${state.uri.path} hasta el HomePage');
    return '/';
  } else {
    debugPrint('Redireccionando desde ${state.uri.path} hasta el LoginPage');
    return '/sign-in';
  }
}
