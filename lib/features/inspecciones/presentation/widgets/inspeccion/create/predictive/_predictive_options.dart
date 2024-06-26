import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:flutter/scheduler.dart';

typedef PredictiveOnSelected<T extends Object> = void Function(T option);

typedef PredictiveOptionsViewBuilder<T extends Object> = Widget Function(
  BuildContext context,
  PredictiveOnSelected<T> onSelected,
  Iterable<T> options,
);

class PredictiveOptions<T extends Object> extends StatefulWidget {
  const PredictiveOptions({
    required this.optionsViewBuilder,
    super.key,
    this.onSelected,
  });

  final PredictiveOptionsViewBuilder<T> optionsViewBuilder;
  final PredictiveOnSelected<T>? onSelected;

  @override
  State<PredictiveOptions<T>> createState() => _PredictiveOptionsState<T>();
}

class _PredictiveOptionsState<T extends Object> extends State<PredictiveOptions<T>> {
  final LayerLink _optionsLayerLink = LayerLink();
  late final Map<Type, Action<Intent>> _actionMap;
  late final _PredictiveCallbackAction<DismissIntent> _hideOptionsAction;
  Iterable<T> _options = Iterable<T>.empty();
  T? _selection;
  bool _userHideOptions = false;
  bool _floatingOptionsUpdateScheduled = false;

  OverlayEntry? _floatingOptions;

  bool get _shouldShowOptions {
    return !_userHideOptions && _selection == null && _options.isNotEmpty;
  }

  void _select(T nextSelection) {
    if (nextSelection == _selection) {
      return;
    }
    _selection = nextSelection;
    _updateOverlay();
    widget.onSelected?.call(_selection!);
  }

  Object? _hideOptions(DismissIntent intent) {
    if (!_userHideOptions) {
      _userHideOptions = true;
      _updateOverlay();
      return null;
    }
    return Actions.invoke(context, intent);
  }

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
  void initState() {
    super.initState();
    _hideOptionsAction = _PredictiveCallbackAction<DismissIntent>(onInvoke: _hideOptions);
    _updateOverlay();
  }

  @override
  void didUpdateWidget(PredictiveOptions<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateOverlay();
  }

  @override
  void dispose() {
    _floatingOptions?.remove();
    _floatingOptions?.dispose();
    _floatingOptions = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
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
