import 'package:eos_mobile/core/functions/style_string.dart';

extension StringExtension on String {
  /// Retorna el String con el primer carácter en mayúscula (capitalized).
  /// 
  /// Ejemplo:
  /// ```dart
  ///   print("IVANA".toCapitalized());
  ///   => "Ivana"
  /// ```
  String toCapitalized() => StyleString.toCapitalized(this);

  /// Convierte el String a mayúsculas y minúsculas poniendo en mayúscula
  /// la primera letra de cada palabra y forzando todos los demás caracteres
  /// a minúsculas.
  /// 
  /// Ejemplo:
  /// ```dart
  ///   print("foo bar".toProperCase());
  ///   => "Foo Bar"
  /// ```
  String toProperCase() => StyleString.toProperCase(this);
}
