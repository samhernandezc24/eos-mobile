import 'package:flutter/cupertino.dart';

class PageRoutesUtils {
  static const Duration kDefaultDuration = Duration(milliseconds: 300);

  static Route<T> dialog<T>(Widget child, {Duration duration = kDefaultDuration, bool opaque = false}) {
    // Utilizar las rutas de Cupertino en todos los diálogos para obtener el comportamiento "deslizar a la derecha para volver".
    if (opaque) {
      return CupertinoPageRoute(builder: (_) => child);
    }

    // SB: Elimina esto en favor de las rutas de Cupertino, podríamos restaurar con una opción `useFade`.
    return PageRouteBuilder(
      transitionDuration: duration,
      reverseTransitionDuration: duration,
      pageBuilder: (context, animation, secondaryAnimation) => child,
      opaque: opaque,
      fullscreenDialog: true,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
    );
  }
}
