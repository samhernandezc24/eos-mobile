import 'dart:async';

import 'package:flutter/material.dart';

class Debouncer {
  Debouncer(this.interval);

  final Duration interval;
  VoidCallback? _action;
  Timer? _timer;

  /// Llama a la acción.
  void call(VoidCallback action) {
    // La última acción anula las anteriores.
    _action = action;

    // Siempre cancelar y reiniciar el temporizador.
    _timer?.cancel();

    // Iniciar el temporizador que temporalmente acelere las llamadas posteriores, y
    // finalmente hará una llamada a lo que sea _action (si es que hay algo)
    _timer = Timer(interval, _callAction);
  }

  /// Ejecuta la acción y reinicia el temporizador si es necesario.
  void _callAction() {
    _action?.call(); // Si tenemos una acción en cola, la completamos.
    _action = null; // Una vez se ha llamado la acción, no la volvemos a llamar a menos que otra acción este en la cola.
  }

  /// Cancela la acción actualmente programada.
  void reset() {
    _action = null;
    _timer  = null;
  }
}
