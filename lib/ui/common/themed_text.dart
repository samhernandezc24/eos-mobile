import 'package:eos_mobile/shared/shared_libraries.dart';

class DefaultTextColor extends StatelessWidget {
  const DefaultTextColor({required this.color, required this.child, Key? key}) : super(key: key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: DefaultTextStyle.of(context).style.copyWith(color: color),
      child: child,
    );
  }
}
