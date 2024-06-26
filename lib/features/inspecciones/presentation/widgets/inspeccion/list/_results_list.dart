part of '../../../pages/list/list_page.dart';

class _ResultsListInspeccion extends StatefulWidget {
  const _ResultsListInspeccion({required this.lstRows, this.onDetailsPressed, this.onCancelPressed, Key? key, this.buildDataSourceCallback}) : super(key: key);

  final List<InspeccionDataSourceEntity> lstRows;
  final void Function(InspeccionDataSourceEntity)? onDetailsPressed;
  final void Function(InspeccionIdReqEntity, InspeccionDataSourceEntity)? onCancelPressed;
  final VoidCallback? buildDataSourceCallback;

  @override
  State<_ResultsListInspeccion> createState() => _ResultsListInspeccionState();
}

class _ResultsListInspeccionState extends State<_ResultsListInspeccion> {
  // CONTROLLERS
  late ScrollController _controller;

  final PagingController<int, InspeccionDataSourceEntity> _pagingController = PagingController(firstPageKey: 0);

  // PROPERTIES
  double _prevVelocity = -1;

  // STATE
  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

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

  // METHODS
  Future<void> _fetchPage(int pageKey) async {

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
              padding : EdgeInsets.all($styles.insets.sm).copyWith(bottom: $styles.insets.offset),
              sliver  : SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return _ResultTileInspeccion(
                      objInspeccion           : widget.lstRows[index],
                      onDetailsPressed        : widget.onDetailsPressed,
                      onCancelPressed         : widget.onCancelPressed,
                      buildDataSourceCallback : widget.buildDataSourceCallback,
                    );
                  },
                  childCount: widget.lstRows.length,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
