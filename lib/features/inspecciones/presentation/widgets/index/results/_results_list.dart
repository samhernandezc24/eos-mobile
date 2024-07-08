part of '../../../pages/index/index_page.dart';

class _ResultsInspeccionList extends StatefulWidget {
  const _ResultsInspeccionList({
    required this.results,
    Key? key,
    this.onDetailsPressed,
    this.onCancelPressed,
    this.onComplete,
  }) : super(key: key);

  final List<InspeccionEntity> results;
  final void Function(BuildContext, InspeccionEntity)? onDetailsPressed;
  final void Function(BuildContext, InspeccionIdParamEntity, InspeccionEntity)? onCancelPressed;
  final VoidCallback? onComplete;

  @override
  State<_ResultsInspeccionList> createState() => _ResultsInspeccionListState();
}

class _ResultsInspeccionListState extends State<_ResultsInspeccionList> {
  // CONTROLLER
  late ScrollController _controller;

  // PROPERTIES
  double _prevVelocity = -1;

  // EVENTS
  void _handleResultsScrolled() {
    // Ocultar el teclado si la lista se desplaza manualmente por el puntero, ignorando los cambios de desplazamiento
    // basados en la velocidad, como la desaceleración o el bounce por sobredesplazamiento.
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    final double? velocity = _controller.position.activity?.velocity;
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
          controller      : controller,
          scrollBehavior  : ScrollConfiguration.of(context).copyWith(scrollbars: false),
          slivers         : <Widget>[
            SliverPadding(
              padding : EdgeInsets.all($styles.insets.sm).copyWith(bottom: $styles.insets.offset),
              sliver  : SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: widget.results.length,
                  (BuildContext context, int index) {
                    return _ResultInspeccionTile(
                      objInspeccion     : widget.results[index],
                      onDetailsPressed  : widget.onDetailsPressed,
                      onCancelPressed   : widget.onCancelPressed,
                      onComplete        : widget.onComplete,
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
