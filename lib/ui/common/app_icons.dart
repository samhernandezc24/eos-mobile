// ignore_for_file: constant_identifier_names
import 'package:eos_mobile/shared/shared_libs.dart';

enum AppIcons {
  close,
  close_large,
  download,
  fullscreen,
  fullscreen_exit,
  info,
  menu,
  next_large,
  north,
  previous,
  search,
  share_android,
  share_ios,
  zoom_in,
  zoom_out,
}

class AppIcon extends StatelessWidget {
  const AppIcon(
    this.icon, {
    Key? key,
    this.size = 24,
    this.color,
  }) : super(key: key);

  final AppIcons icon;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final String i      = icon.name.toLowerCase().replaceAll('_', '-');
    final String path   = 'assets/icons/icon-$i.png';
    return SizedBox(
      width: size,
      height: size,
      child: Center(
        child: Image.asset(
          path,
          width         : size,
          height        : size,
          color         : color ?? Theme.of(context).primaryColor,
          filterQuality : FilterQuality.high,
        ),
      ),
    );
  }
}
