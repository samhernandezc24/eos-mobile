part of '../../../pages/index/index_page.dart';

class _ChecklistInspeccionFotos extends StatefulWidget {
  const _ChecklistInspeccionFotos({Key? key}) : super(key: key);

  @override
  State<_ChecklistInspeccionFotos> createState() => _ChecklistInspeccionFotosState();
}

class _ChecklistInspeccionFotosState extends State<_ChecklistInspeccionFotos> {
  // PROPERTIES
  String? unidadNumeroEconomico = '';
  String? unidadTipoName        = '';
  String? unidadNumeroSerie     = '';
  String? idInspeccionEstatus   = '';

  bool get isDisabled {
    return idInspeccionEstatus == 'ea52bdfd-8af6-4f5a-b182-2b99e554eb34' ||
           idInspeccionEstatus == 'ea52bdfd-8af6-4f5a-b182-2b99e554eb35';
  }

  // EVENTS
  // void _handleRefreshPressed() => getFotos();

  @override
  Widget build(BuildContext context) {
    final Widget content = GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // DETALLES
          Container(
            padding : EdgeInsets.fromLTRB($styles.insets.sm, $styles.insets.sm, $styles.insets.sm, $styles.insets.xs),
            child   : _buildInspeccionDetails(context),
          ),
          const Divider(),
          // ACCIONES
          Container(
            padding : EdgeInsets.symmetric(horizontal: $styles.insets.xs * 1.5, vertical: $styles.insets.xs),
            child   : _buildActionButtons(),
          ),
        ],
      ),
    );
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.inspeccionChecklistPhotoEvidenceAppBarTitle, style: $styles.textStyles.h3)),
      body: Stack(
        children: <Widget>[
          Positioned.fill(child: ColoredBox(color: Theme.of(context).colorScheme.background, child: content)),
        ],
      ),
    );
  }

  Widget _buildInspeccionDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Número económico:', style: $styles.textStyles.bodySmall),
        Text(
          '$unidadNumeroEconomico',
          style: $styles.textStyles.title1.copyWith(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600, height: 1.3),
        ),
        RichText(
          text: TextSpan(
            style     : $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.onBackground),
            children  : <InlineSpan>[
              const TextSpan(text: 'Tipo de unidad'),
              TextSpan(text: ': $unidadTipoName'),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            style     : $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.onBackground),
            children  : <InlineSpan>[
              const TextSpan(text: 'Número de serie'),
              TextSpan(text: ': $unidadNumeroSerie'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: <Widget>[
        FilledButton.icon(
          onPressed : !isDisabled ? (){} : null,
          icon      : const Icon(Icons.refresh),
          label     : Text(AppStrings.btnRefreshText, style: $styles.textStyles.button),
        ),
        Gap($styles.insets.sm),
        FilledButton.icon(
          onPressed : !isDisabled ? () {} : null,
          icon      : const Icon(Icons.add),
          label     : Text('Nuevo', style: $styles.textStyles.button),
        ),
      ],
    );
  }
}
