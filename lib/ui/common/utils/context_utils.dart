import 'package:flutter/material.dart';

class ContextUtils {
  /// Obtiene la posición global del widget en el contexto dado.
  static Offset? getGlobalPosition(BuildContext context, [Offset offset = Offset.zero]) {
    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox?.hasSize ?? false) {
      return renderBox?.localToGlobal(offset);
    }
    return null;
  }

  /// Obtiene el tamaño del widget en el contexto dado.
  static Size? getSize(BuildContext context) {
    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox?.hasSize ?? false) {
      return renderBox?.size;
    }
    return null;
  }
}
