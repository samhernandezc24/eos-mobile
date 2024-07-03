import 'dart:async';
import 'dart:ui';

import 'package:eos_mobile/config/logic/common/platform_info.dart';
import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:eos_mobile/ui/common/utils/page_routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';

class AppLogic {
  Size _appSize = Size.zero;

  /// Indica al resto de la aplicación que el bootstrap no se ha completado.
  /// El router lo utilizará para evitar redirecciones durante el bootstrap.
  bool isBootstrapComplete = false;

  /// Indica las orientaciones que permitirá la aplicación por defecto.
  /// Sólo afecta a dispositivos Android / iOS.
  /// Por defecto tanto horizontal(hz) como vertical(vt).
  List<Axis> supportedOrientations = <Axis>[ Axis.vertical, Axis.horizontal ];

  /// Permitir que una vista anule (override) las orientaciones actualmente soportadas.
  /// Si una vista establece este override, es responsable de retornarla a null cuando
  /// termine.
  List<Axis>? _supportedOrientationsOverride;
  List<Axis>? get supportedOrientationsOverride => _supportedOrientationsOverride;
  set supportedOrientationsOverride(List<Axis>? value) {
    if (_supportedOrientationsOverride != value) {
      _supportedOrientationsOverride = value;
      _updateSystemOrientation();
    }
  }

  /// Inicializa la aplicación y todos los actores principales.
  /// Carga las configuraciones iniciales de la aplicación, arranca
  /// los servicios, etc.
  Future<void> bootstrap() async {
    $logger.d('Inicializando aplicación...🚀');

    if (!kIsWeb && PlatformInfo.isAndroid) {
      await FlutterDisplayMode.setHighRefreshRate();
    }

    // SETTINGS
    await settingsLogic.load();

    // BOOTSTRAP COMPLETE
    isBootstrapComplete = true;

    // REDIRECTION
    final bool showWelcomePage = settingsLogic.hasCompletedOnboarding.value == false;
    if (showWelcomePage) {
      appRouter.go(AppRoutes.welcome);
    } else {
      appRouter.go(initialDeeplink ?? AppRoutes.authSignIn);
    }
  }

  Future<T?> showFullScreenDialogRoute<T>(BuildContext context, Widget child, {bool transparent = false}) async {
    return Navigator.of(context).push<T>(
      PageRoutes.dialog<T>(child, duration: const Duration(milliseconds: 400)),
    );
  }

  /// Evento que será llamado desde la capa de presentación una vez se haya obtenido un [MediaQuery].
  void handleAppSizeChanged(Size appSize) {
    // Desactivar la disposición horizontal en formatos pequeños.
    final bool isSmall    = display.size.shortestSide / display.devicePixelRatio < 600;
    supportedOrientations = isSmall ? <Axis>[ Axis.vertical ] : <Axis>[ Axis.vertical, Axis.horizontal ];
    _updateSystemOrientation();
    _appSize = appSize;
  }

  Display get display => PlatformDispatcher.instance.displays.first;

  bool shouldUserNavRail() => _appSize.width > _appSize.height && _appSize.height > 250;

  void _updateSystemOrientation() {
    final List<Axis> lstAxis = _supportedOrientationsOverride ?? supportedOrientations;
    // debugPrint('updateDeviceOrientation, supportedAxis: $lstAxis');
    final List<DeviceOrientation> orientations = <DeviceOrientation>[];
    if (lstAxis.contains(Axis.vertical)) {
      orientations.addAll([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    }
    if (lstAxis.contains(Axis.horizontal)) {
      orientations.addAll([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    }
    SystemChrome.setPreferredOrientations(orientations);
  }
}
