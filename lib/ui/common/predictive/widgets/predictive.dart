import 'package:eos_mobile/core/enums/predictive_view_open_direction.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:flutter/scheduler.dart';

/// El tipo de callback utilizado por el widget [RawPredictive] para indicar
/// que el usuario ha seleccionado una opción.
///
///
/// Ver también:
///
/// * [RawPredictive.onSelected], que es de este tipo.
typedef PredictiveOnSelected<T extends Object> = void Function(T option);

/// El tipo de callback [RawPredictive] que retorna un [Widget] que
/// muestra las [options] especificadas y llama a [onSelected] si el usuario
/// selecciona una opción.
///
/// El widget retornado por este callback será envuelto en un
/// widget heredado [PredictiveHighlightOption]. Esto permitirá a
/// este callback determinar qué opción está actualmente resaltada para
/// navegación por teclado.
///
/// Ver también:
///
/// * [RawPredictive.optionsViewBuilder], que es de este tipo.
typedef PredictiveOptionsViewBuilder<T extends Object> = Widget Function(
  BuildContext context,
  PredictiveOnSelected<T> onSelected,
  Iterable<T> options,
);

/// El tipo de la callback de Predictive que devuelve el widget que
/// contiene la entrada [TextField].
///
/// Ver también:
///
/// * [RawPredictive.fieldViewBuilder], que es de este tipo.
typedef PredictiveFieldViewBuilder = Widget Function(
  BuildContext context,
  TextEditingController textController,
  FocusNode focusNode,
  VoidCallback onSubmit,
);

/// El tipo de callback [RawPredictive] que convierte un valor de opción a
/// una cadena que puede mostrarse en el menú de opciones del widget.
///
/// Ver también:
///
/// * [RawPredictive.displayStringForOption], que es de este tipo.
typedef PredictiveOptionToString<T extends Object> = String Function(T option);

class RawPredictive<T extends Object> extends StatefulWidget {
  const RawPredictive({
    required this.optionsViewBuilder,
    Key? key,
    this.optionsViewOpenDirection     = PredictiveViewOpenDirection.down,
    this.displayStringForOption       = defaultStringForOption,
    this.fieldViewBuilder,
    this.focusNode,
    this.onSelected,
    this.textController,
    this.initialValue,
  }) : super(key: key);

  final PredictiveFieldViewBuilder? fieldViewBuilder;
  final FocusNode? focusNode;
  final PredictiveOptionsViewBuilder<T> optionsViewBuilder;
  final PredictiveViewOpenDirection optionsViewOpenDirection;
  final PredictiveOptionToString<T> displayStringForOption;
  final PredictiveOnSelected<T>? onSelected;
  final TextEditingController? textController;
  final TextEditingValue? initialValue;

  static String defaultStringForOption(Object? option) {
    return option.toString();
  }

  @override
  State<RawPredictive> createState() => _RawPredictiveState<T>();
}

class _RawPredictiveState<T extends Object> extends State<RawPredictive<T>> {
  // INSTANCES
  final GlobalKey _fieldKey         = GlobalKey();
  final LayerLink _optionsLayerLink = LayerLink();

  // EVENT HANDLERS
  late TextEditingController _textEditingController;
  late FocusNode _focusNode;
  late final Map<Type, Action<Intent>> _actionsMap;
  late final _PredictiveCallbackAction<PredictivePreviousOptionIntent> _previousOptionAction;
  late final _PredictiveCallbackAction<PredictiveNextOptionIntent> _nextOptionAction;
  late final _PredictiveCallbackAction<DismissIntent> _hideOptionsAction;

  // PROPERTIES
  Iterable<T> _options                  = Iterable<T>.empty();
  bool _userHideOptions                 = false;
  bool _floatingOptionsUpdateScheduled  = false;
  String _lastFieldText                 = '';
  T? _selection;

  // NOTIFIERS
  final ValueNotifier<int> _highlightedOptionIndex = ValueNotifier<int>(0);

  static const Map<ShortcutActivator, Intent> _shortcuts = <ShortcutActivator, Intent>{
    SingleActivator(LogicalKeyboardKey.arrowUp)   : PredictivePreviousOptionIntent(),
    SingleActivator(LogicalKeyboardKey.arrowDown) : PredictiveNextOptionIntent(),
  };

  // El OverlayEntry que contiene las opciones.
  OverlayEntry? _floatingOptions;

  // True si el estado indica que las opciones deben ser visibles.
  bool get _shouldShowOptions {
    return !_userHideOptions && _focusNode.hasFocus && _selection == null && _options.isNotEmpty;
  }

  // STATE
  @override
  void initState() {
    super.initState();
    _textEditingController = widget.textController ?? TextEditingController.fromValue(widget.initialValue);
    _textEditingController.addListener(_onChangedField);
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onChangedFocus);
    _previousOptionAction   = _PredictiveCallbackAction<PredictivePreviousOptionIntent>(onInvoke: _highlightPreviousOption);
    _nextOptionAction       = _PredictiveCallbackAction<PredictiveNextOptionIntent>(onInvoke: _highlightNextOption);
    _hideOptionsAction      = _PredictiveCallbackAction<DismissIntent>(onInvoke: _hideOptions);
    _actionsMap             = <Type, Action<Intent>> {
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
    _updateTextEditingController(
      oldWidget.textController,
      widget.textController,
    );
    _updateActions();
    _updateOverlay();
  }

  @override
  void dispose() {
    _textEditingController.removeListener(_onChangedField);
    if (widget.textController == null) {
      _textEditingController.dispose();
    }
    _focusNode.removeListener(_onChangedFocus);
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    _floatingOptions?.remove();
    _floatingOptions?.dispose();
    _floatingOptions = null;
    _highlightedOptionIndex.dispose();
    super.dispose();
  }

  // METHODS
  void _updateTextEditingController(TextEditingController? old, TextEditingController? current) {
    if ((old == null && current == null) || old == current) {
      return;
    }
    if (old == null) {
      _textEditingController.removeListener(_onChangedField);
      _textEditingController.dispose();
      _textEditingController = current!;
    } else if (current == null) {
      _textEditingController.removeListener(_onChangedField);
      _textEditingController = TextEditingController();
    } else {
      _textEditingController.removeListener(_onChangedField);
      _textEditingController = current;
    }
    _textEditingController.addListener(_onChangedField);
  }

  void _updateFocusNode(FocusNode? old, FocusNode? current) {
    if ((old == null && current == null) || old == current) {
      return;
    }
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

  Future<void> _onChangedField() async {
    final TextEditingValue value = _textEditingController.value;
    _updateHighlight(_highlightedOptionIndex.value);
    if (_selection != null
        && value.text != widget.displayStringForOption(_selection!)) {
      _selection = null;
    }

    // Make sure the options are no longer hidden if the content of the field
    // changes (ignore selection changes).
    if (value.text != _lastFieldText) {
      _userHideOptions = false;
      _lastFieldText = value.text;
    }
    _updateActions();
    _updateOverlay();
  }

  void _onChangedFocus() {
    // Options should no longer be hidden when the field is re-focused.
    _userHideOptions = !_focusNode.hasFocus;
    _updateActions();
    _updateOverlay();
  }

  void _onFieldSubmitted() {
    if (_options.isEmpty || _userHideOptions) {
      return;
    }
    _select(_options.elementAt(_highlightedOptionIndex.value));
  }

  // Selecciona la opción indicada y actualiza el widget.
  void _select(T nextSelection) {
    if (nextSelection == _selection) {
      return;
    }
    _selection = nextSelection;
    final String selectionString = widget.displayStringForOption(nextSelection);
    _textEditingController.value = TextEditingValue(
      selection: TextSelection.collapsed(offset: selectionString.length),
      text: selectionString,
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
    _previousOptionAction.enabled   = enabled;
    _nextOptionAction.enabled       = enabled;
    _hideOptionsAction.enabled      = enabled;
  }

  void _updateActions() {
    _setActionsEnabled(_selection == null && _options.isNotEmpty);
  }

  // Ocultar o mostrar la superposición de opciones, si es necesario.
  void _updateOverlay() {
    if (SchedulerBinding.instance.schedulerPhase == SchedulerPhase.persistentCallbacks) {
      if (!_floatingOptionsUpdateScheduled) {
        _floatingOptionsUpdateScheduled = true;
        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          _floatingOptionsUpdateScheduled = false;
          _updateOverlay();
        });
      }
      return;
    }

    _floatingOptions?.remove();
    _floatingOptions?.dispose();
    if (_shouldShowOptions) {
      final OverlayEntry newFloatingOptions = OverlayEntry(
        builder: (BuildContext context) {
          return CompositedTransformFollower(
            link              : _optionsLayerLink,
            showWhenUnlinked  : false,
            targetAnchor      : switch (widget.optionsViewOpenDirection) {
              PredictiveViewOpenDirection.up    => Alignment.topLeft,
              PredictiveViewOpenDirection.down  => Alignment.bottomLeft,
            },
            followerAnchor    : switch (widget.optionsViewOpenDirection) {
              PredictiveViewOpenDirection.up    => Alignment.bottomLeft,
              PredictiveViewOpenDirection.down  => Alignment.topLeft,
            },
            child: PredictiveHighlightOption(
              highlightIndexNotifier  : _highlightedOptionIndex,
              child                   : Builder(
                builder: (BuildContext context) {
                  return widget.optionsViewBuilder(context, _select, _options);
                },
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

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _fieldKey,
      child: Shortcuts(
        shortcuts : _shortcuts,
        child     : Actions(
          actions: _actionsMap,
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

class PredictivePreviousOptionIntent extends Intent {
  const PredictivePreviousOptionIntent();
}

class PredictiveNextOptionIntent extends Intent {
  const PredictiveNextOptionIntent();
}

class PredictiveHighlightOption extends InheritedNotifier<ValueNotifier<int>> {
  /// Crea una instancia del widget heredado PredictiveHighlightOption.
  const PredictiveHighlightOption({
    required ValueNotifier<int> highlightIndexNotifier,
    required super.child,
    super.key,
  }) : super(notifier: highlightIndexNotifier);

  static int of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<PredictiveHighlightOption>()?.notifier?.value ?? 0;
  }
}
