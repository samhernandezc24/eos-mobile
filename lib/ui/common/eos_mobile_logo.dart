import 'package:eos_mobile/shared/shared_libraries.dart';

class EOSMobileLogo extends StatelessWidget {
  const EOSMobileLogo({Key? key, this.width = 100}) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      ImagePaths.appLogo,
      fit: BoxFit.cover,
      width: width,
      filterQuality: FilterQuality.high,
    );
  }
}
