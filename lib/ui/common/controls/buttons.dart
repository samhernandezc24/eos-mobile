import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:eos_mobile/ui/common/app_icons.dart';

/// Métodos compartidos entre los tipos de botones.
Widget _buildIcon(BuildContext context, AppIcons icon, {required bool isSecondary, required double? size}) =>
    AppIcon(icon, color: isSecondary ? $styles.colors.black : $styles.colors.offWhite, size: size ?? 18);

/// El botón central que controla todos los demás botones.
class AppButton extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  AppButton({
    required this.onPressed,
    required this.semanticLabel,
    Key? key,
    this.enableFeedback   = true,
    this.pressEffect      = true,
    this.child,
    this.padding,
    this.expand           = false,
    this.isSecondary      = false,
    this.circular         = false,
    this.minimumSize,
    this.backgroundColor,
    this.border,
    this.focusNode,
    this.onFocusChanged,
  }) : _builder = null, super(key: key);

  AppButton.from({
    required this.onPressed,
    Key? key,
    this.enableFeedback   = true,
    this.pressEffect      = true,
    this.padding,
    this.expand           = false,
    this.isSecondary      = false,
    this.minimumSize,
    this.backgroundColor,
    this.border,
    this.focusNode,
    this.onFocusChanged,
    String? semanticLabel,
    String? text,
    AppIcons? icon,
    double? iconSize,
  }) : child      = null,
       circular   = false,
       super(key: key) {
    if (semanticLabel == null && text == null) {
      // ignore: only_throw_errors
      throw 'AppButton.from debe incluir text o semanticLabel.';
    }
    this.semanticLabel = semanticLabel ?? text ?? '';
    _builder = (context) {
      if (text == null && icon == null) return const SizedBox.shrink();
      final Text? txt = text == null
          ? null
          : Text(
              text.toUpperCase(),
              style               : $styles.textStyles.button,
              textHeightBehavior  : const TextHeightBehavior(applyHeightToFirstAscent: false),
            );
      final Widget? icn = icon == null ? null : _buildIcon(context, icon, isSecondary: isSecondary, size: iconSize);

      if (txt != null && icn != null) {
        return Row(
          mainAxisAlignment : MainAxisAlignment.center,
          mainAxisSize      : MainAxisSize.min,
          children          : <Widget>[ icn, Gap($styles.insets.xs), txt ],
        );
      } else {
        return (txt ?? icn)!;
      }
    };
  }

  AppButton.basic({
    required this.onPressed,
    required this.semanticLabel,
    Key? key,
    this.enableFeedback   = true,
    this.pressEffect      = true,
    this.child,
    this.padding          = EdgeInsets.zero,
    this.isSecondary      = false,
    this.circular         = false,
    this.minimumSize,
    this.focusNode,
    this.onFocusChanged,
  }) : expand           = false,
       backgroundColor  = $styles.colors.transparent,
       border           = null,
       _builder         = null,
       super(key: key);

  // INTERACTION:
  final VoidCallback? onPressed;
  late final String semanticLabel;
  final bool enableFeedback;
  final FocusNode? focusNode;
  final void Function(bool hasFocus)? onFocusChanged;

  // CONTENT:
  late final Widget? child;
  late final WidgetBuilder? _builder;

  // LAYOUT:
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
    final Color defaultColor  = isSecondary ? Theme.of(context).colorScheme.secondary : Theme.of(context).primaryColor;
    final Color textColor     = isSecondary ? Theme.of(context).colorScheme.onSecondary : Theme.of(context).colorScheme.onPrimary;
    final BorderSide side     = border ?? BorderSide.none;

    Widget content = _builder?.call(context) ?? child ?? const SizedBox.shrink();

    if (expand) content = Center(child: content);

    final OutlinedBorder shape = circular
        ? CircleBorder(side: side)
        : RoundedRectangleBorder(side: side, borderRadius: BorderRadius.circular($styles.corners.md));

    final ButtonStyle style = ButtonStyle(
      minimumSize     : ButtonStyleButton.allOrNull<Size?>(minimumSize ?? Size.zero),
      tapTargetSize   : MaterialTapTargetSize.shrinkWrap,
      splashFactory   : NoSplash.splashFactory,
      backgroundColor : ButtonStyleButton.allOrNull<Color>(backgroundColor ?? defaultColor),
      overlayColor    : ButtonStyleButton.allOrNull<Color>($styles.colors.transparent),
      shape           : ButtonStyleButton.allOrNull<OutlinedBorder>(shape),
      padding         : ButtonStyleButton.allOrNull<EdgeInsetsGeometry>(padding ?? EdgeInsets.all($styles.insets.md)),
      enableFeedback  : enableFeedback,
    );

    Widget button = _CustomFocusBuilder(
      focusNode       : focusNode,
      onFocusChanged  : onFocusChanged,
      builder         : (BuildContext context, FocusNode focus) {
        return Stack(
          children: <Widget>[
            Opacity(
              opacity: onPressed == null ? 0.5 : 1.0,
              child: TextButton(
                onPressed: onPressed,
                style: style,
                focusNode: focus,
                child: DefaultTextStyle(
                  style: DefaultTextStyle.of(context).style.copyWith(color: textColor),
                  child: content,
                ),
              ),
            ),
            if (focus.hasFocus)
              Positioned.fill(
                child: IgnorePointer(
                  child: Container(
                      decoration    : BoxDecoration(
                      borderRadius  : BorderRadius.circular($styles.corners.md),
                      border        : Border.all(width: 3),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );

    // Agregar efecto al pulsar el botón.
    if (pressEffect && onPressed != null) button = _ButtonPressEffect(button);

    // ¿Agregar semántica?
    if (semanticLabel.isEmpty) return button;

    return Semantics(
      label       : semanticLabel,
      button      : true,
      container   : true,
      child       : ExcludeSemantics(child: button),
    );
  }
}

/// =========================================================
/// _ButtonDecorator: Agregar a los botones un efecto de
/// pulsación basado en transparencias.
/// =========================================================
class _ButtonPressEffect extends StatefulWidget {
  const _ButtonPressEffect(this.child);

  final Widget child;

  @override
  State<_ButtonPressEffect> createState() => _ButtonPressEffectState();
}

class _ButtonPressEffectState extends State<_ButtonPressEffect> {
  // PROPERTIES
  bool _isDown = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      excludeFromSemantics  : true,
      onTapDown             : (_) => setState(() => _isDown = true),
      onTapUp               : (_) => setState(() => _isDown = false),
      onTapCancel           : () => setState(() => _isDown  = false),
      behavior              : HitTestBehavior.translucent,
      child                 : Opacity(opacity: _isDown ? 0.7 : 1, child: ExcludeSemantics(child: widget.child),
      ),
    );
  }
}

class _CustomFocusBuilder extends StatefulWidget {
  const _CustomFocusBuilder({required this.builder, this.focusNode, this.onFocusChanged});

  final Widget Function(BuildContext context, FocusNode focus) builder;
  final void Function(bool hasFocus)? onFocusChanged;
  final FocusNode? focusNode;

  @override
  State<_CustomFocusBuilder> createState() => _CustomFocusBuilderState();
}

class _CustomFocusBuilderState extends State<_CustomFocusBuilder> {
  // PROPERTIES
  late final FocusNode _focusNode;

  // STATE
  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_handleFocusChanged);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChanged);
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  // EVENTS
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
