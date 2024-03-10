import 'dart:ui';

import 'package:eos_mobile/config/logic/common/platform_info.dart';
import 'package:eos_mobile/shared/shared.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';

class AppLogic {
  Size _appSize = Size.zero;

  /// Indica al resto de la aplicación que el bootstrap no se ha completado.
  /// El router lo utilizará para evitar redirecciones durante el bootstrap.
  bool isBootstrapComplete = false;

  /// Indica qué orientaciones permitirá la aplicación por defecto.
  /// Sólo afecta a dispositivos Android/iOS.
  ///
  /// Por defecto tanto horizontal como vertical.
  List<Axis> supportedOrientations = [Axis.vertical, Axis.horizontal];

  /// Permitir que una vista anule las orientaciones actualmente soportadas.
  ///
  /// Si una vista establece esta anulación, es responsable de retornarla a null
  /// cuando termine.
  List<Axis>? _supportedOrientationsOverride;
  // ignore: avoid_setters_without_getters
  set supportedOrientationsOverride(List<Axis>? value) {
    if (_supportedOrientationsOverride != value) {
      _supportedOrientationsOverride = value;
      _updateSystemOrientation();
    }
  }

  /// Inicializa la aplicación y toda la lógica de negocio.
  Future<void> bootstrap() async {
    debugPrint('bootstrap start...');

    // Ajustar la frecuencia de refresh deseada al máximo posible
    // (el sistema operativo puede ignorar esto).
    if (!kIsWeb && PlatformInfo.isAndroid) {
      await FlutterDisplayMode.setHighRefreshRate();
    }

    // Configuraciones
    await settingsLogic.load();

    // Marcar bootstrap como completado.
    isBootstrapComplete = true;

    // Cargar vista inicial (sustituir la vista inicial vacía que está cubierta 
    // por una pantalla de inicio nativa).
    final bool showIntro = settingsLogic.hasCompletedOnboarding.value == false;
    if (showIntro) {
      appRouter.go('/welcome');
    } else {
      appRouter.go(initialDeeplink ?? '/');
    }
  }

  /// Evento de llamado desde la capa UI una vez se ha obtenido un MediaQuery.
  void handleAppSizeChanged(Size appSize) {
    /// Desactivar la disposición horizontal en formatos pequeños.
    final bool isSmall    = display.size.shortestSide / display.devicePixelRatio < 600;
    supportedOrientations = isSmall ? [Axis.vertical] : [Axis.vertical, Axis.horizontal];

    _updateSystemOrientation();
    _appSize = appSize;
  }

  Display get display => PlatformDispatcher.instance.displays.first;

  bool shouldUseNavRail() => _appSize.width > _appSize.height && _appSize.height > 250;

  void _updateSystemOrientation() {
    final lstAxis = _supportedOrientationsOverride ?? supportedOrientations;
    debugPrint('updateDeviceOrientation, supportedAxis: $lstAxis');

    final orientations = <DeviceOrientation>[];
    if (lstAxis.contains(Axis.vertical)) {
      orientations.addAll([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }

    if (lstAxis.contains(Axis.horizontal)) {
       orientations.addAll([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    }

    SystemChrome.setPreferredOrientations(orientations);
  }
}
