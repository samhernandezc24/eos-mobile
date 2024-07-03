import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:eos_mobile/ui/common/app_icons.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({
    required this.child,
    required this.onPressed,
    required this.semanticLabel,
    Key? key,
    this.border,
    this.backgroundColor,
    this.size,
  }) : super(key: key);

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
    return AppButton(
      onPressed         : onPressed,
      semanticLabel     : semanticLabel,
      minimumSize       : Size(sz, sz),
      padding           : EdgeInsets.zero,
      circular          : true,
      backgroundColor   : backgroundColor,
      border            : border,
      child             : child,
    );
  }
}

class CircleIconButton extends StatelessWidget {
  const CircleIconButton({
    required this.icon,
    required this.onPressed,
    required this.semanticLabel,
    Key? key,
    this.border,
    this.color,
    this.backgroundColor,
    this.size,
    this.iconSize,
    this.flipIcon = false,
  }) : super(key: key);

  // TODO(samhernandez24): Reducir el tamaño si el diseño reexporta icon-images sin padding.
  static double defaultSize = 28;

  final AppIcons icon;
  final VoidCallback? onPressed;
  final Color? color;
  final Color? backgroundColor;
  final BorderSide? border;
  final double? size;
  final double? iconSize;
  final String semanticLabel;
  final bool flipIcon;

  @override
  Widget build(BuildContext context) {
    final Color defaultColor  = Theme.of(context).primaryColor;
    final Color iconColor     = color ?? Theme.of(context).colorScheme.onPrimary;
    return CircleButton(
      onPressed       : onPressed,
      border          : border,
      size            : size,
      backgroundColor : backgroundColor ?? defaultColor,
      semanticLabel   : semanticLabel,
      child           : Transform.scale(
        scaleX  : flipIcon ? -1 : 1,
        child   : AppIcon(icon, size: iconSize ?? defaultSize, color: iconColor),
      ),
    );
  }

  Widget safe() => _SafeAreaWithPadding(child: this);
}

class _SafeAreaWithPadding extends StatelessWidget {
  const _SafeAreaWithPadding({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom  : false,
      child   : Padding(
        padding : EdgeInsets.all($styles.insets.sm),
        child   : child,
      ),
    );
  }
}
