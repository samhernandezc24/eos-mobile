import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:eos_mobile/ui/common/app_icon.dart';

/// Métodos compartidos entre tipos de botones
Widget _buildIcon(BuildContext context, AppIcons icon, {required bool isSecondary, required double? size}) {
  return AppIcon(icon, color: isSecondary ? Colors.black : Colors.white, size: size ?? 18);
}

/// El botón central que controla todos los demás botones.
class AppBtn extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  AppBtn({
    required this.onPressed,
    required this.semanticLabel,
    super.key,
    this.enableFeedback = true,
    this.pressEffect = true,
    this.child,
    this.padding,
    this.expand = false,
    this.isSecondary = false,
    this.circular = false,
    this.minimumSize,
    this.backgroundColor,
    this.border,
    this.focusNode,
    this.onFocusChanged,
  }) : _builder = null;

  AppBtn.from({
    required this.onPressed,
    super.key,
    this.enableFeedback = true,
    this.pressEffect = true,
    this.padding,
    this.expand = false,
    this.isSecondary = false,
    this.minimumSize,
    this.backgroundColor,
    this.border,
    this.focusNode,
    this.onFocusChanged,
    String? semanticLabel,
    String? text,
    AppIcons? icon,
    double? iconSize,
  })  : child     = null,
        circular  = false {
    if (semanticLabel == null && text == null) {
      // ignore: only_throw_errors
      throw 'AppBtn.from debe incluir text o semanticLabel';
    }

    this.semanticLabel = semanticLabel ?? text ?? '';

    _builder = (BuildContext context) {
      if (text == null && icon == null) return const SizedBox.shrink();
      final Text? txt = text == null
          ? null
          : Text(text.toUpperCase(), style: $styles.textStyles.button);

      final Widget? icn = icon == null ? null : _buildIcon(context, icon, isSecondary: isSecondary, size: iconSize);

      if (txt != null && icn != null) {
        return Row(
          mainAxisAlignment : MainAxisAlignment.center,
          mainAxisSize      : MainAxisSize.min,
          children          : <Widget>[txt, Gap($styles.insets.xs), icn],
        );
      } else {
        return (txt ?? icn)!;
      }
    };
  }

  // ignore: prefer_const_constructors_in_immutables
  AppBtn.basic({
    required this.onPressed,
    required this.semanticLabel,
    super.key,
    this.enableFeedback = true,
    this.pressEffect = true,
    this.child,
    this.padding = EdgeInsets.zero,
    this.isSecondary = false,
    this.circular = false,
    this.minimumSize,
    this.focusNode,
    this.onFocusChanged,
  })  : expand          = false,
        backgroundColor = Colors.transparent,
        border          = null,
        _builder        = null;

  // INTERACTION:
  final VoidCallback? onPressed;
  late final String semanticLabel;
  final bool enableFeedback;
  final FocusNode? focusNode;
  final void Function(bool hasFocus)? onFocusChanged;

  // CONTENT:
  late final Widget? child;
  late final WidgetBuilder? _builder;

  // LAYOUT
  final EdgeInsets? padding;
  final bool expand;
  final bool circular;
  final Size? minimumSize;

  // STYLE:
  final bool isSecondary;
  final BorderSide? border;
  final Color? backgroundColor;
  final bool pressEffect;

  @override
  Widget build(BuildContext context) {
    final Color defaultColor  = isSecondary ? Theme.of(context).colorScheme.secondary : Theme.of(context).colorScheme.primary;
    final Color textColor     = isSecondary ? Theme.of(context).colorScheme.onSecondary : Theme.of(context).colorScheme.onPrimary;
    final BorderSide side     = border ?? BorderSide.none;

    Widget content = _builder?.call(context) ?? child ?? const SizedBox.shrink();

    if (expand) content = Center(child: content);

    final OutlinedBorder shape = circular ? CircleBorder(side: side) : RoundedRectangleBorder(side: side, borderRadius: BorderRadius.circular($styles.corners.md));

    final ButtonStyle style = ButtonStyle(
      minimumSize     : ButtonStyleButton.allOrNull<Size>(minimumSize ?? Size.zero),
      tapTargetSize   : MaterialTapTargetSize.shrinkWrap,
      splashFactory   : NoSplash.splashFactory,
      backgroundColor : ButtonStyleButton.allOrNull<Color>(backgroundColor ?? defaultColor),
      overlayColor    : ButtonStyleButton.allOrNull<Color>(Colors.transparent),
      shape           : ButtonStyleButton.allOrNull<OutlinedBorder>(shape),
      padding         : ButtonStyleButton.allOrNull<EdgeInsetsGeometry>(padding ?? EdgeInsets.all($styles.insets.md)),
      enableFeedback  : enableFeedback,
    );

    Widget button = _CustomFocusBuilder(
      focusNode: focusNode,
      onFocusChanged: onFocusChanged,
      builder: (BuildContext context, FocusNode focusNode) {
        return Stack(
          children: <Widget>[
            Opacity(
              opacity: onPressed == null ? 0.5 : 1.0,
              child: TextButton(
                onPressed: onPressed,
                style: style,
                focusNode: focusNode,
                child: DefaultTextStyle(
                  style: DefaultTextStyle.of(context).style.copyWith(color: textColor),
                  child: content,
                ),
              ),
            ),
            if (focusNode.hasFocus)
              Positioned.fill(
                child: IgnorePointer(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular($styles.corners.md),
                      border: Border.all(width: 3),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );

    // AGREGAR EFECTO AL PRESIONAR:
    if (pressEffect && onPressed != null) button = _ButtonPressedEffect(button);

    // AGREGAR SEMANTICS?:
    if (semanticLabel.isEmpty) return button;

    return Semantics(
      label     : semanticLabel,
      button    : true,
      container : true,
      child     : ExcludeSemantics(child: button),
    );
  }
}

/// Agregar a los botones un efecto de pulsación basado en transparencias.
class _ButtonPressedEffect extends StatefulWidget {
  const _ButtonPressedEffect(this.child);

  final Widget child;

  @override
  State<_ButtonPressedEffect> createState() => _ButtonPressedEffectState();
}

class _ButtonPressedEffectState extends State<_ButtonPressedEffect> {
  /// PROPERTIES
  bool _isDown = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      excludeFromSemantics  : true,
      onTapDown             : (_) => setState(() => _isDown = true),
      onTapUp               : (_) => setState(() => _isDown = false),
      onTapCancel           : () => setState(() => _isDown = false),
      behavior              : HitTestBehavior.translucent,
      child                 : Opacity(opacity: _isDown ? 0.7 : 1, child: ExcludeSemantics(child: widget.child)),
    );
  }
}

class _CustomFocusBuilder extends StatefulWidget {
  const _CustomFocusBuilder({required this.builder, this.focusNode, this.onFocusChanged});

  final Widget Function(BuildContext context, FocusNode focusNode) builder;
  final void Function(bool hasFocus)? onFocusChanged;
  final FocusNode? focusNode;

  @override
  State<_CustomFocusBuilder> createState() => _CustomFocusBuilderState();
}

class _CustomFocusBuilderState extends State<_CustomFocusBuilder> {
  /// PROPERTIES
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_handleFocusChanged);
  }

  /// METHODS
  void _handleFocusChanged() {
    widget.onFocusChanged?.call(_focusNode.hasFocus);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder.call(context, _focusNode);
  }
}
