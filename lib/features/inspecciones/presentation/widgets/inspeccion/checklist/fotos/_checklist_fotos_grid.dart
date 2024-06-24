part of '../../../../pages/list/list_page.dart';

class _ChecklistFotosGrid extends StatefulWidget {
  const _ChecklistFotosGrid({
    required this.ficheros,
    required this.onImagePressed,
    Key? key,
  }) : super(key: key);

  final List<Fichero> ficheros;
  final void Function(List<Fichero> ficheros, int index) onImagePressed;

  @override
  State<_ChecklistFotosGrid> createState() => _ChecklistFotosGridState();
}

class _ChecklistFotosGridState extends State<_ChecklistFotosGrid> {
  // CONTROLLERS
  late ScrollController _controller;

  // PROPERTIES
  double _prevVelocity = -1;

  // EVENTS
  void _handleListScrolled() {
    // Ocultar el teclado si la lista se desplaza manualmente por el puntero, ignorando los cambios de desplazamiento
    // basados en la velocidad, como la desaceleración o el bounce por sobredesplazamiento.
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    final velocity = _controller.position.activity?.velocity;
    if (velocity == 0 && _prevVelocity == 0) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
    _prevVelocity = velocity ?? _prevVelocity;
  }

  @override
  Widget build(BuildContext context) {
    return ScrollDecorator.shadow(
      onInit  : (controller) => controller.addListener(_handleListScrolled),
      builder : (controller) {
        _controller = controller;
        return CustomScrollView(
          controller      : controller,
          scrollBehavior  : ScrollConfiguration.of(context).copyWith(scrollbars: false),
          slivers         : <Widget>[
            SliverPadding(
              padding: EdgeInsets.all($styles.insets.sm).copyWith(bottom: $styles.insets.offset),
              sliver: SliverMasonryGrid.count(
                crossAxisCount    : (context.widthPx / 300).ceil(),
                mainAxisSpacing   : $styles.insets.sm,
                crossAxisSpacing  : $styles.insets.sm,
                childCount        : widget.ficheros.length,
                itemBuilder       : (BuildContext context, int index) =>
                    _ChecklistFotosTile(
                      objFichero      : widget.ficheros[index],
                      ficheros        : widget.ficheros,
                      index           : index,
                      onImagePressed  : widget.onImagePressed,
                    ),
              ),
            ),
          ],
        );
      },
    );
  }
}
