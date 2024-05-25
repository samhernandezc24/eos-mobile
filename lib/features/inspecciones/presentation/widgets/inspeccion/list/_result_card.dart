part of '../../../pages/list/list_page.dart';

class _ResultCard extends StatelessWidget {
  const _ResultCard({required this.inspeccion, required this.buildDataSourceCallback, Key? key}) : super(key: key);

  final InspeccionDataSourceEntity inspeccion;
  final VoidCallback buildDataSourceCallback;

  // METHODS
  void _handleChecklistInspeccionPressed(BuildContext context, InspeccionIdReqEntity idInspeccion) {
    Navigator.push<void>(
      context,
      PageRouteBuilder<void>(
        transitionDuration: $styles.times.pageTransition,
        pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
          const Offset begin    = Offset(0, 1);
          const Offset end      = Offset.zero;
          const Cubic curve     = Curves.ease;

          final Animatable<Offset> tween = Tween<Offset>(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position  : animation.drive<Offset>(tween),
            child     : _ChecklistInspeccion(idInspeccion: idInspeccion, buildDataSourceCallback: buildDataSourceCallback),
          );
        },
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation : 3,
      shape     : RoundedRectangleBorder(borderRadius: BorderRadius.circular($styles.corners.md)),
      margin    : EdgeInsets.only(bottom: $styles.insets.lg),
      child     : Stack(
        children: <Widget>[
          Container(
            padding : EdgeInsets.all($styles.insets.xs),
            child   : Row(
              crossAxisAlignment  : CrossAxisAlignment.start,
              children            : <Widget>[
                _buildInspeccionFechaSection(context, inspeccion),

                Gap($styles.insets.sm),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Folio inspección:', style: $styles.textStyles.bodySmall),
                          Text(inspeccion.folio, style: $styles.textStyles.bodyBold),

                          Text('Requerimiento:', style: $styles.textStyles.bodySmall),
                          Text(
                            inspeccion.hasRequerimiento == false ? 'SIN REQUERIMIENTO' : inspeccion.requerimientoFolio ?? '',
                            style: $styles.textStyles.bodySmallBold,
                          ),

                          Text('Número económico:', style: $styles.textStyles.bodySmall),
                          Text(inspeccion.unidadNumeroEconomico, style: $styles.textStyles.bodySmallBold, overflow: TextOverflow.ellipsis),

                          Text('Tipo de unidad:', style: $styles.textStyles.bodySmall),
                          Text(inspeccion.unidadTipoName ?? '', style: $styles.textStyles.bodySmallBold, overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            top   : 0,
            right : 0,
            child : PopupMenuButton<InspeccionMenu>(
              icon        : const Icon(Icons.more_vert),
              onSelected  : (InspeccionMenu item) {
                switch (item) {
                  case InspeccionMenu.details:
                  case InspeccionMenu.cancel:
                }
              },
              itemBuilder : (BuildContext context) {
                return <PopupMenuEntry<InspeccionMenu>>[
                  const PopupMenuItem<InspeccionMenu>(
                    value : InspeccionMenu.details,
                    child : ListTile(leading: Icon(Icons.info), title: Text('Detalles')),
                  ),
                  const PopupMenuItem<InspeccionMenu>(
                    value : InspeccionMenu.cancel,
                    child : ListTile(leading: Icon(Icons.delete_forever), title: Text('Cancelar')),
                  ),
                ];
              },
            ),
          ),

          if (inspeccion.idInspeccionEstatus == 'ea52bdfd-8af6-4f5a-b182-2b99e554eb31' || inspeccion.idInspeccionEstatus == 'ea52bdfd-8af6-4f5a-b182-2b99e554eb32')
            Positioned(
              bottom  : 0,
              right   : $styles.insets.xs,
              child   : TextButton.icon(
                onPressed : () => _handleChecklistInspeccionPressed(context, InspeccionIdReqEntity(idInspeccion: inspeccion.idInspeccion)),
                icon: const Icon(Icons.assignment_turned_in),
                label: const Text('Evaluar'),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInspeccionFechaSection(BuildContext context, InspeccionDataSourceEntity inspeccion) {
    final double borderRadius = $styles.corners.md;
    switch (inspeccion.idInspeccionEstatus) {
      // POR EVALUAR:
      case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb31':
        return DefaultTextColor(
          color : Theme.of(context).colorScheme.onSecondaryContainer,
          child : Column(
            children: <Widget>[
              Container(
                width       : 100,
                decoration  : BoxDecoration(
                  color         : Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius  : BorderRadius.only(topLeft: Radius.circular(borderRadius), topRight: Radius.circular(borderRadius)),
                ),
                padding     : EdgeInsets.symmetric(horizontal: $styles.insets.sm, vertical: $styles.insets.md),
                child       : Column(
                  children  : <Widget>[
                    Text(DateFormat('MMM').format(inspeccion.fechaProgramada).toUpperCase(), style: $styles.textStyles.bodySmallBold),
                    Text(DateFormat('dd').format(inspeccion.fechaProgramada), style: $styles.textStyles.h3),
                    Divider(color: Theme.of(context).colorScheme.onSecondaryContainer, thickness: 1.5),
                    Gap($styles.insets.xxs),
                    Icon(Icons.pending_actions, color: Theme.of(context).colorScheme.onSecondaryContainer),
                    Gap($styles.insets.xxs),
                    Text(inspeccion.inspeccionEstatusName.toProperCase(), style: $styles.textStyles.bodySmall.copyWith(fontSize: 13, height: 1.3), softWrap: true, textAlign: TextAlign.center),
                  ],
                ),
              ),

              Container(
                width: 100,
                decoration  : BoxDecoration(
                  color         : Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.6),
                  borderRadius  : BorderRadius.only(bottomLeft: Radius.circular(borderRadius), bottomRight: Radius.circular(borderRadius)),
                ),
                padding     : EdgeInsets.all($styles.insets.sm),
                child       : Column(
                  children  : <Widget>[ Text(DateFormat('hh:mm a').format(inspeccion.fechaProgramada), style: $styles.textStyles.bodySmallBold) ],
                ),
              ),
            ],
          ),
        );

      // EVALUACIÓN:
      case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb32':
        return DefaultTextColor(
          color : Theme.of(context).colorScheme.onPrimaryContainer,
          child : Column(
            children: <Widget>[
              Container(
                width       : 100,
                decoration  : BoxDecoration(
                  color         : Theme.of(context).colorScheme.primaryContainer,
                  borderRadius  : BorderRadius.only(topLeft: Radius.circular(borderRadius), topRight: Radius.circular(borderRadius)),
                ),
                padding     : EdgeInsets.symmetric(horizontal: $styles.insets.sm, vertical: $styles.insets.lg),
                child       : Column(
                  children  : <Widget>[
                    Text(DateFormat('MMM').format(inspeccion.fechaProgramada).toUpperCase(), style: $styles.textStyles.bodySmallBold),
                    Text(DateFormat('dd').format(inspeccion.fechaProgramada), style: $styles.textStyles.h3),
                    Divider(color: Theme.of(context).colorScheme.onPrimaryContainer, thickness: 1.5),
                    Gap($styles.insets.xxs),
                    Icon(Icons.assignment_turned_in, color: Theme.of(context).colorScheme.onPrimaryContainer),
                    Gap($styles.insets.xxs),
                    Text(inspeccion.inspeccionEstatusName.toProperCase(), style: $styles.textStyles.bodySmall.copyWith(fontSize: 13, height: 1.3), softWrap: true, textAlign: TextAlign.center),
                  ],
                ),
              ),

              Container(
                width: 100,
                decoration  : BoxDecoration(
                  color         : Theme.of(context).colorScheme.primaryContainer.withOpacity(0.6),
                  borderRadius  : BorderRadius.only(bottomLeft: Radius.circular(borderRadius), bottomRight: Radius.circular(borderRadius)),
                ),
                padding     : EdgeInsets.all($styles.insets.sm),
                child       : Column(
                  children  : <Widget>[ Text(DateFormat('hh:mm a').format(inspeccion.fechaProgramada), style: $styles.textStyles.bodySmallBold) ],
                ),
              ),
            ],
          ),
        );

      // FINALIZADO:
      case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb33':
        return DefaultTextColor(
          color : Theme.of(context).colorScheme.onPrimaryContainer,
          child : Column(
            children: <Widget>[
              Container(
                width       : 100,
                decoration  : BoxDecoration(
                  color         : Colors.green[600],
                  borderRadius  : BorderRadius.only(topLeft: Radius.circular(borderRadius), topRight: Radius.circular(borderRadius)),
                ),
                padding     : EdgeInsets.symmetric(horizontal: $styles.insets.sm, vertical: $styles.insets.md),
                child       : Column(
                  children  : <Widget>[
                    Text(DateFormat('MMM').format(inspeccion.fechaProgramada).toUpperCase(), style: $styles.textStyles.bodySmallBold),
                    Text(DateFormat('dd').format(inspeccion.fechaProgramada), style: $styles.textStyles.h3),
                    Divider(color: Theme.of(context).colorScheme.onPrimaryContainer, thickness: 1.5),
                    Gap($styles.insets.xxs),
                    Icon(Icons.check_circle, color: Theme.of(context).colorScheme.onPrimaryContainer),
                    Gap($styles.insets.xxs),
                    Text(inspeccion.inspeccionEstatusName.toProperCase(), style: $styles.textStyles.bodySmall.copyWith(height: 1.3), softWrap: true, textAlign: TextAlign.center),
                  ],
                ),
              ),

              Container(
                width: 100,
                decoration  : BoxDecoration(
                  color         : Colors.green[600]!.withOpacity(0.6),
                  borderRadius  : BorderRadius.only(bottomLeft: Radius.circular(borderRadius), bottomRight: Radius.circular(borderRadius)),
                ),
                padding     : EdgeInsets.all($styles.insets.sm),
                child       : Column(
                  children  : <Widget>[ Text(DateFormat('hh:mm a').format(inspeccion.fechaProgramada), style: $styles.textStyles.bodySmallBold) ],
                ),
              ),
            ],
          ),
        );

      // CANCELADO:
      case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb34':
        return DefaultTextColor(
          color : Theme.of(context).colorScheme.onError,
          child : Column(
            children: <Widget>[
              Container(
                width       : 100,
                decoration  : BoxDecoration(
                  color         : Theme.of(context).colorScheme.error,
                  borderRadius  : BorderRadius.only(topLeft: Radius.circular(borderRadius), topRight: Radius.circular(borderRadius)),
                ),
                padding     : EdgeInsets.symmetric(horizontal: $styles.insets.sm, vertical: $styles.insets.lg),
                child       : Column(
                  children  : <Widget>[
                    Text(DateFormat('MMM').format(inspeccion.fechaProgramada).toUpperCase(), style: $styles.textStyles.bodySmallBold),
                    Text(DateFormat('dd').format(inspeccion.fechaProgramada), style: $styles.textStyles.h3),
                    Divider(color: Theme.of(context).colorScheme.onError, thickness: 1.5),
                    Gap($styles.insets.xxs),
                    Icon(Icons.cancel, color: Theme.of(context).colorScheme.onError),
                    Gap($styles.insets.xxs),
                    Text(inspeccion.inspeccionEstatusName.toProperCase(), style: $styles.textStyles.bodySmall.copyWith(fontSize: 13, height: 1.3), softWrap: true, textAlign: TextAlign.center),
                  ],
                ),
              ),

              Container(
                width: 100,
                decoration  : BoxDecoration(
                  color         : Theme.of(context).colorScheme.error.withOpacity(0.6),
                  borderRadius  : BorderRadius.only(bottomLeft: Radius.circular(borderRadius), bottomRight: Radius.circular(borderRadius)),
                ),
                padding     : EdgeInsets.all($styles.insets.sm),
                child       : Column(
                  children  : <Widget>[ Text(DateFormat('hh:mm a').format(inspeccion.fechaProgramada), style: $styles.textStyles.bodySmallBold) ],
                ),
              ),
            ],
          ),
        );

      // DESCONOCIDO:
      default:
        return DefaultTextColor(
          color : Theme.of(context).colorScheme.onPrimary,
          child : Column(
            children: <Widget>[
              Container(
                width       : 100,
                decoration  : BoxDecoration(
                  color         : Theme.of(context).colorScheme.primary,
                  borderRadius  : BorderRadius.only(topLeft: Radius.circular(borderRadius), topRight: Radius.circular(borderRadius)),
                ),
                padding     : EdgeInsets.symmetric(horizontal: $styles.insets.sm, vertical: $styles.insets.lg),
                child       : Column(
                  children  : <Widget>[
                    Text(DateFormat('MMM').format(inspeccion.fechaProgramada).toUpperCase(), style: $styles.textStyles.bodySmallBold),
                    Text(DateFormat('dd').format(inspeccion.fechaProgramada), style: $styles.textStyles.h3),
                    Divider(color: Theme.of(context).colorScheme.onPrimary, thickness: 1.5),
                    Gap($styles.insets.xxs),
                    Icon(Icons.question_mark, color: Theme.of(context).colorScheme.onPrimary),
                    Gap($styles.insets.xxs),
                    Text('Desconocido', style: $styles.textStyles.bodySmall.copyWith(height: 1.3), softWrap: true, textAlign: TextAlign.center),
                  ],
                ),
              ),

              Container(
                width: 100,
                decoration  : BoxDecoration(
                  color         : Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.6),
                  borderRadius  : BorderRadius.only(bottomLeft: Radius.circular(borderRadius), bottomRight: Radius.circular(borderRadius)),
                ),
                padding     : EdgeInsets.all($styles.insets.sm),
                child       : Column(
                  children  : <Widget>[ Text(DateFormat('hh:mm a').format(inspeccion.fechaProgramada), style: $styles.textStyles.bodySmallBold) ],
                ),
              ),
            ],
          ),
        );
    }
  }
}
