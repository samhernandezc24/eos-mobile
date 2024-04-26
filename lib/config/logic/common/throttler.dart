import 'dart:async';

import 'package:eos_mobile/shared/shared_libraries.dart';

class Throttler {
  Throttler(this.interval);

  final Duration interval;
  VoidCallback? _action;
  Timer? _timer;

  /// Llama a la acción.
  ///
  /// Si [immediateCall] es true, la acción se ejecutará inmediatamente
  /// después de establecerla.
  void call(VoidCallback action, {bool immediateCall = true}) {
    // La última acción anula las anteriores.
    _action = action;

    // Si no hay ningún temporizador activo, iniciamos uno.
    if (_timer == null) {
      // Si immediateCall es true, manejamos la acción
      if (immediateCall) {
        _callAction();
      }

      // Iniciar el temporizador que temporalmente acelere las llamadas posteriores, y
      // finalmente hará una llamada a lo que sea _action (si es que hay algo)
      _timer = Timer(interval, _callAction);
    }
  }

  /// Ejecuta la acción y reinicia el temporizador si es necesario.
  void _callAction() {
    _action?.call();  // Si tenemos una acción en cola, la completamos.
    _action = null;   // Una vez se ha llamado la acción, no la volvemos a llamar a menos que otra acción este en la cola.
    _timer  = null;
  }

  /// Cancela la acción actualmente programada.
  void reset() {
    _action = null;
    _timer  = null;
  }
}
