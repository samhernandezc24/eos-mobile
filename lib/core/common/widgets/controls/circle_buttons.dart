import 'package:eos_mobile/core/common/widgets/app_icons.dart';
import 'package:eos_mobile/core/common/widgets/controls/buttons.dart';
import 'package:eos_mobile/core/common/widgets/modals/full_screen_keyboard_listener.dart';
import 'package:eos_mobile/shared/shared.dart';

class CircleBtn extends StatelessWidget {
  const CircleBtn({
    required this.child,
    required this.onPressed,
    required this.semanticLabel,
    super.key,
    this.border,
    this.backgroundColor,
    this.size,
  });

  static double defaultSize = 48;

  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final BorderSide? border;
  final Widget child;
  final double? size;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    final double sz = size ?? defaultSize;
    return AppBtn(
      onPressed: onPressed,
      semanticLabel: semanticLabel,
      minimumSize: Size(sz, sz),
      padding: EdgeInsets.zero,
      circular: true,
      backgroundColor: backgroundColor,
      border: border,
      child: child,
    );
  }
}

class CircleIconBtn extends StatelessWidget {
  const CircleIconBtn({
    required this.icon,
    required this.onPressed,
    required this.semanticLabel,
    super.key,
    this.border,
    this.backgroundColor,
    this.color,
    this.size,
    this.iconSize,
    this.flipIcon = false,
  });

  // TODO(samhernandezc24): Reducir el tamaño si el diseño reexporta imágenes-icono sin padding.
  static double defaultSize = 28;

  final AppIcons icon;
  final VoidCallback? onPressed;
  final BorderSide? border;
  final Color? backgroundColor;
  final Color? color;
  final String semanticLabel;
  final double? size;
  final double? iconSize;
  final bool flipIcon;

  @override
  Widget build(BuildContext context) {
    final Color defaultColor  = Theme.of(context).colorScheme.primary;
    final Color iconColor     = color ?? Theme.of(context).colorScheme.onPrimary;
    return CircleBtn(
      onPressed: onPressed,
      border: border,
      size: size,
      backgroundColor: backgroundColor ?? defaultColor,
      semanticLabel: semanticLabel,
      child: Transform.scale(
        scaleX: flipIcon ? -1 : 1,
        child: AppIcon(icon, size: iconSize ?? defaultSize, color: iconColor),
      ),
    );
  }

  Widget safe() => _SafeAreaWithPadding(child: this);
}

class BackBtn extends StatelessWidget {
  const BackBtn({
    super.key,
    this.icon = AppIcons.prev,
    this.onPressed,
    this.semanticLabel,
    this.backgroundColor,
    this.iconColor,
  });

  BackBtn.close({
    Key? key,
    VoidCallback? onPressed,
    Color? bgColor,
    Color? iconColor,
  }) : this(
          key: key,
          icon: AppIcons.close,
          onPressed: onPressed,
          semanticLabel: $strings.circleButtonsSemanticClose,
          backgroundColor: bgColor,
          iconColor: iconColor,
        );

  bool _handleKeyDown(BuildContext context, KeyDownEvent event) {
    if (event.logicalKey == LogicalKeyboardKey.escape) {
      _handleOnPressed(context);
      return true;
    }
    return false;
  }

  final Color? backgroundColor;
  final Color? iconColor;
  final AppIcons icon;
  final VoidCallback? onPressed;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return FullScreenKeyboardListener(
      onKeyDown: (event) => _handleKeyDown(context, event),
      child: CircleIconBtn(
        icon: icon,
        backgroundColor: backgroundColor,
        color: iconColor,
        onPressed: onPressed ??
            () {
              final nav = Navigator.of(context);
              if (nav.canPop()) {
                Navigator.pop(context);
              } else {
                context.go('/');
              }
            },
        semanticLabel: semanticLabel ?? $strings.circleButtonsSemanticBack,
      ),
    );
  }

  Widget safe() => _SafeAreaWithPadding(child: this);

  void _handleOnPressed(BuildContext context) {
    if (onPressed != null) {
      onPressed?.call();
    } else {
      if (context.canPop()) {
        context.pop();
      } else {
        context.go('/');
      }
    }
  }
}

class _SafeAreaWithPadding extends StatelessWidget {
  const _SafeAreaWithPadding({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.all($styles.insets.sm),
        child: child,
      ),
    );
  }
}
