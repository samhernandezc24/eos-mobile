import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// El tipo de callback utilizada por el widget [RawPredictive] para indicar
/// que el usuario ha seleccionado una opción.
typedef PredictiveOnSelected<T extends Object> = void Function(T option);

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
    this.optionsViewOpenDirection = PredictiveOptionsViewOpenDirection.down,
    this.fieldViewBuilder,
    this.focusNode,
    this.onSelected,
    this.textEditingController,
    this.initialValue,
  });

  final PredictiveFieldViewBuilder? fieldViewBuilder;
  final FocusNode? focusNode;
  final PredictiveOptionsViewBuilder<T> optionsViewBuilder;
  final PredictiveOptionsViewOpenDirection optionsViewOpenDirection;
  final PredictiveOnSelected<T>? onSelected;
  final TextEditingController? textEditingController;
  final TextEditingValue? initialValue;

  static void onFieldSubmitted<T extends Object>(GlobalKey key) {
    final _RawPredictiveState<T> rawPredictive = key.currentState! as _RawPredictiveState<T>;
    rawPredictive._onFieldSubmitted();
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
  late FocusNode _focusNode;

  // LIST
  List<T> _options = [];

  // PROPERTIES
  T? _selection;
  bool _floatingOptionsUpdateScheduled  = false;
  bool _userHideOptions                 = false;

  // OverlayEntry que contiene las opciones.
  OverlayEntry? _floatingOptions;

  bool get _shouldShowOptions {
    return !_userHideOptions && _options.isNotEmpty;
  }

  // STATE
  @override
  void initState() {
    super.initState();
    _textEditingController = widget.textEditingController ?? TextEditingController.fromValue(widget.initialValue);
    _focusNode = widget.focusNode ?? FocusNode();
    _updateOverlay();
  }

  @override
  void didUpdateWidget(RawPredictive<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateOverlay();
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.textEditingController == null) { _textEditingController.dispose(); }
    if (widget.focusNode == null) { _focusNode.dispose(); }
    _floatingOptions?.remove();
    _floatingOptions?.dispose();
    _floatingOptions = null;
  }

  // EVENTS
  Future<void> _onFieldSubmitted() async {
    if (_options.isEmpty || _userHideOptions) {
      return;
    }
    _updateOverlay();
  }

  void _select(T nextSelection) {
    if (nextSelection == _selection) {
      return;
    }
    _selection = nextSelection;
    _updateOverlay();
    widget.onSelected?.call(_selection!);
  }

  void updateOptions(List<T> newOptions) {
    setState(() {
      _options = newOptions;
    });
    _updateOverlay();
  }

  // METHODS
  void _updateOverlay() {
    if (SchedulerBinding.instance.schedulerPhase == SchedulerPhase.persistentCallbacks) {
      if (!_floatingOptionsUpdateScheduled) {
        _floatingOptionsUpdateScheduled = true;
        SchedulerBinding.instance.addPostFrameCallback((Duration timeStamp) {
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
    return Container(
      key: _fieldKey,
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
    );
  }
}
