part of '../../../pages/list/list_page.dart';

class _InspeccionFicheroItemGrid extends StatefulWidget {
  const _InspeccionFicheroItemGrid({
    required this.files,
    required this.onImagePressed,
    required this.onDeletePressed,
    Key? key,
  }) : super(key: key);

  final List<File> files;
  final void Function(List<File> files, int index) onImagePressed;
  final void Function(int index) onDeletePressed;

  @override
  State<_InspeccionFicheroItemGrid> createState() => _InspeccionFicheroItemGridState();
}

class _InspeccionFicheroItemGridState extends State<_InspeccionFicheroItemGrid> {
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
                    _InspeccionFicheroItemTile(
                      objFile         : widget.files[index],
                      files           : widget.files,
                      index           : index,
                      onImagePressed  : widget.onImagePressed,
                      onDeletePressed : widget.onDeletePressed,
                    ),
              ),
            ),
          ],
        );
      },
    );
  }
}
