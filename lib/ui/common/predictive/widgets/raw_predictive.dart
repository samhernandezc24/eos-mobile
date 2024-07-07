part of '../predictive_search_form_field.dart';

typedef PredictiveOnSelected<T extends Object> = void Function(T option);

typedef PredictiveOptionToString<T extends Object> = String Function(T option);

typedef PredictiveFetchOptions<T extends Object> = Future<List<T>> Function(String query);

typedef PredictiveOptionsViewBuilder<T extends Object> = Widget Function(
  BuildContext context,
  PredictiveOnSelected<T> onSelected,
  List<T> options,
);

typedef PredictiveFieldViewBuilder = Widget Function(
  BuildContext context,
  TextEditingController textEditingController,
  VoidCallback onFieldSubmitted,
);

enum PredictiveOptionsViewOpenDirection {
  up,
  down,
}

class RawPredictive<T extends Object> extends StatefulWidget {
  const RawPredictive({
    required this.fetchOptions,
    required this.optionsViewBuilder,
    Key? key,
    this.optionsViewOpenDirection   = PredictiveOptionsViewOpenDirection.down,
    this.displayStringForOption     = defaultStringForOption,
    this.fieldViewBuilder,
    this.onSelected,
    this.textEditingController,
    this.initialValue,
  }) : super(key: key);

  final PredictiveFetchOptions<T> fetchOptions;
  final PredictiveFieldViewBuilder? fieldViewBuilder;
  final PredictiveOptionsViewBuilder<T> optionsViewBuilder;
  final PredictiveOptionsViewOpenDirection optionsViewOpenDirection;
  final PredictiveOptionToString<T> displayStringForOption;
  final PredictiveOnSelected<T>? onSelected;
  final TextEditingController? textEditingController;
  final TextEditingValue? initialValue;

  static void onFieldSubmitted<T extends Object>(GlobalKey key) {
    final _RawPredictiveState<T> rawPredictive = key.currentState! as _RawPredictiveState<T>;
    rawPredictive._onFieldSubmitted();
  }

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

  // CONTROLLERS
  late TextEditingController _textEditingController;
  late final Map<Type, Action<Intent>> _actionMap;
  late final _PredictiveCallbackAction<PredictivePreviousOptionIntent> _previousOptionAction;
  late final _PredictiveCallbackAction<PredictiveNextOptionIntent> _nextOptionAction;
  late final _PredictiveCallbackAction<DismissIntent> _hideOptionsAction;

  // LIST
  List<T> _options = <T>[];

  // PROPERTIES
  T? _selection;
  bool _userHideOptions                 = false;
  bool _floatingOptionsUpdateScheduled  = false;

  final ValueNotifier<int> _highlightedOptionIndex = ValueNotifier<int>(0);

  // OVERLAY ENTRY
  OverlayEntry? _floatingOptions;

  static const Map<ShortcutActivator, Intent> _shortcuts = <ShortcutActivator, Intent>{
    SingleActivator(LogicalKeyboardKey.arrowUp)   : PredictivePreviousOptionIntent(),
    SingleActivator(LogicalKeyboardKey.arrowDown) : PredictiveNextOptionIntent(),
  };

  bool get _shouldShowOptions {
    return !_userHideOptions && _selection == null && _options.isNotEmpty;
  }

  // STATE
  @override
  void initState() {
    super.initState();
    _textEditingController  = widget.textEditingController ?? TextEditingController.fromValue(widget.initialValue);
    _previousOptionAction   = _PredictiveCallbackAction<PredictivePreviousOptionIntent>(onInvoke: _highlightPreviousOption);
    _nextOptionAction       = _PredictiveCallbackAction<PredictiveNextOptionIntent>(onInvoke: _highlightNextOption);
    _hideOptionsAction      = _PredictiveCallbackAction<DismissIntent>(onInvoke: _hideOptions);
    _actionMap              = <Type, Action<Intent>> {
      AutocompletePreviousOptionIntent  : _previousOptionAction,
      AutocompleteNextOptionIntent      : _nextOptionAction,
      DismissIntent                     : _hideOptionsAction,
    };
    _updateActions();
    _updateOverlay();
  }

  @override
  void didUpdateWidget(RawPredictive<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateActions();
    _updateOverlay();
  }

  @override
  void dispose() {
    if (widget.textEditingController == null) {
      _textEditingController.dispose();
    }
    _floatingOptions?.remove();
    _floatingOptions?.dispose();
    _floatingOptions = null;
    _highlightedOptionIndex.dispose();
    super.dispose();
  }

  // EVENTS
  Future<void> _onFieldSubmitted() async {
    final query = _textEditingController.text;
    if (query.isNotEmpty) {
      final options = await widget.fetchOptions(query);
      setState(() {
        _options = options;
        _userHideOptions = false;
      });
      _updateActions();
      _updateOverlay();
    } else {
      setState(() {
        _options = [];
        _userHideOptions = true;
      });
      _updateOverlay();
    }
  }

  void _select(T nextSelection) {
    if (nextSelection == _selection) {
      return;
    }
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

  // METHODS
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

    _floatingOptions?.remove();
    _floatingOptions?.dispose();

    if (_shouldShowOptions) {
      final OverlayEntry newFloatingOptions = OverlayEntry(
        builder: (BuildContext context) {
          return CompositedTransformFollower(
            link: _optionsLayerLink,
            showWhenUnlinked: false,
            child: Builder(
              builder: (BuildContext context) {
                return widget.optionsViewBuilder(context, _select, _options);
              },
            ),
          );
        },
      );
      // Add the OverlayEntry to the Overlay.
      Overlay.of(context, rootOverlay: true, debugRequiredFor: widget).insert(newFloatingOptions);
      _floatingOptions = newFloatingOptions;
    } else {
      _floatingOptions = null;
    }
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

/// Un [Intent] para resaltar la opción anterior en la lista predictiva.
class PredictivePreviousOptionIntent extends Intent {
  const PredictivePreviousOptionIntent();
}

/// Un [Intent] para resaltar la opción siguiente en la lista predictiva.
class PredictiveNextOptionIntent extends Intent {
  const PredictiveNextOptionIntent();
}

/// Un widget heredado utilizado para indicar qué opción del predictivo debe ser
/// resaltada para la navegación por teclado.
///
/// El widget `RawPredictive` envolverá la vista de opciones generada por el
/// `optionsViewBuilder` con este widget para proporcionar el índice
/// de la opción resaltada al constructor.
///
/// En la llamada de retorno del constructor el índice de la opción resaltada puede obtenerse
/// utilizando el método estático [of]:
///
/// ```dart
/// int highlightedIndex = AutocompleteHighlightedOption.of(context);
/// ```
///
/// que luego se puede utilizar para decir qué opción debe recibir una indicación visual
/// indicación visual que será la opción seleccionada con el teclado.
class PredictiveHighlightedOption extends InheritedNotifier<ValueNotifier<int>> {
  const PredictiveHighlightedOption({
    required ValueNotifier<int> highlightIndexNotifier,
    required super.child,
    super.key,
  }) : super(notifier: highlightIndexNotifier);

  static int of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<PredictiveHighlightedOption>()?.notifier?.value ?? 0;
  }
}
