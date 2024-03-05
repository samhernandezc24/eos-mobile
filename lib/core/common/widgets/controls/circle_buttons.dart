import 'package:eos_mobile/core/common/widgets/app_icons.dart';
import 'package:eos_mobile/core/common/widgets/controls/buttons.dart';
import 'package:eos_mobile/core/enums/app_icons_enums.dart';
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

  //TODO: Reduce size if design re-exports icon-images without padding
  static double defaultSize = 28;

  final AppIconsEnums icon;
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
    final Color defaultColor = Theme.of(context).dialogBackgroundColor;
    final Color iconColor = color ?? Theme.of(context).unselectedWidgetColor;
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
    this.icon = AppIconsEnums.prev,
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
          icon: AppIconsEnums.close,
          onPressed: onPressed,
          semanticLabel: $strings.circleButtonsSemanticClose,
          backgroundColor: bgColor,
          iconColor: iconColor,
        );

  final Color? backgroundColor;
  final Color? iconColor;
  final AppIconsEnums icon;
  final VoidCallback? onPressed;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return CircleIconBtn(
      icon: icon,
      backgroundColor: backgroundColor,
      color: iconColor,
      onPressed: onPressed ??
          () {
            Navigator.pop(context);
          },
      semanticLabel: semanticLabel ?? $strings.circleButtonsSemanticBack,
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
      bottom: false,
      child: Padding(
        padding: EdgeInsets.all($styles.insets.sm),
        child: child,
      ),
    );
  }
}
