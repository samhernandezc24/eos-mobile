import 'package:eos_mobile/core/utils/style_strings_utils.dart';

extension StringExtension on String {
  /// Retorna el String con el primer carácter en mayúscula (capitalized).
  ///
  /// Ejemplo:
  /// ```dart
  ///   print("IVANA".toCapitalized());
  ///   => "Ivana"
  /// ```
  String toCapitalized() => StyleStringsUtils.toCapitalized(this);

  /// Convierte el String a mayúsculas y minúsculas poniendo en mayúscula
  /// la primera letra de cada palabra y forzando todos los demás caracteres
  /// a minúsculas.
  ///
  /// Ejemplo:
  /// ```dart
  ///   print("foo bar".toProperCase());
  ///   => "Foo Bar"
  /// ```
  String toProperCase() => StyleStringsUtils.toProperCase(this);
}
