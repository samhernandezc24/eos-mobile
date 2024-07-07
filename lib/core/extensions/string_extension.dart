import 'package:eos_mobile/core/constants/globals.dart';

extension StringExtension on String {
  /// Retorna una cadena en el formato PascalCase para
  /// definir mayúsculas y minúsculas.
  ///
  /// Ejemplo:
  /// ```dart
  ///   print("IVANA LOVE".toProperCase());
  ///   => "Ivana Love"
  /// ```
  String toProperCase() => Globals.properCase(this);
}
