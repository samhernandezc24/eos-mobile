import 'package:eos_mobile/core/common/widgets/app_scroll_behavior.dart';
import 'package:eos_mobile/shared/shared.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({required this.child, super.key});

  final Widget child;

  static AppStyles get style => _style;
  static final AppStyles _style = AppStyles();

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: ValueKey($styles.scale),
      child: Theme(
        data: ...,
        child: DefaultTextStyle(
          style: $styles.text.body,
          // Use a custom scroll behavior across entire app
          child: ScrollConfiguration(
            behavior: AppScrollBehavior(),
            child: child,
          ),
        ),
      ),
    );
  }
}
