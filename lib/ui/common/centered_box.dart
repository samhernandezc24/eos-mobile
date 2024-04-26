import 'package:eos_mobile/shared/shared_libraries.dart';

class CenteredBox extends StatelessWidget {
  const CenteredBox({required this.child, Key? key, this.width, this.height, this.padding}) : super(key: key);

  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Center(
        child: SizedBox(width: width, height: height, child: child),
      ),
    );
  }
}
