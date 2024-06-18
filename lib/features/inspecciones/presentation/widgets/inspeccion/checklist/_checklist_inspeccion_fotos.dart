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
  String? unidadNumeroEconomico   = '';
  String? unidadTipoName          = '';
  String? unidadNumeroSerie       = '';
  String? idInspeccionEstatus     = '';

  // LIST
  List<Fichero> lstFicheros = [];

  // STATE
  @override
  void initState() {
    super.initState();
    _getFotos();
  }

  bool get isDisabled {
    return idInspeccionEstatus == 'ea52bdfd-8af6-4f5a-b182-2b99e554eb34' ||
           idInspeccionEstatus == 'ea52bdfd-8af6-4f5a-b182-2b99e554eb35';
  }

  // EVENTS
  void _handleRefreshPressed() => _getFotos();

  void _handleCreatePressed(BuildContext context) {
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
            child     : _CreateInspeccionFicheroForm(buildFicheroDataCallback: _getFotos, objInspeccion: widget.objInspeccion),
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
    } else {
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
  }

  void _handlePhotoPressed(Fichero objData) {
    Navigator.push<void>(
      context,
      PageRouteBuilder<void>(
        transitionDuration: $styles.times.pageTransition,
        pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
          return FadeTransition(
            opacity   : animation,
            child     : Scaffold(
              appBar: AppBar(title: Text('Fotografía', style: $styles.textStyles.h3)),
              body: Center(
                child: Image.network(
                  'http://otc.cablesdelgolfo.com/Ficheros/InspeccionesItemsFotos/C6B71E48865D288A4CC414E74096309C.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
        fullscreenDialog: true,
      ),
    );
  }

  // METHODS
  Future<void> _getFotos() async {
    context.read<RemoteInspeccionFicheroBloc>().add(ListInspeccionFicheros(widget.objData));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text($strings.checklistPhotoEvidenceAppBarTitle, style: $styles.textStyles.h3)),
      body: BlocConsumer<RemoteInspeccionFicheroBloc, RemoteInspeccionFicheroState>(
        listener: (BuildContext context, RemoteInspeccionFicheroState state) {
          if (state is RemoteInspeccionFicheroSuccess) {
            setState(() {
              // DATOS
              unidadNumeroEconomico   = state.objResponse?.inspeccion.unidadNumeroEconomico   ?? '';
              unidadTipoName          = state.objResponse?.inspeccion.unidadTipoName          ?? '';
              unidadNumeroSerie       = state.objResponse?.inspeccion.numeroSerie             ?? '';
              idInspeccionEstatus     = state.objResponse?.inspeccion.idInspeccionEstatus     ?? '';

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
            return ErrorInfoContainer(onPressed: _getFotos, errorMessage: state.errorMessage);
          }

          if (state is RemoteInspeccionFicheroServerFailureList) {
            return ErrorInfoContainer(onPressed: _getFotos, errorMessage: state.failure?.errorMessage);
          }

          if (state is RemoteInspeccionFicheroSuccess) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  color   : Theme.of(context).colorScheme.background,
                  padding : EdgeInsets.fromLTRB($styles.insets.sm, $styles.insets.sm, $styles.insets.sm, 0),
                  child   : _buildInspeccionDetails(context),
                ),
                Container(
                  color   : Theme.of(context).colorScheme.background,
                  padding : EdgeInsets.all($styles.insets.xs * 1.5),
                  child   : _buildActionButtons(),
                ),
                Expanded(
                  child: RepaintBoundary(
                    child: lstFicheros.isEmpty
                        ? RequestDataUnavailable(
                            title         : $strings.checklistPhotoEmptyListTitle,
                            message       : $strings.checklistPhotoEmptyListMessage,
                            isRefreshData : false,
                          )
                        : _PhotoGrid(ficheros: lstFicheros, onPressed: _handlePhotoPressed),
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
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
          style: $styles.textStyles.title1.copyWith(
            color       : Theme.of(context).primaryColor,
            fontWeight  : FontWeight.w600,
            height      : 1.3,
          ),
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
          label     : const Text('Actualizar'),
        ),
        Gap($styles.insets.sm),
        FilledButton.icon(
          onPressed : !isDisabled ? () => _handleCreatePressed(context) : null,
          icon      : const Icon(Icons.add),
          label     : const Text('Nuevo'),
        ),
      ],
    );
  }

  Widget _buildBottomAppBar(BuildContext context) {
    return BottomAppBar(
      height  : 70,
      child   : Row(
        children  : <Widget>[
          CircleIconButton(
            icon          : AppIcons.next_large,
            onPressed     : () => Navigator.pop(context),
            semanticLabel : $strings.prevButtonText,
            flipIcon      : true,
          ),
          const Spacer(),
          CircleIconButton(
            icon          : AppIcons.next_large,
            onPressed     : () => _handleNextPressed(context),
            semanticLabel : $strings.nextButtonText,
          ),
        ],
      ),
    );
  }
}
