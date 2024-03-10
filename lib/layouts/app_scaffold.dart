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
    appLogic.handleAppSizeChanged(mq.size);
    // Establecer el tiempo por defecto para las animaciones en la aplicación.
    Animate.defaultDuration = _style.times.fast;
    return KeyedSubtree(
      key: ValueKey($styles.scale),
      child: DefaultTextStyle(
        style: $styles.textStyles.body,
        // Utilizar un comportamiento de desplazamiento personalizado
        // en toda la aplicación.
        child: ScrollConfiguration(
          behavior: AppScrollBehavior(),
          child: child,
        ),
      ),
    );
  }
}
