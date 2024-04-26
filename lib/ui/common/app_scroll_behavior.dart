import 'package:eos_mobile/config/logic/common/platform_info.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

class AppScrollBehavior extends ScrollBehavior {
  /// Agrega arrastre del ratón en plataformas de escritorio para facilitar las pruebas de respuesta.
  @override
  Set<PointerDeviceKind> get dragDevices {
    final devices = Set<PointerDeviceKind>.from(super.dragDevices);
    devices.add(PointerDeviceKind.mouse);
    return devices;
  }

  /// Utiliza la física de bouncing en todas las plataformas, encaja mejor con el diseño de la aplicación.
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) => const BouncingScrollPhysics();

  /// Aplica una [RawScrollbar] al widget hijo en plataformas de escritorio.
  @override
  Widget buildScrollbar(BuildContext context, Widget child, ScrollableDetails details) {
    if (PlatformInfo.isMobile) return child;
    return RawScrollbar(
      controller: details.controller,
      thumbVisibility: PlatformInfo.isDesktopOrWeb,
      thickness: 8,
      interactive: true,
      child: child,
    );
  }
}
