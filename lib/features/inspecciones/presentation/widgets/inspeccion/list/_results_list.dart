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
                        inspeccion.hasRequerimiento == false
                            ? 'SIN REQUERIMIENTO'
                            : inspeccion.requerimientoFolio ?? '',
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
              onPressed: () {},
              icon: Icon(Icons.info, color: Theme.of(context).primaryColor),
              tooltip: 'Ver detalles',
            ),
          ),

          if (inspeccion.idInspeccionEstatus == 'ea52bdfd-8af6-4f5a-b182-2b99e554eb35')
            const SizedBox.shrink()
          else if (inspeccion.idInspeccionEstatus == 'ea52bdfd-8af6-4f5a-b182-2b99e554eb34')
            Positioned(
              bottom: 0,
              right: $styles.insets.xxs,
              child: TextButton.icon(
                onPressed: (){},
                icon: const Icon(Icons.print),
                label: const Text('Reporte'),
                style: ButtonStyle(
                  foregroundColor: Theme.of(context).brightness == Brightness.dark
                      ? MaterialStateProperty.all<Color>(Colors.green[100]!)
                      : MaterialStateProperty.all<Color>(Colors.green[600]!),
                ),
              ),
            )
          else
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

    switch (inspeccion.idInspeccionEstatus) {
      // POR EVALUAR:
      case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb31':
        return DefaultTextColor(
          color: Theme.of(context).colorScheme.onSecondaryContainer,
          child: Column(
            children: <Widget>[
              Container(
                width: 100,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
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

                    Divider(color: Theme.of(context).colorScheme.onSecondaryContainer, thickness: 1.5),

                    Gap($styles.insets.xs),

                    Icon(Icons.pending_actions, color: Theme.of(context).colorScheme.onSecondaryContainer),

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
                  color: Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.6),
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

      // EVALUACIÓN:
      case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb33':
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

                    Icon(Icons.assignment_turned_in_outlined, color: Theme.of(context).colorScheme.onPrimary),

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

      // FINALIZADO:
      case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb34':
        return DefaultTextColor(
          color: Theme.of(context).brightness == Brightness.dark
              ? Theme.of(context).colorScheme.onSurface
              : Theme.of(context).colorScheme.onPrimary,
          child: Column(
            children: <Widget>[
              Container(
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.green[600],
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

                    Divider(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Theme.of(context).colorScheme.onSurface
                          : Theme.of(context).colorScheme.onPrimary,
                      thickness: 1.5,
                    ),

                    Gap($styles.insets.xs),

                    Icon(
                      Icons.check,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Theme.of(context).colorScheme.onSurface
                          : Theme.of(context).colorScheme.onPrimary,
                    ),

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
                  color: Colors.green[600]!.withOpacity(0.6),
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

      // CANCELADO:
      case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb35':
        return DefaultTextColor(
          color: Theme.of(context).colorScheme.onError,
          child: Column(
            children: <Widget>[
              Container(
                width: 100,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.error,
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

                    Divider(color: Theme.of(context).colorScheme.onError, thickness: 1.5),

                    Gap($styles.insets.xs),

                    Icon(Icons.cancel, color: Theme.of(context).colorScheme.onError),

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
                  color: Theme.of(context).colorScheme.error.withOpacity(0.6),
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

      // DESCONOCIDO:
      default:
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

                    Icon(Icons.question_mark, color: Theme.of(context).colorScheme.onPrimary),

                    Gap($styles.insets.xs),

                    Text(
                      'Desconocido',
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
