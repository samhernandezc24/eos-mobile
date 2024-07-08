part of '../../../../pages/index/index_page.dart';

class _ItemInspeccionFicheroGrid extends StatefulWidget {
  const _ItemInspeccionFicheroGrid({
    required this.files,
    required this.onImagePressed,
    required this.onDeletePressed,
    required this.isUploading,
    Key? key,
  }) : super(key: key);

  final List<File> files;
  final void Function(List<File> files, int index) onImagePressed;
  final void Function(int index) onDeletePressed;
  final bool isUploading;

  @override
  State<_ItemInspeccionFicheroGrid> createState() => _ItemInspeccionFicheroGridState();
}

class _ItemInspeccionFicheroGridState extends State<_ItemInspeccionFicheroGrid> {
  // CONTROLLERS
  late ScrollController _controller;

  // PROPERTIES
  double _prevVelocity = -1;

  // EVENTS
  void _handleResultsScrolled() {
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
      onInit  : (controller) => controller.addListener(_handleResultsScrolled),
      builder : (controller) {
        _controller = controller;
        return CustomScrollView(
          controller: controller,
          scrollBehavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          slivers: [
            SliverPadding(
              padding: EdgeInsets.all($styles.insets.sm).copyWith(bottom: $styles.insets.offset),
              sliver: SliverMasonryGrid.count(
                crossAxisCount    : (context.widthPx / 300).ceil(),
                mainAxisSpacing   : $styles.insets.sm,
                crossAxisSpacing  : $styles.insets.sm,
                childCount        : widget.files.length,
                itemBuilder       : (BuildContext context, int index) =>
                    _ItemInspeccionFicheroTile(
                      objFile         : widget.files[index],
                      files           : widget.files,
                      index           : index,
                      onImagePressed  : widget.onImagePressed,
                      onDeletePressed : widget.onDeletePressed,
                      isUploading     : widget.isUploading && index == 0,
                    ),
              ),
            ),
          ],
        );
      },
    );
  }
}
