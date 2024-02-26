import 'package:eos_mobile/core/common/widgets/app_icons.dart';
import 'package:eos_mobile/core/constants/constants.dart';
import 'package:eos_mobile/core/enums/app_icons_enums.dart';
import 'package:eos_mobile/shared/shared.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({
    required this.onPressed,
    required this.child,
    required this.semanticLabel,
    super.key,
    this.borderSide,
    this.backgroundColor,
    this.size,
  });

  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final BorderSide? borderSide;
  final Widget child;
  final double? size;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    final double sz = size ?? Constants.kDefaultSize;
    return Container(
      width: sz,
      height: sz,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
        border: Border.all(
          color: borderSide?.color ?? Colors.transparent,
          width: borderSide?.width ?? 0,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(sz / 2),
          child: Center(
            child: Semantics(
              label: semanticLabel,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

class CircleIconButton extends StatelessWidget {
  const CircleIconButton({
    required this.icon,
    required this.onPressed,
    required this.semanticLabel,
    super.key,
    this.borderSide,
    this.backgroundColor,
    this.color,
    this.size,
    this.iconSize,
    this.flipIcon = false,
  });

  // TODO(size): Reducir tamaño si el diseño reexporta icon-images.
  static double defaultSize = 28;

  final AppIconsEnums icon;
  final VoidCallback? onPressed;
  final BorderSide? borderSide;
  final Color? backgroundColor;
  final Color? color;
  final String semanticLabel;
  final double? size;
  final double? iconSize;
  final bool flipIcon;

  @override
  Widget build(BuildContext context) {
    final Color defaultColor = Theme.of(context).colorScheme.secondary;
    final Color iconColor = color ?? Theme.of(context).colorScheme.onPrimary;
    return CircleButton(
      onPressed: onPressed,
      borderSide: borderSide,
      size: size,
      backgroundColor: backgroundColor ?? defaultColor,
      semanticLabel: semanticLabel,
      child: Transform.scale(
        scaleX: flipIcon ? -1 : 1,
        child: AppIcons(
          icon,
          size: iconSize ?? defaultSize,
          color: iconColor,
        ),
      ),
    );
  }
}
