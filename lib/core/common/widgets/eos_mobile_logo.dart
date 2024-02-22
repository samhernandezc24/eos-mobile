import 'package:eos_mobile/shared/shared.dart';

class EOSMobileLogo extends StatelessWidget {
  const EOSMobileLogo({super.key, this.width = 100});

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
