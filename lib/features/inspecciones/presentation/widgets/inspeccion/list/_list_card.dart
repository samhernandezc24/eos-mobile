part of '../../../pages/list/list_page.dart';

class _ListCard extends StatefulWidget {
  const _ListCard({required this.inspecciones, required this.buildDataSourceCallback, Key? key}) : super(key: key);

  final List<InspeccionDataSourceEntity> inspecciones;
  final VoidCallback buildDataSourceCallback;

  @override
  State<_ListCard> createState() => _ListCardState();
}

class _ListCardState extends State<_ListCard> {
  // CONTROLLERS
  late ScrollController _scrollController;

  // PROPERTIES
  double _prevVelocity = -1;

  // METHODS
  void _handleResultsScrolled() {
    // Ocultar el teclado si la lista se desplaza manualmente por el puntero,ignorando los cambios de desplazamiento basados en la velocidad, como la desaceleración o el rebote por sobredesplazamiento.
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    final velocity = _scrollController.position.activity?.velocity;
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
        _scrollController = controller;
        return CustomScrollView(
          controller      : controller,
          scrollBehavior  : ScrollConfiguration.of(context).copyWith(scrollbars: false),
          slivers         : [
            SliverPadding(
              padding : EdgeInsets.all($styles.insets.sm).copyWith(bottom: $styles.insets.offset),
              sliver  : SliverList(
                delegate  : SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    final InspeccionDataSourceEntity inspeccion = widget.inspecciones[index];
                    return _ResultCard(inspeccion: inspeccion, buildDataSourceCallback: widget.buildDataSourceCallback);
                  },
                  childCount: widget.inspecciones.length,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
