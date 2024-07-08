part of '../../../pages/index/index_page.dart';

class _ChecklistInspeccionEvaluacion extends StatefulWidget {
  const _ChecklistInspeccionEvaluacion({
    required this.objData,
    required this.objInspeccion,
    Key? key,
    this.onComplete,
  }) : super(key: key);

  final InspeccionIdParamEntity objData;
  final InspeccionEntity objInspeccion;
  final VoidCallback? onComplete;

  @override
  State<_ChecklistInspeccionEvaluacion> createState() => __ChecklistInspeccionEvaluacionState();
}

class __ChecklistInspeccionEvaluacionState extends State<_ChecklistInspeccionEvaluacion> {
  // CONTROLLERS
  late final TextEditingController _fechaInspeccionInicialController;

  // PROPERTIES
  InspeccionChecklist? objInspeccion;
  bool isEvaluado = false;

  bool _hasServerError  = false;
  bool _isLoading       = false;

  // LIST
  List<InspeccionCategoria> lstCategorias = [];

  // STATE
  @override
  void initState() {
    super.initState();
    _fechaInspeccionInicialController = TextEditingController();
    _getPreguntas();
  }

  @override
  void dispose() {
    _fechaInspeccionInicialController.dispose();
    super.dispose();
  }

  // EVENTS
  void _showOnPopModalBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => Column(
        mainAxisSize  : MainAxisSize.min,
        children      : <Widget>[
          Padding(
            padding : EdgeInsets.symmetric(vertical: $styles.insets.sm),
            child   : Center(
              child: Text(AppStrings.inspeccionChecklistModalBottomTitle, style: $styles.textStyles.title2.copyWith(fontWeight: FontWeight.w600)),
            ),
          ),
          ListTile(
            leading : const Icon(Icons.arrow_back),
            title   : const Text('Salir de la inspección'),
            onTap   : () {
              Navigator.of(context).pop();          // Cerrar ModalBottomSheet
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pop();        // Cerrar Modal
                widget.onComplete!();               // Ejecutar callback
              });
            },
          ),
          ListTile(
            leading   : const Icon(Icons.check),
            title     : const Text('Continuar inspección'),
            iconColor : Theme.of(context).primaryColor,
            textColor : Theme.of(context).primaryColor,
            onTap     : () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  void _handleStorePressed(BuildContext context, {bool isParcial = false}) {
    final bool isEmptyCategoriasItems = lstCategorias.any((item) => item.categoriasItems == null || item.categoriasItems!.isEmpty);

    if (lstCategorias.isEmpty || isEmptyCategoriasItems) {
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
                AppStrings.inspeccionChecklistAlertSaveMessage,
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

    if (_fechaInspeccionInicialController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                AppStrings.errorAlertInvalidFormTitle,
                style: $styles.textStyles.bodyBold.copyWith(color: $styles.colors.white),
              ),
              Text(
                AppStrings.inspeccionChecklistAlertInvalidDateMessage,
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

    if (!isParcial) {
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Finalizar', style: $styles.textStyles.h3.copyWith(fontSize: 18, height: 1.3)),
            content: RichText(
              text: TextSpan(style: $styles.textStyles.body.copyWith(color: Theme.of(context).colorScheme.onSurface, height: 1.3),
                children: const <InlineSpan>[
                  TextSpan(text: AppStrings.inspeccionChecklistFinishAlertFirstText),
                  TextSpan(text: AppStrings.inspeccionChecklistFinishAlertSecondText),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed : () => Navigator.pop(context, AppStrings.btnCancelText),
                child     : Text(AppStrings.btnCancelText, style: $styles.textStyles.button),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();  // Cerrar AlertDialog
                  _store(isParcial);            // Finalizar InspeccionEvaluacion
                },
                child: Text(AppStrings.btnAcceptText, style: $styles.textStyles.button),
              ),
            ],
          );
        },
      );
    } else {
      _store(isParcial);
    }
  }

  void _handleNextPressed() {
    final bool isEmptyCategoriasItems = lstCategorias.any((item) => item.categoriasItems == null || item.categoriasItems!.isEmpty);

    if (lstCategorias.isEmpty || isEmptyCategoriasItems) {
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
                AppStrings.inspeccionChecklistAlertNextPageMessage,
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
          const _ChecklistInspeccionFotos(),
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
  Future<void> _getPreguntas() async {
    context.read<RemoteInspeccionCategoriaBloc>().add(GetPreguntas(widget.objData));
  }

  Future<void> _store(bool isParcial) async {
    final InspeccionCategoriaStoreReqEntity objPost = InspeccionCategoriaStoreReqEntity(
      idInspeccion            : widget.objData.idInspeccion,
      isParcial               : isParcial,
      fechaInspeccionInicial  : DateFormat('dd/MM/yyyy HH:mm').parse(_fechaInspeccionInicialController.text),
      categorias              : lstCategorias,
    );

    context.read<RemoteInspeccionCategoriaBloc>().add(StoreInspeccionCategoria(objPost));
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) => !didPop ? _showOnPopModalBottomSheet(context) : null,
      child: Scaffold(
        appBar: AppBar(title: Text(isEvaluado ? 'Evaluado' : AppStrings.inspeccionChecklistAppBarTitle, style: $styles.textStyles.h3)),
        body: BlocConsumer<RemoteInspeccionCategoriaBloc, RemoteInspeccionCategoriaState>(
          listener: (BuildContext context, RemoteInspeccionCategoriaState state) {
            // LOADING
            if (state is RemoteInspeccionCategoriaGetPreguntasLoading) {
              setState(() {
                _isLoading = true;
              });
            }

            if (state is RemoteInspeccionCategoriaStoreLoading) {
              _showProgressDialog(context);
            }

            // ERROR
            if (state is RemoteInspeccionCategoriaServerExceptionMessageGetPreguntas ||
                state is RemoteInspeccionCategoriaServerFailedMessageGetPreguntas) {
              setState(() {
                _hasServerError   = true;
                _isLoading        = false;
              });
            }

            if (state is RemoteInspeccionCategoriaServerFailedMessageStore) {
              Navigator.of(context).pop();
              _showServerErrorDialog(context, state.error);
              _getPreguntas();
            }

            if (state is RemoteInspeccionCategoriaServerExceptionMessageStore) {
              Navigator.of(context).pop();
              _showServerErrorDialog(context, state.error?.message);
              _getPreguntas();
            }

            // SUCCESS
            if (state is RemoteInspeccionCategoriaGetPreguntas) {
              setState(() {
                _isLoading      = false;
                _hasServerError = false;

                objInspeccion   = state.objResponse?.inspeccion;
                lstCategorias   = state.objResponse?.categorias ?? [];
                isEvaluado      = objInspeccion?.evaluado ?? false;

                if (objInspeccion?.fechaInspeccionInicial != null) {
                  _fechaInspeccionInicialController.text = DateFormat('dd/MM/yyyy HH:mm').format(objInspeccion!.fechaInspeccionInicial!);
                }
              });
            }

            if (state is RemoteInspeccionCategoriaStore) {
              Navigator.of(context).pop();

              ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(
                    state.objResponse?.message ?? 'Evaluado',
                    style     : $styles.textStyles.bodySmall.copyWith(color: $styles.colors.white),
                    softWrap  : true,
                  ),
                  backgroundColor : $styles.colors.success,
                  elevation       : 0,
                  behavior        : SnackBarBehavior.fixed,
                ),
              );

              _getPreguntas();
            }
          },
          builder: (BuildContext context, RemoteInspeccionCategoriaState state) {
            if (state is RemoteInspeccionCategoriaGetPreguntasLoading) {
              return const Center(child: AppLoadingIndicator());
            }

            if (state is RemoteInspeccionCategoriaGetPreguntas) {
              return Column(
                children: <Widget>[
                   // CAMPO: FECHA INSPECCION INICIAL
                    Padding(
                      padding : EdgeInsets.all($styles.insets.sm),
                      child   : isEvaluado
                          ? LabeledTextFormField(
                              controller  : _fechaInspeccionInicialController,
                              label       : 'Fecha de inspección inicial:',
                              readOnly    : true,
                              textAlign   : TextAlign.end,
                            )
                          : LabeledDateTimeFormField(
                              controller  : _fechaInspeccionInicialController,
                              label       : '* Fecha de inspección inicial:',
                            ),
                    ),

                    // DATOS GENERALES DE LA INSPECCION:
                    _buildInspeccionEvaluacionDetails(context),

                    // LISTADO DE CATEGORIAS:
                    Expanded(
                      child: lstCategorias.isEmpty
                          ? const EmptyListMessage(
                              title         : AppStrings.inspeccionChecklistEmptyListTitle,
                              message       : AppStrings.inspeccionChecklistEmptyListMessage,
                              isRefreshData : false,
                            )
                          : ListView.builder(
                              itemCount   : lstCategorias.length,
                              itemBuilder : (BuildContext context, int index) {
                                return _ChecklistInspeccionPreguntaTile(
                                  categoria : lstCategorias[index],
                                  evaluado  : isEvaluado,
                                  onChange  : (itemIndex, updatedItem) {
                                    setState(() {
                                      lstCategorias[index].categoriasItems![itemIndex] = updatedItem;
                                    });
                                  },
                                );
                              },
                            ),
                    ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
        bottomNavigationBar: !_hasServerError && !_isLoading ? _buildBottomAppBar(context) : const SizedBox.shrink(),
      ),
    );
  }

  Widget _buildInspeccionEvaluacionDetails(BuildContext context) {
    return Card(
      elevation   : 3,
      shape       : RoundedRectangleBorder(borderRadius: BorderRadius.circular($styles.corners.md)),
      margin      : EdgeInsets.only(bottom: $styles.insets.sm),
      child       : ExpansionTile(
        leading       :  Container(
          padding     : EdgeInsets.symmetric(vertical: $styles.insets.xxs, horizontal: $styles.insets.xs),
          decoration  : BoxDecoration(color: Colors.green, borderRadius  : BorderRadius.circular($styles.corners.md)),
          child       : Icon(Icons.check_circle, color: Colors.green[100]),
        ),
        title             : Text('DATOS GENERALES', style: $styles.textStyles.h4),
        children          : <Widget>[
          Container(
            color   : Theme.of(context).colorScheme.background,
            padding : EdgeInsets.all($styles.insets.sm),
            width   : double.infinity,
            child   : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Número económico', style: $styles.textStyles.bodySmall),
                Text(
                  objInspeccion?.unidadNumeroEconomico ?? '',
                  style: $styles.textStyles.title1.copyWith(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600, height: 1.3),
                ),
                RichText(
                  text: TextSpan(
                    style     : $styles.textStyles.body.copyWith(color: Theme.of(context).colorScheme.onBackground),
                    children  : <InlineSpan>[
                      const TextSpan(text: 'Folio'),
                      TextSpan(text: ': ${objInspeccion?.folio}'),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style     : $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.onBackground),
                    children  : <InlineSpan>[
                      const TextSpan(text: 'Tipo de inspección'),
                      TextSpan(text: ': ${objInspeccion?.inspeccionTipoName}'),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style     : $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.onBackground),
                    children  : <InlineSpan>[
                      const TextSpan(text: 'Tipo de unidad'),
                      TextSpan(text: ': ${objInspeccion?.unidadTipoName}'),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style     : $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.onBackground),
                    children  : <InlineSpan>[
                      const TextSpan(text: 'Marca'),
                      TextSpan(text: ': ${objInspeccion?.unidadMarcaName}'),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style     : $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.onBackground),
                    children  : <InlineSpan>[
                      const TextSpan(text: 'Número de serie'),
                      TextSpan(text: ': ${objInspeccion?.numeroSerie}'),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style     : $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.onBackground),
                    children  : <InlineSpan>[
                      const TextSpan(text: 'Locación'),
                      TextSpan(text: ': ${objInspeccion?.locacion}'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomAppBar(BuildContext context) {
    return BottomAppBar(
      height: 70,
      child: Row(
        children: <Widget>[
          FilledButton(
            onPressed : !isEvaluado ? () => _handleStorePressed(context, isParcial: true) : null,
            child     : Text(AppStrings.btnSaveText, style: $styles.textStyles.button),
          ),
          Gap($styles.insets.sm),
          FilledButton(
            onPressed : !isEvaluado ? () => _handleStorePressed(context) : null,
            child     : Text(AppStrings.btnFinishText, style: $styles.textStyles.button),
          ),
          const Spacer(),
          CircleIconButton(icon: AppIcons.next_large, onPressed: _handleNextPressed, semanticLabel: AppStrings.btnNextText),
        ],
      ),
    );
  }
}
