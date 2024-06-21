part of '../../../pages/list/list_page.dart';

class _ChecklistInspeccionEvaluacion extends StatefulWidget {
  const _ChecklistInspeccionEvaluacion({
    required this.objData,
    required this.objInspeccion,
    Key? key,
    this.buildDataSourceCallback,
  }) : super(key: key);

  final InspeccionIdReqEntity objData;
  final InspeccionDataSourceEntity objInspeccion;
  final VoidCallback? buildDataSourceCallback;

  @override
  State<_ChecklistInspeccionEvaluacion> createState() => __ChecklistInspeccionEvaluacionState();
}

class __ChecklistInspeccionEvaluacionState extends State<_ChecklistInspeccionEvaluacion> {
  // CONTROLLERS
  late final TextEditingController _fechaInspeccionInicialController;

  // PROPERTIES
  Inspeccion? objInspeccion;
  bool isEvaluado       = false;
  bool _hasServerError  = false;
  bool _isLoading       = false;

  // LIST
  List<Categoria> lstCategorias = [];

  // STATE
  @override
  void initState() {
    super.initState();
    _fechaInspeccionInicialController = TextEditingController();

    getPreguntas();
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
              child: Text($strings.checklistModalBottomSheetTitle, style: $styles.textStyles.title2.copyWith(fontWeight: FontWeight.w600)),
            ),
          ),
          ListTile(
            leading : const Icon(Icons.arrow_back),
            title   : const Text('Salir de la inspección'),
            onTap   : () {
              Navigator.of(context).pop();          // Cerrar ModalBottomSheet
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pop();        // Cerrar Modal
                widget.buildDataSourceCallback!();  // Ejecutar callback
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

  void _handleNextPressed() {
    final bool isEmptyCategoriasItems = lstCategorias.any((item) => item.categoriasItems == null || item.categoriasItems!.isEmpty);

    if (lstCategorias.isEmpty || isEmptyCategoriasItems) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text($strings.settingsAttentionText, style: $styles.textStyles.bodyBold),
              Text($strings.checklistAlertNextPageMessage, softWrap: true),
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
          _ChecklistInspeccionFotos(
            objData                 : InspeccionIdReqEntity(idInspeccion: widget.objData.idInspeccion),
            objInspeccion           : widget.objInspeccion,
            buildDataSourceCallback : widget.buildDataSourceCallback,
          ),
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

  void _handleStorePressed(BuildContext context, {bool isParcial = false}) {
    final bool isEmptyCategoriasItems = lstCategorias.any((item) => item.categoriasItems == null || item.categoriasItems!.isEmpty);

    if (lstCategorias.isEmpty || isEmptyCategoriasItems) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text($strings.settingsAttentionText, style: $styles.textStyles.bodyBold),
              Text($strings.checklistAlertSaveMessage, softWrap: true),
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

    if (_fechaInspeccionInicialController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text($strings.alertWarningInvalidFormTitle, style: $styles.textStyles.bodyBold),
              Text($strings.checklistAlertInvalidDateMessage, softWrap: true),
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

    if (!isParcial) {
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Finalizar', style: $styles.textStyles.h3.copyWith(fontSize: 18, height: 1.3)),
            content: RichText(
              text: TextSpan(style: $styles.textStyles.body.copyWith(color: Theme.of(context).colorScheme.onSurface, height: 1.3),
                children: <InlineSpan>[
                  TextSpan(text: $strings.checklistFinishAlertContent1),
                  TextSpan(text: $strings.checklistFinishAlertContent2),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed : () => Navigator.pop(context, $strings.cancelButtonText),
                child     : Text($strings.cancelButtonText, style: $styles.textStyles.button),
              ),
              TextButton(
                onPressed : () {
                  Navigator.of(context).pop();  // Cerrar AlertDialog
                  _store(isParcial);            // Finalizar InspeccionEvaluacion
                },
                child     : Text($strings.acceptButtonText, style: $styles.textStyles.button),
              ),
            ],
          );
        },
      );
    } else {
      _store(isParcial);
    }
  }

  Future<void> _showServerFailedDialog(BuildContext context, String? errorMessage) async {
    return showDialog<void>(
      context : context,
      builder: (BuildContext context)  => ServerFailedDialog(
        errorMessage: errorMessage ?? 'Se produjo un error inesperado.',
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
                  child   : Text($strings.appProcessingData, style: $styles.textStyles.bodyBold, textAlign: TextAlign.center),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // METHODS
  Future<void> getPreguntas() async {
    context.read<RemoteInspeccionCategoriaBloc>().add(GetPreguntas(widget.objData));
  }

  Future<void> _store(bool isParcial) async {
    final InspeccionCategoriaStoreReqEntity objPost = InspeccionCategoriaStoreReqEntity(
      idInspeccion            : widget.objData.idInspeccion,
      isParcial               : isParcial,
      fechaInspeccionInicial  : DateFormat('dd/MM/yyyy HH:mm').parse(_fechaInspeccionInicialController.text),
      categorias              : lstCategorias,
    );

    BlocProvider.of<RemoteInspeccionCategoriaBloc>(context).add(StoreInspeccionCategoria(objPost));
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (!didPop) {
          _showOnPopModalBottomSheet(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text($strings.checklistAppBarTitle, style: $styles.textStyles.h3)),
        body: BlocConsumer<RemoteInspeccionCategoriaBloc, RemoteInspeccionCategoriaState>(
          listener: (BuildContext context, RemoteInspeccionCategoriaState state) {
            // LOADING:
            if (state is RemoteInspeccionCategoriaGetPreguntasLoading) {
              setState(() {
                _isLoading = true;
              });
            }

            if (state is RemoteInspeccionCategoriaStoreLoading) {
              _showProgressDialog(context);
            }

            // ERROR:
            if (state is RemoteInspeccionCategoriaServerFailedMessageGetPreguntas ||
                state is RemoteInspeccionCategoriaServerFailureGetPreguntas) {
              setState(() {
                _hasServerError = true;
                _isLoading      = false;
              });
            }

            if (state is RemoteInspeccionCategoriaServerFailedMessageStore) {
              Navigator.of(context).pop();

              _showServerFailedDialog(context, state.errorMessage);

              // Actualizando UI.
              getPreguntas();

              setState(() {
                _isLoading = false;
              });
            }

            if (state is RemoteInspeccionCategoriaServerFailureStore) {
              Navigator.of(context).pop();

              _showServerFailedDialog(context, state.failure?.errorMessage);

              // Actualizando UI.
              getPreguntas();

              setState(() {
                _isLoading = false;
              });
            }

            // SUCCESS:
            if (state is RemoteInspeccionCategoriaGetPreguntasSuccess) {
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

            if (state is RemoteInspeccionCategoriaStoreSuccess) {
              Navigator.of(context).pop();

              ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content         : Text(state.objResponse?.message ?? 'Evaluado', softWrap: true),
                  backgroundColor : Colors.green,
                  elevation       : 0,
                  behavior        : SnackBarBehavior.fixed,
                ),
              );

              // Actualizando UI.
              getPreguntas();

              setState(() {
                _hasServerError = false;
                _isLoading      = false;
              });
            }
          },
          builder: (BuildContext context, RemoteInspeccionCategoriaState state) {
            // LOADING:
            if (state is RemoteInspeccionCategoriaGetPreguntasLoading) {
              return const Center(child: AppLoadingIndicator());
            }

            // ERROR:
            if (state is RemoteInspeccionCategoriaServerFailedMessageGetPreguntas) {
              return ErrorInfoContainer(onPressed: getPreguntas, errorMessage: state.errorMessage);
            }

            if (state is RemoteInspeccionCategoriaServerFailureGetPreguntas) {
              return ErrorInfoContainer(onPressed: getPreguntas, errorMessage: state.failure?.errorMessage);
            }

            // SUCCESS:
            if (state is RemoteInspeccionCategoriaGetPreguntasSuccess) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // FECHA INSPECCION INICIAL:
                  Padding(
                    padding : EdgeInsets.all($styles.insets.sm),
                    child   : isEvaluado
                        ? LabeledTextFormField(
                            controller  : _fechaInspeccionInicialController,
                            label       : 'Fecha de inspección inicial:',
                            isReadOnly  : true,
                            textAlign   : TextAlign.end,
                          )
                        : LabeledDateTimeTextFormField(
                            controller  : _fechaInspeccionInicialController,
                            label       : '* Fecha de inspección inicial:',
                          ),
                  ),

                  // DATOS GENERALES DE LA INSPECCIÓN:
                  _buildInspeccionEvaluacionDetails(context),

                  // LISTADO DE CATEGORIAS:
                  Expanded(
                    child: lstCategorias.isNotEmpty
                        ? ListView.builder(
                            itemCount   : lstCategorias.length,
                            itemBuilder : (BuildContext context, int index) {
                              return _ChecklistPreguntaTile(
                                categoria   : lstCategorias[index],
                                evaluado    : isEvaluado,
                                onChange    : (itemIndex, updatedItem) {
                                  setState(() {
                                    lstCategorias[index].categoriasItems![itemIndex] = updatedItem;
                                  });
                                },
                                // onChange    : (itemIndex, newValue) {
                                //   lstCategorias[index].categoriasItems![itemIndex] = lstCategorias[index].categoriasItems![itemIndex].copyWith(value: newValue);
                                // },
                              );
                            },
                          )
                        : RequestDataUnavailable(
                            title         : $strings.checklistEmptyListTitle,
                            message       : $strings.checklistEmptyListMessage,
                            isRefreshData : false,
                          ),
                  ),
                ],
              );
            }

            // DEFAULT:
            return const SizedBox.shrink();
          },
        ),
        bottomNavigationBar: _isLoading || _hasServerError ? const SizedBox.shrink() :  _buildBottomAppBar(context),
      ),
    );
  }

  Widget _buildInspeccionEvaluacionDetails(BuildContext context) {
    return Card(
      elevation   : 3,
      shape       : RoundedRectangleBorder(borderRadius: BorderRadius.circular($styles.corners.md)),
      margin      : EdgeInsets.only(bottom: $styles.insets.sm),
      child       : ExpansionTile(
        leading           : Icon(Icons.check_circle, color: Theme.of(context).indicatorColor),
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
                    style     : $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.onBackground),
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
            child     : Text($strings.saveButtonText, style: $styles.textStyles.button),
          ),
          Gap($styles.insets.sm),
          FilledButton(
            onPressed : !isEvaluado ? () => _handleStorePressed(context) : null,
            child     : Text($strings.finishButtonText, style: $styles.textStyles.button),
          ),
          const Spacer(),
          CircleIconButton(icon: AppIcons.next_large, onPressed: _handleNextPressed, semanticLabel: $strings.nextButtonText),
        ],
      ),
    );
  }
}
