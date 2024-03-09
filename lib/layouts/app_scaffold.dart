import 'package:eos_mobile/config/themes/app_theme.dart';
import 'package:eos_mobile/core/common/widgets/app_scroll_behavior.dart';
import 'package:eos_mobile/shared/shared.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({required this.child, super.key});

  final Widget child;
  static AppStyles get style => _style;
  static final AppStyles _style = AppStyles();

  @override
  Widget build(BuildContext context) {
    // Escucha el tamaño del dispositivo y actualiza AppStyle cuando cambia.
    final mq = MediaQuery.of(context);

    final theme = Theme.of(context);
    final appTheme = theme.brightness == Brightness.light
        ? AppTheme.lightTheme($styles)
        : AppTheme.darkTheme($styles);

    appLogic.handleAppSizeChanged(mq.size);
    return KeyedSubtree(
      key: ValueKey($styles.scale),
      child: Theme(
        data: appTheme,
        child: DefaultTextStyle(
          style: $styles.textStyles.body,
          // Utilizar un comportamiento de desplazamiento personalizado
          // en toda la aplicación.
          child: ScrollConfiguration(
            behavior: AppScrollBehavior(),
            child: child,
          ),
        ),
      ),
    );
  }
}
