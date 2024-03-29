import 'package:flutter/cupertino.dart';

class PageRoutesUtils {
  static Route<T> dialog<T>(Widget child, {Duration duration = const Duration(milliseconds: 300), bool opaque = false}) {
    // Utilizar las rutas de Cupertino en todos los diálogos para obtener el comportamiento
    // "deslizar a la derecha para volver".
    if (opaque) {
      return CupertinoPageRoute<T>(builder: (_) => child);
    }

    // SB: Eliminar esto en favor de las rutas de Cupertino, podríamos restaurar con una opción `useFade`.
    // Aún no estoy seguro si esto sería viable o al menos útil.
    return PageRouteBuilder<T>(
      transitionDuration: duration,
      reverseTransitionDuration: duration,
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => child,
      opaque: opaque,
      fullscreenDialog: true,
      transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) =>
          FadeTransition(opacity: animation, child: child),
    );
  }
}
