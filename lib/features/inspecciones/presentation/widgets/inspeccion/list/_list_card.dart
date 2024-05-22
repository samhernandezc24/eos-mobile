part of '../../../pages/list/list_page.dart';

class _ListCard extends StatefulWidget {
  const _ListCard({required this.inspecciones, Key? key}) : super(key: key);

  final List<InspeccionDataSourceEntity> inspecciones;

  @override
  State<_ListCard> createState() => _ListCardState();
}

class _ListCardState extends State<_ListCard> {
  // CONTROLLERS
  late ScrollController _scrollController;

  // METHODS
  void _handleResultsScrolled() {

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
                    return _ResultCard(inspeccion: inspeccion);
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
