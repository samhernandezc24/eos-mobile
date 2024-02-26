import 'package:eos_mobile/shared/shared.dart';

class StaticTextScale extends StatelessWidget {
  const StaticTextScale({
    required this.child,
    this.scale = 1,    
    super.key,
  });

  final Widget child;
  final double scale;

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(scale)),
      child: child,
    );
  }
}
