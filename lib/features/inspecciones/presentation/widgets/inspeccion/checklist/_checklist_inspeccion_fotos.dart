part of '../../../pages/list/list_page.dart';

class _ChecklistInspeccionFotos extends StatefulWidget {
  const _ChecklistInspeccionFotos({
    required this.objData,
    required this.objInspeccion,
    Key? key,
    this.buildDataSourceCallback,
  }) : super(key: key);

  final InspeccionIdReqEntity objData;
  final InspeccionDataSourceEntity objInspeccion;
  final VoidCallback? buildDataSourceCallback;

  @override
  State<_ChecklistInspeccionFotos> createState() => _ChecklistInspeccionFotosState();
}

class _ChecklistInspeccionFotosState extends State<_ChecklistInspeccionFotos> {
  // PROPERTIES
  String? unidadNumeroEconomico = '';
  String? unidadTipoName        = '';
  String? unidadNumeroSerie     = '';
  String? idInspeccionEstatus   = '';

  bool _hasServerError = false;

  // LIST
  List<Fichero> lstFicheros = [];

  bool get isDisabled {
    return idInspeccionEstatus == 'ea52bdfd-8af6-4f5a-b182-2b99e554eb34' ||
           idInspeccionEstatus == 'ea52bdfd-8af6-4f5a-b182-2b99e554eb35';
  }

  // STATE
  @override
  void initState() {
    super.initState();
    getFotos();
  }

  // EVENTS
  void _handleRefreshPressed() => getFotos();

  void _handleCreatePressed(BuildContext context) {
    Navigator.push<void>(
      context,
      PageRouteBuilder<void>(
        pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
          const Offset begin  = Offset(0, 1);
          const Offset end    = Offset.zero;
          const Cubic curve   = Curves.ease;

          final Animatable<Offset> tween = Tween<Offset>(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position  : animation.drive<Offset>(tween),
            child     : _CreateInspeccionFicheroForm(buildFicheroDataCallback: getFotos),
          );
        },
        fullscreenDialog: true,
      ),
    );
  }

  void _handleNextPressed(BuildContext context) {
    if (lstFicheros.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text($strings.settingsAttentionText, style: $styles.textStyles.bodyBold),
              Text(
                $strings.checklistPhotoAlertNextPageMessage,
                style     : $styles.textStyles.bodySmall.copyWith(height: 1.3),
                softWrap  : true,
              ),
            ],
          ),
          backgroundColor : const Color(0xfff89406),
          elevation       : 0,
          behavior        : SnackBarBehavior.fixed,
          showCloseIcon   : true,
        ),
      );
      return;
    }

    Navigator.push<void>(
      context,
      PageRouteBuilder<void>(
        transitionDuration: $styles.times.pageTransition,
        pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) =>
            _ChecklistInspeccionFinal(objInspeccion: widget.objInspeccion, buildDataSourceCallback: widget.buildDataSourceCallback),
        transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
          const Offset begin    = Offset(1, 0);
          const Offset end      = Offset.zero;
          const Cubic curve     = Curves.ease;
          final Animatable<Offset> tween = Tween<Offset>(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(position: animation.drive<Offset>(tween), child: child);
        },
        fullscreenDialog: true,
      ),
    );
  }

  // METHODS
  Future<void> getFotos() async {
    context.read<RemoteInspeccionFicheroBloc>().add(ListInspeccionFicheros(widget.objData));
  }

  @override
  Widget build(BuildContext context) {
    final Widget content = GestureDetector(
      onTap : FocusManager.instance.primaryFocus?.unfocus,
      child : BlocConsumer<RemoteInspeccionFicheroBloc, RemoteInspeccionFicheroState>(
        listener: (BuildContext context, RemoteInspeccionFicheroState state) {
          // ERROR:
          if (state is RemoteInspeccionFicheroServerFailedMessageList ||
              state is RemoteInspeccionFicheroServerFailureList) {
            setState(() {
              _hasServerError = true;
            });
          }

          // SUCCESS:
          if (state is RemoteInspeccionFicheroSuccess) {
            setState(() {
              // STATE
              _hasServerError = false;

              // DATOS
              unidadNumeroEconomico = state.objResponse?.inspeccion.unidadNumeroEconomico   ?? '';
              unidadTipoName        = state.objResponse?.inspeccion.unidadTipoName          ?? '';
              unidadNumeroSerie     = state.objResponse?.inspeccion.numeroSerie             ?? '';
              idInspeccionEstatus   = state.objResponse?.inspeccion.idInspeccionEstatus     ?? '';

              // LIST FOTOS
              lstFicheros = state.objResponse?.ficheros ?? [];
            });
          }
        },
        builder: (BuildContext context, RemoteInspeccionFicheroState state) {
          if (state is RemoteInspeccionFicheroLoading) {
            return const Center(child: AppLoadingIndicator());
          }

          if (state is RemoteInspeccionFicheroServerFailedMessageList) {
            return ErrorInfoContainer(onPressed: getFotos, errorMessage: state.errorMessage);
          }

          if (state is RemoteInspeccionFicheroServerFailureList) {
            return ErrorInfoContainer(onPressed: getFotos, errorMessage: state.failure?.errorMessage);
          }

          if (state is RemoteInspeccionFicheroSuccess) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB($styles.insets.sm, $styles.insets.sm, $styles.insets.sm, $styles.insets.xs),
                  child: _buildInspeccionDetails(context),
                ),
                const Divider(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: $styles.insets.xs * 1.5, vertical: $styles.insets.xs),
                  child: _buildActionButtons(),
                ),
                Expanded(
                  child: RepaintBoundary(
                    child: lstFicheros.isNotEmpty
                        ? const _ChecklistFotosGrid()
                        : RequestDataUnavailable(
                            title         : $strings.checklistPhotoEmptyListTitle,
                            message       : $strings.checklistPhotoEmptyListMessage,
                            isRefreshData : false,
                          ),
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );

    return Scaffold(
      appBar: AppBar(title: Text($strings.checklistPhotoEvidenceAppBarTitle, style: $styles.textStyles.h3)),
      body: Stack(
        children: <Widget>[
          Positioned.fill(child: ColoredBox(color: Theme.of(context).colorScheme.background, child: content)),
        ],
      ),
      bottomNavigationBar: _buildBottomAppBar(context),
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
          onPressed : !isDisabled ? _handleRefreshPressed : null,
          icon      : const Icon(Icons.refresh),
          label     : Text($strings.refreshButtonText, style: $styles.textStyles.button),
        ),
        Gap($styles.insets.sm),
        FilledButton.icon(
          onPressed : !isDisabled ? () => _handleCreatePressed(context) : null,
          icon      : const Icon(Icons.add),
          label     : Text('Nuevo', style: $styles.textStyles.button),
        ),
      ],
    );
  }

  Widget _buildBottomAppBar(BuildContext context) {
    return BottomAppBar(
      height: 70,
      child: Row(
        children: <Widget>[
          CircleIconButton(
            icon          : AppIcons.next_large,
            onPressed     : () =>  Navigator.of(context).pop(),
            semanticLabel : $strings.prevButtonText,
            flipIcon      : true,
          ),
          const Spacer(),
          CircleIconButton(
            icon          : AppIcons.next_large,
            onPressed     : !_hasServerError ? () => _handleNextPressed(context) : null,
            semanticLabel : $strings.nextButtonText,
          ),
        ],
      ),
    );
  }
}
