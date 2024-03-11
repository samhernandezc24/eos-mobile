import 'package:eos_mobile/shared/shared.dart';

class AppIcon extends StatelessWidget {
  const AppIcon(this.icon, {super.key, this.size = 22, this.color});

  final AppIcons icon;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final String i = icon.name.toLowerCase().replaceAll('_', '-');
    final String path = 'assets/icons/icon-$i.png';
    return SizedBox(
      width: size,
      height: size,
      child: Center(
        child: Image.asset(
          path,
          width: size,
          height: size,
          color: color ?? Theme.of(context).canvasColor,
          filterQuality: FilterQuality.high,
        ),
      ),
    );
  }
}
