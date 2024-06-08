part of '../../../pages/list/list_page.dart';

class _ResultTileInspeccion extends StatelessWidget {
  const _ResultTileInspeccion({Key? key, this.objInspeccion, this.onDetailsPressed, this.onCancelPressed}) : super(key: key);

  final InspeccionDataSourceEntity? objInspeccion;
  final void Function(InspeccionDataSourceEntity)? onDetailsPressed;
  final void Function(InspeccionIdReqEntity, InspeccionDataSourceEntity)? onCancelPressed;

  // EVENTS
  void _handleMenuSelection(BuildContext context, InspeccionMenu item) {
    switch (item) {
      case InspeccionMenu.details:
        _handleDetailsPressed(context, objInspeccion!);
      case InspeccionMenu.cancel:
        _handleCancelPressed(InspeccionIdReqEntity(idInspeccion: objInspeccion!.idInspeccion), objInspeccion!);
    }
  }

  void _handleDetailsPressed(BuildContext context, InspeccionDataSourceEntity objInspeccion) {
    if (onDetailsPressed != null) { return onDetailsPressed!(objInspeccion); }
  }

  void _handleCancelPressed(InspeccionIdReqEntity objData, InspeccionDataSourceEntity objInspeccion) {
    if (onCancelPressed != null) { return onCancelPressed!(objData, objInspeccion); }
  }

  void _handleChecklistPressed(BuildContext context, InspeccionIdReqEntity objData) {
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
            child     : _ChecklistInspeccionEvaluacion(objData: objData, objInspeccion: objInspeccion!),
          );
        },
        fullscreenDialog: true,
      ),
    );
  }

  // METHODS
  bool _showCancelOption(String idInspeccionEstatus) {
    const estatusCancelado = {'ea52bdfd-8af6-4f5a-b182-2b99e554eb34', 'ea52bdfd-8af6-4f5a-b182-2b99e554eb35'};
    return !estatusCancelado.contains(idInspeccionEstatus);
  }

  bool _showChecklistButton(String idInspeccionEstatus) {
    const estatusChecklist = {
      'ea52bdfd-8af6-4f5a-b182-2b99e554eb31',
      'ea52bdfd-8af6-4f5a-b182-2b99e554eb32',
      'ea52bdfd-8af6-4f5a-b182-2b99e554eb33',
    };
    return estatusChecklist.contains(idInspeccionEstatus);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular($styles.corners.md)),
      margin: EdgeInsets.only(bottom: $styles.insets.lg),
      child: Stack(
        children: <Widget>[
          _buildInspeccionInfoCard(context),

          Positioned(
            top: 8,
            right: 8,
            child: PopupMenuButton<InspeccionMenu>(
              icon        : const Icon(Icons.more_vert),
              onSelected  : (InspeccionMenu item) => _handleMenuSelection(context, item),
              itemBuilder : (BuildContext context) {
                final items = <PopupMenuEntry<InspeccionMenu>>[
                  PopupMenuItem(
                    value: InspeccionMenu.details,
                    child: ListTile(
                      leading   : const Icon(Icons.info),
                      iconColor : Theme.of(context).colorScheme.primary,
                      textColor : Theme.of(context).colorScheme.primary,
                      title     : const Text('Detalles'),
                    ),
                  ),
                ];
                if (_showCancelOption(objInspeccion!.idInspeccionEstatus)) {
                  items.add(
                    PopupMenuItem(
                      value: InspeccionMenu.cancel,
                      child: ListTile(
                        leading   : const Icon(Icons.delete_forever),
                        iconColor : Theme.of(context).colorScheme.error,
                        textColor : Theme.of(context).colorScheme.error,
                        title     : const Text('Cancelar'),
                      ),
                    ),
                  );
                }
                return items;
              },
            ),
          ),

          if (_showChecklistButton(objInspeccion!.idInspeccionEstatus))
            Positioned(
              bottom: 0,
              right: 4,
              child: TextButton.icon(
                onPressed : () => _handleChecklistPressed(context, InspeccionIdReqEntity(idInspeccion: objInspeccion!.idInspeccion)),
                icon      : const Icon(Icons.assignment_turned_in),
                label     : Text(
                  objInspeccion!.idInspeccionEstatus == 'ea52bdfd-8af6-4f5a-b182-2b99e554eb33'
                      ? 'Finalizar'
                      : 'Evaluar',
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInspeccionInfoCard(BuildContext context) {
    return Container(
      padding : EdgeInsets.all($styles.insets.xs),
      child   : Row(
        crossAxisAlignment  : CrossAxisAlignment.start,
        children            : <Widget>[
          _buildInspeccionEstatusCard(context, objInspeccion!),
          Gap($styles.insets.sm),
          _buildInspeccionInfo(context, objInspeccion!),
        ],
      ),
    );
  }

  Widget _buildInspeccionEstatusCard(BuildContext context, InspeccionDataSourceEntity objInspeccion) {
    final double borderRadius         = $styles.corners.md;
    final String idInspeccionEstatus  = objInspeccion.idInspeccionEstatus;
    final ColorScheme colorScheme     = Theme.of(context).colorScheme;

    Color getEstatusColor() {
      switch (idInspeccionEstatus) {
        case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb31':
          return colorScheme.secondaryContainer;
        case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb32':
          return colorScheme.primaryContainer;
        case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb33':
          return colorScheme.inversePrimary;
        case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb34':
          return Colors.green[600]!;
        case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb35':
          return colorScheme.error;
        default:
          return colorScheme.primary;
      }
    }

    Color getTextColor() {
      switch (idInspeccionEstatus) {
        case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb31':
          return colorScheme.onSecondaryContainer;
        case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb32':
        case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb33':
        case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb34':
          return colorScheme.onPrimaryContainer;
        case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb35':
          return colorScheme.onError;
        default:
          return colorScheme.onPrimary;
      }
    }

    IconData getEstatusIcon() {
      switch (idInspeccionEstatus) {
        case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb31':
          return Icons.pending_actions;
        case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb32':
          return Icons.assignment_turned_in;
        case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb33':
          return Icons.hourglass_top;
        case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb34':
          return Icons.check_circle;
        case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb35':
          return Icons.cancel;
        default:
          return Icons.question_mark;
      }
    }

    return DefaultTextColor(
      color: getTextColor(),
      child: Column(
        children: <Widget>[
          Container(
            width: 100,
            padding: EdgeInsets.symmetric(horizontal: $styles.insets.sm, vertical: $styles.insets.md),
            decoration: BoxDecoration(
              color         : getEstatusColor(),
              borderRadius  : BorderRadius.only(topLeft: Radius.circular(borderRadius), topRight: Radius.circular(borderRadius)),
            ),
            child: Column(
              children: <Widget>[
                Text(DateFormat('MMM').format(objInspeccion.fechaProgramada).toUpperCase(), style: $styles.textStyles.bodySmallBold),
                Text(DateFormat('dd').format(objInspeccion.fechaProgramada).toUpperCase(), style: $styles.textStyles.h3),
                Divider(color: getTextColor(), thickness: 1.5),
                Gap($styles.insets.xxs),
                Icon(getEstatusIcon(), color: getTextColor()),
                Gap($styles.insets.xxs),
                Text(
                  objInspeccion.inspeccionEstatusName.toProperCase(),
                  style: $styles.textStyles.bodySmall.copyWith(fontSize: 13, height: 1.3),
                  softWrap: true,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Container(
            width: 100,
            padding: EdgeInsets.all($styles.insets.sm),
            decoration: BoxDecoration(
              color         : getEstatusColor().withOpacity(0.6),
              borderRadius  : BorderRadius.only(bottomLeft: Radius.circular(borderRadius), bottomRight: Radius.circular(borderRadius)),
            ),
            child: Center(
              child: Text(DateFormat('hh:mm a').format(objInspeccion.fechaProgramada), style: $styles.textStyles.bodySmallBold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInspeccionInfo(BuildContext context, InspeccionDataSourceEntity objInspeccion) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Folio inspección:', style: $styles.textStyles.bodySmall),
              Text(objInspeccion.folio, style: $styles.textStyles.bodyBold),

              Text('Requerimiento:', style: $styles.textStyles.bodySmall),
              Text(
                objInspeccion.hasRequerimiento == false ? 'SIN REQUERIMIENTO' : objInspeccion.requerimientoFolio ?? '',
                style: $styles.textStyles.bodySmallBold,
              ),

              Text('Número económico:', style: $styles.textStyles.bodySmall),
              Text(objInspeccion.unidadNumeroEconomico, style: $styles.textStyles.bodySmallBold, overflow: TextOverflow.ellipsis),

              Text('Tipo de unidad:', style: $styles.textStyles.bodySmall),
              Text(objInspeccion.unidadTipoName ?? '', style: $styles.textStyles.bodySmallBold, overflow: TextOverflow.ellipsis),
            ],
          ),
        ],
      ),
    );
  }
}
