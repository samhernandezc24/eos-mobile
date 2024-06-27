import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

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
  // Iterable<T> options,
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

typedef PredictiveOptions<T extends Object> = Iterable<T>;

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
    required this.lstRows,
    Key? key,
    this.predictiveOptionsViewOpenDirection   = PredictiveOptionsViewOpenDirection.down,
    this.displayStringForOption               = defaultStringForOption,
    this.fieldViewBuilder,
    this.focusNode,
    this.onSelected,
    this.textEditingController,
    this.initialValue,
  }) : super(key: key);

  final PredictiveFieldViewBuilder? fieldViewBuilder;
  final FocusNode? focusNode;
  final PredictiveOptionsViewBuilder<T> optionsViewBuilder;
  final PredictiveOptionsViewOpenDirection predictiveOptionsViewOpenDirection;
  final PredictiveOptionToString<T> displayStringForOption;
  final PredictiveOnSelected<T>? onSelected;
  final PredictiveOptions<T> lstRows;
  final TextEditingController? textEditingController;
  final TextEditingValue? initialValue;

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
  // GLOBAL KEY
  final GlobalKey _fieldKey = GlobalKey();

  // LAYER LINK
  final LayerLink _optionsLayerLink = LayerLink();

  // CONTROLLER
  late TextEditingController _textEditingController;

  // PROPERTIES
  late FocusNode _focusNode;
  late final Map<Type, Action<Intent>> _actionMap;
  late final _PredictiveCallbackAction<PredictivePreviousOptionIntent> _previousOptionAction;
  late final _PredictiveCallbackAction<PredictiveNextOptionIntent> _nextOptionAction;
  late final _PredictiveCallbackAction<DismissIntent> _hideOptionsAction;
  T? _selection;
  OverlayEntry? _floatingOptions;

  // ITERABLE
  Iterable<T> _options = Iterable<T>.empty();

  bool _userHideOptions                 = false;
  bool _hasError                        = false;
  bool _floatingOptionsUpdateScheduled  = false;

  final ValueNotifier<int> _highlightedOptionIndex = ValueNotifier<int>(0);

  static const Map<ShortcutActivator, Intent> _shortcuts = <ShortcutActivator, Intent>{
    SingleActivator(LogicalKeyboardKey.arrowUp)   : PredictivePreviousOptionIntent(),
    SingleActivator(LogicalKeyboardKey.arrowDown) : PredictiveNextOptionIntent(),
  };

  // True si el estado indica que las opciones deben ser visibles.
  bool get _shouldShowOptions {
    return !_userHideOptions && _focusNode.hasFocus && _selection == null && _options.isNotEmpty;
  }

  // STATE
  @override
  void initState() {
    super.initState();
    _textEditingController = widget.textEditingController ?? TextEditingController.fromValue(widget.initialValue);
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onChangedFocus);
    _previousOptionAction = _PredictiveCallbackAction<PredictivePreviousOptionIntent>(onInvoke: _highlightPreviousOption);
    _nextOptionAction     = _PredictiveCallbackAction<PredictiveNextOptionIntent>(onInvoke: _highlightNextOption);
    _hideOptionsAction    = _PredictiveCallbackAction<DismissIntent>(onInvoke: _hideOptions);
    _actionMap = <Type, Action<Intent>> {
      PredictivePreviousOptionIntent  : _previousOptionAction,
      PredictiveNextOptionIntent      : _nextOptionAction,
      DismissIntent                   : _hideOptionsAction,
    };
    _updateActions();
    _updateOverlay();
  }

  @override
  void didUpdateWidget(RawPredictive<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateFocusNode(oldWidget.focusNode, widget.focusNode);
    _updateActions();
    _updateOverlay();
  }

  @override
  void dispose() {
    if (widget.textEditingController == null) { _textEditingController.dispose(); }
    _focusNode.removeListener(_onChangedFocus);
    if (widget.focusNode == null) { _focusNode.dispose(); }
    _floatingOptions?.remove();
    _floatingOptions?.dispose();
    _floatingOptions = null;
    _highlightedOptionIndex.dispose();
    super.dispose();
  }

  // EVENTS
  Future<void> _on() async {
  }
  void _updateOptions(Iterable<T> newOptions) {
    setState(() {
      _options          = newOptions;
      _userHideOptions  = false;
    });
    _updateActions();
    _updateOverlay();
  }

  // Se llama cuando cambia el FocusNode del campo.
  void _onChangedFocus() {
    // Las opciones ya no deberían ocultarse cuando se reenfoca el campo.
    _userHideOptions = !_focusNode.hasFocus;
    _updateActions();
    _updateOverlay();
  }

  // Llamado desde fieldViewBuilder cuando el usuario envía el campo.
  void _onFieldSubmitted() {
    if (_options.isEmpty || _userHideOptions) { return; }
    _select(_options.elementAt(_highlightedOptionIndex.value));
  }

  // METHODS

  // Selecciona la opción dada y actualiza el widget.
  void _select(T nextSelection) {
    if (nextSelection == _selection) { return; }
    _selection = nextSelection;

    final String selectionString = widget.displayStringForOption(nextSelection);
    _textEditingController.value = TextEditingValue(
      selection : TextSelection.collapsed(offset: selectionString.length),
      text      : selectionString,
    );

    _updateActions();
    _updateOverlay();
    widget.onSelected?.call(_selection!);
  }

  void _updateHighlight(int newIndex) {
    _highlightedOptionIndex.value = _options.isEmpty ? 0 : newIndex % _options.length;
  }

  void _highlightPreviousOption(PredictivePreviousOptionIntent intent) {
    if (_userHideOptions) {
      _userHideOptions = false;
      _updateActions();
      _updateOverlay();
      return;
    }
    _updateHighlight(_highlightedOptionIndex.value - 1);
  }

  void _highlightNextOption(PredictiveNextOptionIntent intent) {
    if (_userHideOptions) {
      _userHideOptions = false;
      _updateActions();
      _updateOverlay();
      return;
    }
    _updateHighlight(_highlightedOptionIndex.value + 1);
  }

  Object? _hideOptions(DismissIntent intent) {
    if (!_userHideOptions) {
      _userHideOptions = true;
      _updateActions();
      _updateOverlay();
      return null;
    }
    return Actions.invoke(context, intent);
  }

  void _setActionsEnabled(bool enabled) {
    // El estado activado determina si la acción consumirá el
    // atajo de teclado o dejará que continúe en el campo de texto subyacente.
    // Sólo deben estar habilitadas cuando las opciones se muestran para que los atajos
    // puedan navegar a ellas.
    _previousOptionAction.enabled   = enabled;
    _nextOptionAction.enabled       = enabled;
    _hideOptionsAction.enabled      = enabled;
  }

  void _updateActions() {
    _setActionsEnabled(_focusNode.hasFocus && _selection == null && _options.isNotEmpty);
  }

  // Ocultar o mostrar el overlay de opciones, si es necesario.
  void _updateOverlay() {
    if (SchedulerBinding.instance.schedulerPhase == SchedulerPhase.persistentCallbacks) {
      if (!_floatingOptionsUpdateScheduled) {
        _floatingOptionsUpdateScheduled = true;

        SchedulerBinding.instance.addPostFrameCallback(
          (Duration timeStamp) {
            _floatingOptionsUpdateScheduled = false;
            _updateOverlay();
          },
          debugLabel: 'RawPredictive.updateOverlay',
        );
      }
      return;
    }

    // Eliminamos y liberamos la entrada actual de overlay si existe.
    _floatingOptions?.remove();
    _floatingOptions?.dispose();

    if (_shouldShowOptions) {
      final OverlayEntry newFloatingOptions = OverlayEntry(
        builder: (BuildContext context) {
          return CompositedTransformFollower(
            link: _optionsLayerLink,
            showWhenUnlinked: false,
            targetAnchor: switch (widget.predictiveOptionsViewOpenDirection) {
              PredictiveOptionsViewOpenDirection.up   => Alignment.topLeft,
              PredictiveOptionsViewOpenDirection.down => Alignment.bottomLeft,
            },
            followerAnchor: switch (widget.predictiveOptionsViewOpenDirection) {
              PredictiveOptionsViewOpenDirection.up   => Alignment.bottomLeft,
              PredictiveOptionsViewOpenDirection.down => Alignment.topLeft,
            },
            child: TextFieldTapRegion(
              child: PredictiveHighlightedOption(
                highlightedIndexNotifier: _highlightedOptionIndex,
                child: Builder(
                  builder: (BuildContext context) {
                    if (_hasError) {
                      return const Text('Error');
                    }
                    return widget.optionsViewBuilder(context, _select);
                    // return widget.optionsViewBuilder(context, _select, _options);
                  },
                ),
              ),
            ),
          );
        },
      );
      Overlay.of(context, rootOverlay: true, debugRequiredFor: widget).insert(newFloatingOptions);
      _floatingOptions = newFloatingOptions;
    } else {
      _floatingOptions = null;
    }
  }

  // Maneja un cambio potencial en focusNode disponiendo adecuadamente del antiguo
  // y configurando el nuevo, si es necesario.
  void _updateFocusNode(FocusNode? old, FocusNode? current) {
    if ((old == null && current == null) || old == current) { return; }
    if (old == null) {
      _focusNode.removeListener(_onChangedFocus);
      _focusNode.dispose();
      _focusNode = current!;
    } else if (current == null) {
      _focusNode.removeListener(_onChangedFocus);
      _focusNode = FocusNode();
    } else {
      _focusNode.removeListener(_onChangedFocus);
      _focusNode = current;
    }
    _focusNode.addListener(_onChangedFocus);
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldTapRegion(
      child: Container(
        key: _fieldKey,
        child: Shortcuts(
          shortcuts: _shortcuts,
          child: Actions(
            actions: _actionMap,
            child: CompositedTransformTarget(
              link: _optionsLayerLink,
              child: widget.fieldViewBuilder == null
                  ? const SizedBox.shrink()
                  : widget.fieldViewBuilder!(
                      context,
                      _textEditingController,
                      _focusNode,
                      _onFieldSubmitted,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PredictiveCallbackAction<T extends Intent> extends CallbackAction<T> {
  _PredictiveCallbackAction({
    required super.onInvoke,
    this.enabled = true,
  });

  bool enabled;

  @override
  bool isEnabled(covariant T intent) => enabled;

  @override
  bool consumesKey(covariant T intent) => enabled;
}

/// Un [Intent] para resaltar la opción anterior en la lista del predictivo.
class PredictivePreviousOptionIntent extends Intent {
  const PredictivePreviousOptionIntent();
}

/// Un [Intent] para resaltar la opción siguiente en la lista del predictivo.
class PredictiveNextOptionIntent extends Intent {
  const PredictiveNextOptionIntent();
}

class PredictiveHighlightedOption extends InheritedNotifier<ValueNotifier<int>> {
  const PredictiveHighlightedOption({
    required ValueNotifier<int> highlightedIndexNotifier,
    required super.child,
    super.key,
  }) : super(notifier: highlightedIndexNotifier);

  /// Devuelve el índice de la opción resaltada desde el más cercano
  /// [PredictiveHighlightedOption] más cercana.
  static int of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<PredictiveHighlightedOption>()?.notifier?.value ?? 0;
  }
}
