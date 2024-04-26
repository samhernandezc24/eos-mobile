import 'package:eos_mobile/shared/shared_libraries.dart';

/// Agrega fácilmente decoraciones visuales a un widget de desplazamiento basado en el estado de su controlador.
class ScrollDecorator extends StatefulWidget {
  /// Crea un widget que construye decoraciones foreground y/o background para un widget de
  /// desplazamiento basado en el estado de su ScrollController.
  // ignore: prefer_const_constructors_in_immutables
  ScrollDecorator({
    required this.builder,
    super.key,
    this.foregroundBuilder,
    this.backgroundBuilder,
    this.controller,
    this.onInit,
  });

  /// Crea un ScrollDecorator que desvanece un widget al principio o al final del widget de desplazamiento basándose en la
  /// posición del scroll de desplazamiento.
  ///
  /// Por ejemplo, en una lista vertical, el widget `begin` se desvanecería cuando la lista no se desplaza hasta la parte superior.
  ScrollDecorator.fade({
    required this.builder,
    super.key,
    this.controller,
    this.onInit,
    Widget? begin,
    Widget? end,
    bool background = false,
    Axis direction = Axis.vertical,
    Duration duration = const Duration(milliseconds: 150),
  }) {
    Flex flexBuilder(ScrollController controller) {
      return Flex(
        direction: direction,
        children: <Widget>[
          if (begin != null)
            AnimatedOpacity(
              opacity: controller.hasClients && controller.position.extentBefore > 3 ? 1 : 0,
              duration: duration,
              child: begin,
            ),
          const Spacer(),
          if (end != null)
            AnimatedOpacity(
              opacity: controller.hasClients && controller.position.extentAfter > 3 ? 1 : 0,
              duration: duration,
              child: end,
            ),
        ],
      );
    }

    backgroundBuilder   = background  ? flexBuilder   : null;
    foregroundBuilder   = !background ? flexBuilder   : null;
  }

  /// Crea un ScrollDecorator que añade una sombra a la parte superior de una lista vertical cuando se desplaza hacia abajo.
  ScrollDecorator.shadow({
    required this.builder,
    super.key,
    this.controller,
    this.onInit,
    Color color = Colors.black54,
  }) {
    backgroundBuilder = null;
    foregroundBuilder = (ScrollController controller) {
      final double ratio = controller.hasClients ? min<double>(1, controller.position.extentBefore / 60) : 0;

      return IgnorePointer(
        child: Container(
          height      : 24,
          decoration  : BoxDecoration(
            gradient  : LinearGradient(
              colors  : <Color>[color.withOpacity(ratio * color.opacity), Colors.transparent],
              stops   : <double>[0, ratio],
              begin   : Alignment.topCenter,
              end     : Alignment.bottomCenter,
            ),
          ),
        ),
      );
    };
  }

  /// El ScrollController a utilizar cuando se construya el widget de desplazamiento. Si es null, se creará un ScrollController
  /// automáticamente.
  final ScrollController? controller;

  /// Constructor para crear el widget de desplazamiento. Debe utilizar el ScrollController que se proporciona al constructor.
  final ScrollBuilder builder;

  /// Constructor para crear el widget de decoración que se superpondrá delante del widget de desplazamiento. Debe utilizar el
  /// ScrollController proporcionado para ajustar su salida según sea apropiado.
  late final ScrollBuilder? foregroundBuilder;

  /// Constructor para crear el widget de decoración que se superpondrá detrás del widget de desplazamiento. Debe utilizar el
  /// ScrollController proporcionado para ajustar su salida según sea apropiado.
  late final ScrollBuilder? backgroundBuilder;

  final void Function(ScrollController controller)? onInit;

  @override
  State<ScrollDecorator> createState() => _ScrollDecoratorState();
}

class _ScrollDecoratorState extends State<ScrollDecorator> {
  /// CONTROLLERS
  ScrollController? _controller;

  /// PROPERTIES
  late Widget content;

  /// ACCESSORS
  ScrollController get currentController => (widget.controller ?? _controller)!;

  @override
  void initState() {
    if (widget.controller == null) _controller = ScrollController();
    widget.onInit?.call(currentController);
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    content = widget.builder(currentController);
    return AnimatedBuilder(
      animation: currentController,
      builder: (_, __) {
        return Stack(
          children: <Widget>[
            if (widget.backgroundBuilder != null) ...[
              widget.backgroundBuilder!(currentController),
            ],
            content,
            if (widget.foregroundBuilder != null) ...[
              widget.foregroundBuilder!(currentController),
            ],
          ],
        );
      },
    );
  }
}

/// Builder function type para utilizar con ScrollDecorator.
typedef ScrollBuilder = Widget Function(ScrollController scrollController);
