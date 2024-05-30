part of '../../../pages/list/list_page.dart';

class _PhotosGrid extends StatefulWidget {
  const _PhotosGrid({Key? key}) : super(key: key);

  @override
  State<_PhotosGrid> createState() => _PhotosGridState();
}

class _PhotosGridState extends State<_PhotosGrid> {
  // CONTROLLERS
  late ScrollController _controller;

  // PROPERTIES
  double _prevVelocity = -1;

  List<String> _imageUrls = [];

  @override
  void initState() {
    super.initState();
    _imageUrls = [
      'https://via.placeholder.com/300',
      'https://via.placeholder.com/300',
      'https://via.placeholder.com/300',
      'https://via.placeholder.com/300',
      'https://via.placeholder.com/300',
      'https://via.placeholder.com/300',
      'https://via.placeholder.com/300',
      'https://via.placeholder.com/300',
      'https://via.placeholder.com/300',
      'https://via.placeholder.com/300',
    ];
  }

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
                childCount        : _imageUrls.length,
                itemBuilder       : (BuildContext context, int index) => _PhotoTile(imageUrl: _imageUrls[index]),
              ),
            ),
          ],
        );
      },
    );
  }
}
