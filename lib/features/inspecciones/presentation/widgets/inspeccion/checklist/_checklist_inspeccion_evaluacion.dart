part of '../../../pages/list/list_page.dart';

class _ChecklistInspeccionEvaluacion extends StatefulWidget {
  const _ChecklistInspeccionEvaluacion({
    required this.objData,
    required this.objInspeccion,
    Key? key,
  }) : super(key: key);

  final InspeccionIdReqEntity objData;
  final InspeccionDataSourceEntity objInspeccion;

  @override
  State<_ChecklistInspeccionEvaluacion> createState() => _ChecklistInspeccionEvaluacionState();
}

class _ChecklistInspeccionEvaluacionState extends State<_ChecklistInspeccionEvaluacion> {
  // CONTROLLERS
  late final TextEditingController _fechaInspeccionInicialController;

  // PROPERTIES
  bool _serverError = false;
  bool _isLoading   = false;

  Inspeccion? objInspeccion;

  List<Categoria> lstCategorias = <Categoria>[];

  // STATE
  @override
  void initState() {
    super.initState();
    _fechaInspeccionInicialController = TextEditingController();
    _getPreguntas();
  }

  @override
  void dispose() {
    super.dispose();
    _fechaInspeccionInicialController.dispose();
  }

  // EVENTS
  void _handleDidPopPressed(BuildContext context) {
    showModalBottomSheet<void>(
      context : context,
      builder : (BuildContext context) {
        return Column(
          mainAxisSize  : MainAxisSize.min,
          children      : <Widget>[
            Padding(
              padding : EdgeInsets.symmetric(vertical: $styles.insets.sm),
              child   : Center(child: Text($strings.checklistModalBottomSheetTitle, style: $styles.textStyles.title2.copyWith(fontWeight: FontWeight.w600))),
            ),
            ListTile(
              leading   : const Icon(Icons.arrow_back),
              iconColor : Theme.of(context).colorScheme.error,
              title     : const Text('Salir de la inspección'),
              textColor : Theme.of(context).colorScheme.error,
              onTap     : () {
                Navigator.of(context).pop();        // Cerrar modal bottom
                  Navigator.of(context).pop();      // Cerrar página
              },
            ),
            ListTile(
              leading   : const Icon(Icons.check),
              iconColor : Theme.of(context).colorScheme.primary,
              title     : const Text('Continuar inspección'),
              textColor : Theme.of(context).colorScheme.primary,
              onTap     : () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  void _handleStorePressed({bool isParcial = false}) {
    if (lstCategorias.isEmpty) {
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
              const Text('Ingresa la fecha de inspección inicial', softWrap: true),
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
            title   : Text('Confirmar finalización', style: $styles.textStyles.h3.copyWith(fontSize: 18)),
            content : Text(
              '¿Estás seguro que deseas finalizar la evaluación?\nUna vez finalizada la evaluación no se podrán revertir los cambios.',
              style: $styles.textStyles.body.copyWith(height: 1.4),
            ),
            actions : [
              TextButton(onPressed: () => Navigator.pop(context, $strings.cancelButtonText), child: Text($strings.cancelButtonText, style: $styles.textStyles.button)),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, $strings.acceptButtonText);  // Cerrar el dialógo
                  _store(isParcial);                                  // Finalizar evaluación
                },
                child: Text($strings.acceptButtonText, style: $styles.textStyles.button),
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
    Navigator.push<void>(
      context,
      PageRouteBuilder<void>(
        transitionDuration: $styles.times.pageTransition,
        pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) =>
          _ChecklistInspeccionPhoto(objData: InspeccionIdReqEntity(idInspeccion: widget.objData.idInspeccion), objInspeccion: widget.objInspeccion),
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
                  child   : const AppLoadingIndicator(width: 30, height: 30),
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

  Future<void> _showServerFailedDialog(BuildContext context, String? errorMessage) async {
    return showDialog<void>(
      context : context,
      builder: (BuildContext context)  => ServerFailedDialog(
        errorMessage: errorMessage ?? 'Se produjo un error inesperado. Intenta de nuevo guardar la evaluación.',
      ),
    );
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

    BlocProvider.of<RemoteInspeccionCategoriaBloc>(context).add(StoreInspeccionCategoria(objPost));
  }

  List<Categoria> _updateCategoriasItems(List<Categoria> categorias, Map<String, String> selectedValues) {
    return categorias.map((categoria) {
      final updatedItems = categoria.categoriasItems?.map((item) {
        final newValue = selectedValues[item.idCategoriaItem];
        return newValue != null
          ? CategoriaItem(
              idCategoriaItem     : item.idCategoriaItem,
              name                : item.name,
              idFormularioTipo    : item.idFormularioTipo,
              formularioTipoName  : item.formularioTipoName,
              formularioValor     : item.formularioValor,
              value               : newValue,
              observaciones       : item.observaciones,
              noAplica            : false,
            )
          : item;
      }).toList();
      return Categoria(
        idCategoria     : categoria.idCategoria,
        name            : categoria.name,
        categoriasItems : updatedItems,
      );
    }).toList();
  }

  Map<String, String> _getSelectedValues(Categoria categoria) {
    final Map<String, String> initialValues = {};
    for (final categoria in lstCategorias) {
      for (final CategoriaItem item in categoria.categoriasItems ?? []) {
        if (item.idFormularioTipo == 'ea52bdfd-8af6-4f5a-b182-2b99e554eb32') {
          initialValues[item.idCategoriaItem!] = item.value ?? '';
        }
      }
    }
    return initialValues;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          _handleDidPopPressed(context);
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

            if (state is RemoteInspeccionCategoriaStoring) {
              _showProgressDialog(context);
            }

            // ERRORS:
            if (state is RemoteInspeccionCategoriaServerFailedMessageGetPreguntas) {
              setState(() {
                _serverError = true;
                _isLoading   = false;
              });
            }

            if (state is RemoteInspeccionCategoriaServerFailureGetPreguntas) {
              setState(() {
                _serverError = true;
                _isLoading   = false;
              });
            }

            if (state is RemoteInspeccionCategoriaServerFailedMessageStore) {
              Navigator.of(context).pop();

              _showServerFailedDialog(context, state.errorMessage);
              _getPreguntas();

              setState(() {
                _isLoading = false;
              });
            }

            if (state is RemoteInspeccionCategoriaServerFailureStore) {
              Navigator.of(context).pop();

              _showServerFailedDialog(context, state.failure?.errorMessage);
              _getPreguntas();

              setState(() {
                _isLoading = false;
              });
            }

            // SUCCESS:
            if (state is RemoteInspeccionCategoriaGetPreguntasSuccess) {
              setState(() {
                _serverError  = false;
                _isLoading    = false;

                objInspeccion = state.objResponse?.inspeccion;
                lstCategorias = state.objResponse?.categorias ?? [];

                if (objInspeccion?.fechaInspeccionInicial != null) {
                  _fechaInspeccionInicialController.text = DateFormat('dd/MM/yyyy HH:mm').format(objInspeccion!.fechaInspeccionInicial!);
                }
              });
            }

            if (state is RemoteInspeccionCategoriaStored) {
              Navigator.of(context).pop();

              ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content         : Text(state.objResponse?.message ?? 'Evaluación parcial', softWrap: true),
                  backgroundColor : Colors.green,
                  elevation       : 0,
                  behavior        : SnackBarBehavior.fixed,
                ),
              );

              _getPreguntas();

              setState(() {
                _serverError  = false;
                _isLoading    = false;
              });
            }
          },
          builder: (BuildContext context, RemoteInspeccionCategoriaState state) {
            if (state is RemoteInspeccionCategoriaGetPreguntasLoading) {
              return const Center(child: AppLoadingIndicator());
            }

            if (state is RemoteInspeccionCategoriaServerFailedMessageGetPreguntas) {
              return ErrorInfoContainer(onPressed: _getPreguntas, errorMessage: state.errorMessage);
            }

            if (state is RemoteInspeccionCategoriaServerFailureGetPreguntas) {
              return ErrorInfoContainer(onPressed: _getPreguntas, errorMessage: state.failure?.errorMessage);
            }

            if (state is RemoteInspeccionCategoriaGetPreguntasSuccess) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // FECHA INSPECCION INICIAL:
                  Padding(
                    padding : EdgeInsets.all($styles.insets.sm),
                    child   : objInspeccion?.evaluado ?? false
                    ? LabeledTextFormField(
                        controller  : _fechaInspeccionInicialController,
                        label       : 'Fecha de inspección inicial:',
                        isReadOnly  : true,
                        textAlign   : TextAlign.end,
                      )
                    : LabeledDateTimeTextFormField(
                        controller  : _fechaInspeccionInicialController,
                        hintText    : 'dd/mm/aaaa hh:mm',
                        label       : '* Fecha de inspección inicial:',
                      ),
                  ),

                  // DATOS GENERALES DE LA EVALUACIÓN:
                  _buildInspeccionDetails(context, objInspeccion),

                  // LISTADO DE CATEGORIAS:
                  Expanded(
                    child: lstCategorias.isNotEmpty
                        ? ListView.builder(
                            itemCount   : lstCategorias.length,
                            itemBuilder : (BuildContext context, int index) {
                              return _ChecklistTile(
                                categoria               : lstCategorias[index],
                                selectedValues          : _getSelectedValues(lstCategorias[index]),
                                isEvaluado              : objInspeccion?.evaluado ?? false,
                                onSelectedValuesChanged : (newValues) {
                                  setState(() {
                                    lstCategorias = _updateCategoriasItems(lstCategorias, newValues);
                                  });
                                },
                              );
                            },
                          )
                        : RequestDataUnavailable(title: $strings.checklistEmptyTitle, message: $strings.checklistListMessage, isRefreshData: false),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
        bottomNavigationBar: !_serverError && !_isLoading ? _buildBottomAppBar() : null,
      ),
    );
  }

  Widget _buildInspeccionDetails(BuildContext context, Inspeccion? inspeccion) {
    return Card(
      elevation : 3,
      shape     : RoundedRectangleBorder(borderRadius: BorderRadius.circular($styles.corners.md)),
      margin    : EdgeInsets.only(bottom: $styles.insets.sm),
      child     : ExpansionTile(
        leading   : Icon(Icons.check_circle, color: Theme.of(context).indicatorColor),
        title     : Text('DATOS GENERALES', style: $styles.textStyles.h4),
        children  : <Widget>[
          Container(
            width   : double.infinity,
            padding : EdgeInsets.all($styles.insets.sm),
            color   : Theme.of(context).colorScheme.background,
            child   : Column(
              crossAxisAlignment  : CrossAxisAlignment.start,
              children            : <Widget>[
                Text('Número económico:', style: $styles.textStyles.bodySmall),
                Text(inspeccion?.unidadNumeroEconomico ?? '', style: $styles.textStyles.title1.copyWith(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600, height: 1.3)),

                RichText(
                  text: TextSpan(
                    style     : $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.onBackground),
                    children  : <InlineSpan>[
                      const TextSpan(text: 'Folio inspección'),
                      TextSpan(text: ': ${inspeccion?.folio ?? ''}'),
                    ],
                  ),
                ),

                RichText(
                  text: TextSpan(
                    style     : $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.onBackground),
                    children  : <InlineSpan>[
                      const TextSpan(text: 'Tipo de inspección'),
                      TextSpan(text: ': ${inspeccion?.inspeccionTipoName ?? ''}'),
                    ],
                  ),
                ),

                RichText(
                  text: TextSpan(
                    style     : $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.onBackground),
                    children  : <InlineSpan>[
                      const TextSpan(text: 'Tipo de unidad'),
                      TextSpan(text: ': ${inspeccion?.unidadTipoName ?? ''}'),
                    ],
                  ),
                ),

                RichText(
                  text: TextSpan(
                    style     : $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.onBackground),
                    children  : <InlineSpan>[
                      const TextSpan(text: 'Marca'),
                      TextSpan(text: ': ${inspeccion?.unidadMarcaName ?? ''}'),
                    ],
                  ),
                ),

                RichText(
                  text: TextSpan(
                    style     : $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.onBackground),
                    children  : <InlineSpan>[
                      const TextSpan(text: 'Número de serie'),
                      TextSpan(text: ': ${inspeccion?.numeroSerie ?? ''}'),
                    ],
                  ),
                ),

                RichText(
                  text: TextSpan(
                    style     : $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.onBackground),
                    children  : <InlineSpan>[
                      const TextSpan(text: 'Locación'),
                      TextSpan(text: ': ${inspeccion?.locacion ?? ''}'),
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

  Widget _buildBottomAppBar() {
    return BottomAppBar(
      height: 70,
      child : Row(
        children: <Widget>[
          FilledButton(
            onPressed : objInspeccion?.evaluado ?? false ? null : () => _handleStorePressed(isParcial: true),
            child     : Text($strings.saveButtonText, style: $styles.textStyles.button),
          ),
          Gap($styles.insets.sm),
          FilledButton(
            onPressed : objInspeccion?.evaluado ?? false ? null : () => _handleStorePressed(),
            child     : Text($strings.finishButtonText, style: $styles.textStyles.button),
          ),
          const Spacer(),
          CircleIconButton(icon: AppIcons.next_large, onPressed: _handleNextPressed, semanticLabel: $strings.nextButtonText),
        ],
      ),
    );
  }
}
