part of '../../../pages/list/list_page.dart';

class _PhotoGrid extends StatefulWidget {
  const _PhotoGrid({required this.imageFiles, Key? key}) : super(key: key);

  final List<XFile> imageFiles;

  @override
  State<_PhotoGrid> createState() => _PhotoGridState();
}

class _PhotoGridState extends State<_PhotoGrid> {
  // CONTROLLERS
  late ScrollController _controller;

  // PROPERTIES
  double _prevVelocity = -1;

  // EVENTS
  void _handleResultsScrolled() {
    // Ocultar el teclado si la lista se desplaza manualmente por el puntero,ignorando los cambios de desplazamiento basados en la velocidad,
    // como la desaceleración o el rebote por sobredesplazamiento.
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
      onInit  : (ScrollController controller) => controller.addListener(_handleResultsScrolled),
      builder : (ScrollController controller) {
        _controller = controller;
        return CustomScrollView(
          controller      : controller,
          scrollBehavior  : ScrollConfiguration.of(context).copyWith(scrollbars: false),
          slivers         : <Widget>[
            SliverPadding(
              padding : EdgeInsets.all($styles.insets.sm).copyWith(bottom: $styles.insets.offset * 1.5),
              sliver  : SliverMasonryGrid.count(
                crossAxisCount    : (context.widthPx / 300).ceil(),
                mainAxisSpacing   : $styles.insets.sm,
                crossAxisSpacing  : $styles.insets.sm,
                childCount        : widget.imageFiles.length,
                itemBuilder       : (BuildContext context, int index) => _PhotoTile(imagePath: widget.imageFiles[index].path),
              ),
            ),
          ],
        );
      },
    );
  }
}
