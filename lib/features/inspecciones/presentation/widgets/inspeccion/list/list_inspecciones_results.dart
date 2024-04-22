part of '../../../pages/list/list_page.dart';

class _ListInspeccionesResults extends StatefulWidget {
  const _ListInspeccionesResults({required this.onPressed, Key? key}) : super(key: key);

  final void Function(String?) onPressed;

  @override
  State<_ListInspeccionesResults> createState() => _ListInspeccionesResultsState();
}

class _ListInspeccionesResultsState extends State<_ListInspeccionesResults> {
  late ScrollController _controller;

  double _prevVelocity = -1;

  void _handleResultsScrolled() {
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
      onInit: (controller) => controller.addListener(_handleResultsScrolled),
      builder: (controller) {
        _controller = controller;
        return CustomScrollView(
          controller: controller,
          scrollBehavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          slivers: <Widget>[
            SliverPadding(
              padding: EdgeInsets.all($styles.insets.sm).copyWith(bottom: $styles.insets.offset * 1.2),
              sliver: _buildInspeccionesList(),
            ),
          ],
        );
      },
    );
  }

  Widget _buildInspeccionesList() {
    // Aquí debes reemplazar `inspeccionesList` con la lista real de inspecciones de unidades
    final inspeccionesList = <InspeccionEntity>[
      const InspeccionEntity(idInspeccion: '1', folio: 'Inspección 1'),
      const InspeccionEntity(idInspeccion: '2', folio: 'Inspección 2'),
      const InspeccionEntity(idInspeccion: '3', folio: 'Inspección 3'),
      const InspeccionEntity(idInspeccion: '4', folio: 'Inspección 3'),
      const InspeccionEntity(idInspeccion: '5', folio: 'Inspección 3'),
      const InspeccionEntity(idInspeccion: '6', folio: 'Inspección 3'),
      const InspeccionEntity(idInspeccion: '7', folio: 'Inspección 3'),
      const InspeccionEntity(idInspeccion: '8', folio: 'Inspección 3'),
      const InspeccionEntity(idInspeccion: '9', folio: 'Inspección 3'),
      const InspeccionEntity(idInspeccion: '10', folio: 'Inspección 3'),
    ];

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final inspeccion = inspeccionesList[index];
          return _buildInspeccionCard(inspeccion);
        },
        childCount: inspeccionesList.length,
      ),
    );
  }

   Widget _buildInspeccionCard(InspeccionEntity inspeccion) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular($styles.corners.md)),
      margin: EdgeInsets.only(bottom: $styles.insets.sm),
      child: Container(
        padding: EdgeInsets.all($styles.insets.sm),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(inspeccion.folio),
                  Gap($styles.insets.xs),
                  Text('15 BlueHDI 100 - Active Business'),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(inspeccion.folio),
                  Gap($styles.insets.xs),
                  Text('15 BlueHDI 100 - Active Business'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
