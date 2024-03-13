import 'package:flutter/material.dart';

class ContextUtils {
  /// Obtiene la posición global del widget en el contexto dado.
  static Offset? getGlobalPosition(BuildContext context, [Offset offset = Offset.zero]) {
    final objRenderBox = context.findRenderObject() as RenderBox?;
    if (objRenderBox?.hasSize ?? false) {
      return objRenderBox?.localToGlobal(offset);
    }
    return null;
  }

  /// Obtiene el tamaño del widget en el contexto dado.
  static Size? getSize(BuildContext context) {
    final objRenderBox = context.findRenderObject() as RenderBox?;
    if (objRenderBox?.hasSize ?? false) {
      return objRenderBox?.size;
    }
    return null;
  }
}
