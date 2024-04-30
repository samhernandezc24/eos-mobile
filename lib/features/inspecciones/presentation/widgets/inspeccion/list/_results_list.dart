part of '../../../pages/list/list_page.dart';

class _ResultsList extends StatefulWidget {
  const _ResultsList({required this.onPressed, Key? key, this.lstRows}) : super(key: key);

  final void Function(String?) onPressed;
  final List<InspeccionDataSourceEntity>? lstRows;

  @override
  State<_ResultsList> createState() => _ResultsListState();
}

class _ResultsListState extends State<_ResultsList> {
  /// CONTROLLERS
  late ScrollController _controller;

  /// PROPERTIES
  double _prevVelocity = -1;

  /// METHODS
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
              padding: EdgeInsets.all($styles.insets.sm).copyWith(bottom: $styles.insets.offset),
              sliver: _buildInspeccionesList(widget.lstRows ?? []),
            ),
          ],
        );
      },
    );
  }

  Widget _buildInspeccionesList(List<InspeccionDataSourceEntity> lstRows) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final InspeccionDataSourceEntity inspeccion = lstRows[index];
          return _buildInspeccionCard(inspeccion);
        },
        childCount: lstRows.length,
      ),
    );
  }

   Widget _buildInspeccionCard(InspeccionDataSourceEntity inspeccion) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular($styles.corners.md)),
      margin: EdgeInsets.only(bottom: $styles.insets.lg),
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all($styles.insets.xs),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildInspeccionFechaSection(inspeccion, inspeccion.fecha),

                Gap($styles.insets.sm),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _buildInspeccionInfoText('Folio inspección: ', inspeccion.folio),
                      _buildInspeccionInfoText(
                        'Requerimiento: ',
                        inspeccion.hasRequerimiento == false ? 'SIN REQUERIMIENTO' : inspeccion.requerimientoFolio ?? '',
                      ),
                      _buildInspeccionInfoText('No. económico: ', inspeccion.unidadNumeroEconomico),
                      _buildInspeccionInfoText('Tipo de unidad: ', inspeccion.unidadTipoName),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            top: 0,
            right: $styles.insets.xxs,
            child: IconButton(
              onPressed: (){},
              icon: Icon(Icons.info, color: Theme.of(context).primaryColor),
              tooltip: 'Ver detalles',
            ),
          ),

          Positioned(
            bottom: 0,
            right: $styles.insets.xxs,
            child: TextButton.icon(
              onPressed: (){},
              icon: const Icon(Icons.assignment_turned_in_outlined),
              label: const Text('Evaluar'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInspeccionFechaSection(InspeccionDataSourceEntity inspeccion, DateTime fechaInspeccion) {
    final double borderRadius = $styles.corners.md;

    return DefaultTextColor(
      color: Theme.of(context).colorScheme.onPrimary,
      child: Column(
        children: <Widget>[
          Container(
            width: 100,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(borderRadius), topRight: Radius.circular(borderRadius)),
            ),
            padding: EdgeInsets.all($styles.insets.sm),
            child: Column(
              children: <Widget>[
                Text(
                  DateFormat('MMM').format(fechaInspeccion).toUpperCase(),
                  style: $styles.textStyles.bodySmallBold,
                ),

                Text(DateFormat('dd').format(fechaInspeccion), style: $styles.textStyles.h3),

                Divider(color: Theme.of(context).colorScheme.onPrimary, thickness: 1.5),

                Gap($styles.insets.xs),

                Icon(Icons.pending_actions, color: Theme.of(context).colorScheme.onPrimary),

                Gap($styles.insets.xs),

                Text(
                  inspeccion.inspeccionEstatusName.toProperCase(),
                  style: $styles.textStyles.label.copyWith(fontSize: 13, height: 1.3),
                  softWrap: true,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          Container(
            width: 100,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(borderRadius), bottomRight: Radius.circular(borderRadius)),
            ),
            padding: EdgeInsets.all($styles.insets.sm),
            child: Column(
              children: <Widget>[
                Text(DateFormat('hh:mm a').format(fechaInspeccion), style: $styles.textStyles.bodySmallBold),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInspeccionInfoText(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label, style: $styles.textStyles.label),
        Text(value, style: $styles.textStyles.label.copyWith(fontSize: 16, fontWeight: FontWeight.w600, height: 1.3), overflow: TextOverflow.ellipsis),
        Gap($styles.insets.xxs),
      ],
    );
  }
}
