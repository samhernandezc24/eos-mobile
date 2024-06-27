import 'package:flutter/material.dart';

/// El tipo de callback utilizada por el widget [RawPredictive] para indicar
/// que el usuario ha seleccionado una opción.
typedef PredictiveOnSelected<T extends Object> = void Function(T option);

/// El tipo de callback [RawPredictive] que devuelve un [Widget] que
/// muestra las [PredictiveOptions] especificadas y llama a [onSelected]
/// si el usuario selecciona una opción.
///
/// El widget devuelto por este callback será envuelto en un
/// widget heredado [PredictiveHighlightedOption]. Esto permitirá a
/// este callback determinar qué opción está actualmente resaltada para
/// navegación por teclado.
typedef PredictiveOptionsViewBuilder<T extends Object> = Widget Function(
  BuildContext context,
  PredictiveOnSelected<T> onSelected,
  List<T> options,
);

/// El tipo de callback del PredictiveSearchField que devuelve el widget que
/// contiene el input [TextField] o [TextFormField].
typedef PredictiveFieldViewBuilder = Widget Function(
  BuildContext context,
  TextEditingController textEditingController,
  FocusNode focusNode,
  VoidCallback onFieldSubmitted,
);

/// El tipo de callback [RawPredictive] que convierte un valor de opción a
/// una cadena que puede mostrarse en el menú de opciones del widget.
typedef PredictiveOptionToString<T extends Object> = String Function(T option);

/// Una dirección en la que abrir el overlay de la vista de opciones.
enum PredictiveOptionsViewOpenDirection {
  /// Abierto hacia arriba.
  ///
  /// El borde inferior de la vista de opciones se alineará con el borde superior
  /// del campo de texto construido por [RawPredictive.fieldViewBuilder].
  up,
  /// Abierto hacia abajo.
  ///
  /// El borde superior de la vista de opciones se alineará con el borde inferior
  /// del campo de texto construido por [RawPredictive.fieldViewBuilder].
  down,
}

class RawPredictive<T extends Object> extends StatefulWidget {
  const RawPredictive({
    required this.optionsViewBuilder,
    super.key,
    this.optionsViewOpenDirection   = PredictiveOptionsViewOpenDirection.down,
    this.displayStringForOption     = defaultStringForOption,
    this.fieldViewBuilder,
    this.onSelected,
    this.focusNode,
  });

  final PredictiveFieldViewBuilder? fieldViewBuilder;
  final FocusNode? focusNode;
  final PredictiveOptionsViewBuilder<T> optionsViewBuilder;
  final PredictiveOptionsViewOpenDirection optionsViewOpenDirection;
  final PredictiveOptionToString<T> displayStringForOption;
  final PredictiveOnSelected<T>? onSelected;

  /// La manera por defecto de convertir una opción en una cadena en
  /// [displayStringForOption].
  ///
  /// Utiliza el método `toString` de la `option` dada.
  static String defaultStringForOption(Object? option) {
    return option.toString();
  }

  @override
  State<RawPredictive<T>> createState() => _RawPredictiveState<T>();
}

class _RawPredictiveState<T extends Object> extends State<RawPredictive<T>> {
  // CONTROLLER
  late TextEditingController _textEditingController;

  // PROPERTIES
  late FocusNode _focusNode;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
