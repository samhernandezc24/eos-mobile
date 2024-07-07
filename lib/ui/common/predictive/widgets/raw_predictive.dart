part of '../predictive_search_form_field.dart';

typedef PredictiveOptionsBuilder<T extends Object> = FutureOr<List<T>> Function(TextEditingValue textEditingValue);

typedef PredictiveOnSelected<T extends Object> = void Function(T option);

typedef PredictiveOptionsViewBuilder<T extends Object> = Widget Function(
  BuildContext context,
  PredictiveOnSelected<T> onSelected,
  List<T> options,
);

typedef PredictiveFieldViewBuilder = Widget Function(
  BuildContext context,
  TextEditingController textEditingController,
  FocusNode focusNode,
  VoidCallback onFieldSubmitted,
);

typedef PredictiveOptionToString<T extends Object> = String Function(T option);

enum PredictiveOptionsViewOpenDirection {
  up,
  down,
}


class RawPredictive<T extends Object> extends StatefulWidget {
  const RawPredictive({
    required this.optionsViewBuilder,
    required this.optionsBuilder,
    Key? key,
    this.optionsViewOpenDirection   = PredictiveOptionsViewOpenDirection.down,
    this.displayStringForOption     = defaultStringForOption,
    this.fieldViewBuilder,
    this.focusNode,
    this.onSelected,
    this.textEditingController,
    this.initialValue,
  }) : super(key: key);

  final PredictiveFieldViewBuilder? fieldViewBuilder;
  final FocusNode? focusNode;
  final PredictiveOptionsViewBuilder<T> optionsViewBuilder;
  final PredictiveOptionsViewOpenDirection optionsViewOpenDirection;
  final PredictiveOptionToString<T> displayStringForOption;
  final PredictiveOnSelected<T>? onSelected;
  final PredictiveOptionsBuilder<T> optionsBuilder;
  final TextEditingController? textEditingController;
  final TextEditingValue? initialValue;

  static void onFieldSubmitted<T extends Object>(GlobalKey key) {
    final _RawPredictive<T> rawPredictive = key.currentState! as _RawPredictive<T>;
    rawPredictive._onFieldSubmitted();
  }

  static String defaultStringForOption(Object? option) {
    return option.toString();
  }

  @override
  State<RawPredictive<T>> createState() => _RawPredictive<T>();
}

class _RawPredictive<T extends Object> extends State<RawPredictive<T>> {
  // GLOBAL KEY
  final GlobalKey _fieldKey = GlobalKey();

  // LAYER LINK
  final LayerLink _optionsLayerLink = LayerLink();

  // CONTROLLER
  late TextEditingController _textEditingController;
  late FocusNode _focusNode;
  late final Map<Type, Action<Intent>> _actionMap;
  late final _PredictiveCallbackAction<PredictivePreviousOptionIntent> _previousOptionAction;
  late final _PredictiveCallbackAction<PredictiveNextOptionIntent> _nextOptionAction;
  late final _PredictiveCallbackAction<DismissIntent> _hideOptionsAction;

  // LIST
  List<T> _options = [];

  // PROPERTIES
  T? _selection;
  bool _userHideOptions                 = false;
  bool _isLoading                       = false;
  bool _floatingOptionsUpdateScheduled  = false;
  String _lastFieldText                 = '';

  final ValueNotifier<int> _highlightedOptionIndex = ValueNotifier<int>(0);

  // OVERLAY ENTRY
  OverlayEntry? _floatingOptions;

  static const Map<ShortcutActivator, Intent> _shortcuts = <ShortcutActivator, Intent>{
    SingleActivator(LogicalKeyboardKey.arrowUp): AutocompletePreviousOptionIntent(),
    SingleActivator(LogicalKeyboardKey.arrowDown): AutocompleteNextOptionIntent(),
  };

  bool get _shouldShowOptions {
    return !_userHideOptions && _focusNode.hasFocus && _selection == null && _options.isNotEmpty;
  }

  // STATE
  @override
  void initState() {
    super.initState();
    _textEditingController  = widget.textEditingController ?? TextEditingController.fromValue(widget.initialValue);
    _focusNode              = widget.focusNode ?? FocusNode();
    _previousOptionAction   = _PredictiveCallbackAction<PredictivePreviousOptionIntent>(onInvoke: _highlightPreviousOption);
    _nextOptionAction       = _PredictiveCallbackAction<PredictiveNextOptionIntent>(onInvoke: _highlightNextOption);
    _hideOptionsAction      = _PredictiveCallbackAction<DismissIntent>(onInvoke: _hideOptions);
    _actionMap              = <Type, Action<Intent>> {
      AutocompletePreviousOptionIntent  : _previousOptionAction,
      AutocompleteNextOptionIntent      : _nextOptionAction,
      DismissIntent                     : _hideOptionsAction,
    };
    _updateOverlay();
  }

  @override
  void didUpdateWidget(RawPredictive<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateOverlay();
  }

  @override
  void dispose() {
    if (widget.textEditingController == null) {
      _textEditingController.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    _floatingOptions?.remove();
    _floatingOptions?.dispose();
    _floatingOptions = null;
    super.dispose();
  }

  // EVENTS
  Future<void> _onFieldSubmitted() async {
    if (_options.isEmpty || _userHideOptions) return;

    setState(() {
      _isLoading = true;
    });

    final List<T> options = await widget.optionsBuilder(_textEditingController.value);
    setState(() {
      _isLoading = false;
      _options = options;
    });

    // _select(_options.elementAt(index))
    _updateOverlay();
  }

  // Selecciona la opción dada y actualiza el widget.
  void _select(T nextSelection) {
    if (nextSelection == _selection) return;
    _selection = nextSelection;
    final String selectionString = widget.displayStringForOption(nextSelection);
    _textEditingController.value = TextEditingValue(
      selection : TextSelection.collapsed(offset: selectionString.length),
      text      : selectionString,
    );
    _updateOverlay();
    widget.onSelected?.call(_selection!);
  }

  // METHODS
  Object? _hideOptions(DismissIntent intent) {
    if (!_userHideOptions) {
      _userHideOptions = true;
      _textEditingController.clear();
      _updateOverlay();
      return null;
    }
    return Actions.invoke(context, intent);
  }

  void _updateHighlight(int newIndex) {
    _highlightedOptionIndex.value = _options.isEmpty ? 0 : newIndex % _options.length;
  }

  void _highlightPreviousOption(PredictivePreviousOptionIntent intent) {
    if (_userHideOptions) {
      _userHideOptions = false;
      _updateOverlay();
      return;
    }
    _updateHighlight(_highlightedOptionIndex.value - 1);
  }

  void _highlightNextOption(PredictiveNextOptionIntent intent) {
    if (_userHideOptions) {
      _userHideOptions = false;
      _updateOverlay();
      return;
    }
    _updateHighlight(_highlightedOptionIndex.value + 1);
  }

  // Oculta o muestra el overlay de opciones, si es necesario.
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
            targetAnchor: switch (widget.optionsViewOpenDirection) {
              PredictiveOptionsViewOpenDirection.up   => Alignment.topLeft,
              PredictiveOptionsViewOpenDirection.down => Alignment.bottomLeft,
            },
            followerAnchor: switch (widget.optionsViewOpenDirection) {
              PredictiveOptionsViewOpenDirection.up   => Alignment.bottomLeft,
              PredictiveOptionsViewOpenDirection.down => Alignment.topLeft,
            },
            child: Builder(
              builder: (BuildContext context) {
                return widget.optionsViewBuilder(context, _select, _options);
              },
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
    return Column(
      children: <Widget>[
        Container(
          key   : _fieldKey,
          child : Shortcuts(
            shortcuts : _shortcuts,
            child     : Actions(
              actions : _actionMap,
              child   : CompositedTransformTarget(
                link  : _optionsLayerLink,
                child : widget.fieldViewBuilder == null
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
        // const LinearProgressIndicator(),
      ],
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

/// An [Intent] to highlight the previous option in the autocomplete list.
class PredictivePreviousOptionIntent extends Intent {
  /// Creates an instance of AutocompletePreviousOptionIntent.
  const PredictivePreviousOptionIntent();
}

/// An [Intent] to highlight the next option in the autocomplete list.
class PredictiveNextOptionIntent extends Intent {
  /// Creates an instance of AutocompleteNextOptionIntent.
  const PredictiveNextOptionIntent();
}

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
