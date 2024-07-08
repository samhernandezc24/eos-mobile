part of '../../../pages/index/index_page.dart';

class _ChecklistInspeccionFotos extends StatefulWidget {
  const _ChecklistInspeccionFotos({
    required this.objData,
    required this.objInspeccion,
    Key? key,
  }) : super(key: key);

  final InspeccionIdParamEntity objData;
  final InspeccionEntity objInspeccion;

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
    _getFotos();
  }

  // EVENTS
  void _handleCreatePressed(BuildContext context) {
    Navigator.push<void>(context, AppModalRoute(child: _CreateInspeccionFicheroForm(objInspeccion: widget.objInspeccion, onComplete: _getFotos)));
  }

  void _handleRefreshPressed() => _getFotos();

  void _handleImagePressed(List<Fichero> ficheros, int index) {
    Navigator.push<void>(context, MaterialPageRoute<void>(builder: (_) => _FicheroDetails(lstFicheros: ficheros, initialIndex: index)));
  }

  Future<void> _handleDeletePressed(InspeccionFicheroIdParamEntity objData) async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title   : Text(AppStrings.inspeccionChecklistPhotoDeleteAlertTitle, style: $styles.textStyles.h3.copyWith(fontSize: 18)),
          content : RichText(
            text: TextSpan(
              style     : $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.onSurface, fontSize: 16, height: 1.5),
              children  : const <InlineSpan>[
                TextSpan(text: AppStrings.inspeccionChecklistPhotoDeleteAlertContent1),
                TextSpan(text: AppStrings.inspeccionChecklistPhotoDeleteAlertContent2),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed : () => Navigator.pop(context, AppStrings.btnCancelText),
              child     : Text(AppStrings.btnCancelText, style: $styles.textStyles.button),
            ),
            TextButton(
              onPressed : () => context.read<RemoteInspeccionFicheroBloc>().add(DeleteInspeccionFichero(objData)),
              child     : Text(AppStrings.btnDeleteText, style: $styles.textStyles.button.copyWith(color: Theme.of(context).colorScheme.error)),
            ),
          ],
        );
      },
    );
  }

  void _handleNextPressed(BuildContext context) {
    if (lstFicheros.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                AppStrings.errorAlertWarningTitle,
                style: $styles.textStyles.bodyBold.copyWith(color: $styles.colors.white),
              ),
              Text(
                AppStrings.inspeccionChecklistPhotoAlertNextPageMessage,
                style     : $styles.textStyles.bodySmall.copyWith(color: $styles.colors.white, height: 1.3),
                softWrap  : true,
              ),
            ],
          ),
          backgroundColor : $styles.colors.warning,
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
        Container(),
          // _ChecklistInspeccionFotos(
          //   objData: InspeccionIdParamEntity(idInspeccion: widget.objData.idInspeccion),
          // ),
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

  void _showProgressDialog(BuildContext context) {
    showDialog<void>(
      context             : context,
      barrierDismissible  : false,
      builder: (BuildContext context) {
        return Dialog(
          shape     : RoundedRectangleBorder(borderRadius: BorderRadius.circular($styles.corners.md)),
          elevation : 0,
          child     : Container(
            padding : EdgeInsets.all($styles.insets.xs),
            child   : Column(
              mainAxisSize  : MainAxisSize.min,
              children      : <Widget>[
                Container(
                  margin  : EdgeInsets.symmetric(vertical: $styles.insets.sm),
                  child   : const AppLoadingIndicator(),
                ),
                Container(
                  margin  : EdgeInsets.only(bottom: $styles.insets.xs),
                  child   : Text(AppStrings.appPageProcessingData, style: $styles.textStyles.bodyBold, textAlign: TextAlign.center),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showServerErrorDialog(BuildContext context, String? message) async {
    return showDialog<void>(context: context, builder: (BuildContext context) => ServerFailedDialog(message: message ?? AppStrings.errorGenericMessage));
  }

  // METHODS
  Future<void> _getFotos() async {
    context.read<RemoteInspeccionFicheroBloc>().add(ListFicheros(widget.objData));
  }

  @override
  Widget build(BuildContext context) {
    final Widget content = GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: BlocConsumer<RemoteInspeccionFicheroBloc, RemoteInspeccionFicheroState>(
        listener: (BuildContext context, RemoteInspeccionFicheroState state) {
          // LOADING
          if (state is RemoteInspeccionFicheroDeleteLoading) {
            _showProgressDialog(context);
          }

          // ERROR
          if (state is RemoteInspeccionFicheroServerFailedMessageList ||
              state is RemoteInspeccionFicheroServerExceptionMessageList) {
            setState(() {
              _hasServerError = true;
            });
          }

          if (state is RemoteInspeccionFicheroServerFailedMessageDelete) {
            Navigator.of(context).pop();

            _showServerErrorDialog(context, state.error);

            _getFotos();
          }

          if (state is RemoteInspeccionFicheroServerExceptionMessageDelete) {
            Navigator.of(context).pop();

            _showServerErrorDialog(context, state.error?.message);

            _getFotos();
          }

          // SUCCESS
          if (state is RemoteInspeccionFicheroList) {
            setState(() {
              _hasServerError = false;

              // DATOS
              unidadNumeroEconomico = state.objResponse?.inspeccion.unidadNumeroEconomico   ?? '';
              unidadTipoName        = state.objResponse?.inspeccion.unidadTipoName          ?? '';
              unidadNumeroSerie     = state.objResponse?.inspeccion.numeroSerie             ?? '';
              idInspeccionEstatus   = state.objResponse?.inspeccion.idInspeccionEstatus     ?? '';

              // LIST FICHEROS
              lstFicheros = state.objResponse?.ficheros ?? [];
            });
          }

          if (state is RemoteInspeccionFicheroDelete) {
            Navigator.of(context).pop();
            Navigator.of(context).pop();

            ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(
                  state.objResponse?.message ?? 'Eliminado',
                  style     : $styles.textStyles.bodySmall.copyWith(color: $styles.colors.white),
                  softWrap  : true,
                ),
                backgroundColor : $styles.colors.success,
                elevation       : 0,
                behavior        : SnackBarBehavior.fixed,
              ),
            );

            // Actualizar listado.
            _getFotos();
          }
        },
        builder: (BuildContext context, RemoteInspeccionFicheroState state) {
          if (state is RemoteInspeccionFicheroListLoading) {
            return const Center(child: AppLoadingIndicator());
          }

          if (state is RemoteInspeccionFicheroServerFailedMessageList) {
            return ErrorServerMessage(onPressed: _getFotos, message: state.error);
          }

          if (state is RemoteInspeccionFicheroServerExceptionMessageList) {
            return ErrorServerMessage(onPressed: _getFotos, message: state.error?.message);
          }

          if (state is RemoteInspeccionFicheroList) {
            return Column(
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
                // FICHEROS
                Expanded(
                  child: RepaintBoundary(
                    child: lstFicheros.isEmpty
                        ? const EmptyListMessage(
                            title         : AppStrings.inspeccionChecklistPhotoEmptyListTitle,
                            message       : AppStrings.inspeccionChecklistPhotoEmptyListMessage,
                            isRefreshData : false,
                          )
                        : _FicherosGrid(
                            ficheros        : lstFicheros,
                            onImagePressed  : _handleImagePressed,
                            onDeletePressed : _handleDeletePressed,
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
      appBar: AppBar(title: Text(AppStrings.inspeccionChecklistPhotoEvidenceAppBarTitle, style: $styles.textStyles.h3)),
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
          label     : Text(AppStrings.btnRefreshText, style: $styles.textStyles.button),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CircleIconButton(
            icon          : AppIcons.next_large,
            onPressed     : () =>  Navigator.of(context).pop(),
            semanticLabel : AppStrings.btnPreviousText,
            flipIcon      : true,
          ),
          CircleIconButton(
            icon          : AppIcons.next_large,
            onPressed     : !_hasServerError ? () => _handleNextPressed(context) : null,
            semanticLabel : AppStrings.btnNextText,
          ),
        ],
      ),
    );
  }
}
