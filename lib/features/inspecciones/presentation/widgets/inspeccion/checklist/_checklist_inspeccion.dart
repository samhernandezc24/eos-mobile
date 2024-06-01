part of '../../../pages/list/list_page.dart';

class _ChecklistInspeccion extends StatefulWidget {
  const _ChecklistInspeccion({required this.objData, required this.buildDataSourceCallback, Key? key}) : super(key: key);

  final InspeccionIdReqEntity objData;
  final VoidCallback buildDataSourceCallback;

  @override
  State<_ChecklistInspeccion> createState() => _ChecklistInspeccionState();
}

class _ChecklistInspeccionState extends State<_ChecklistInspeccion> {
  // CONTROLLERS
  late final TextEditingController _fechaInspeccionInicialController;

  // PROPERTIES
  bool _hasServerError  = false;
  bool _isLoading       = false;

  List<Categoria> lstCategorias = <Categoria>[];
  Inspeccion? inspeccion;

  // STATE
  @override
  void initState() {
    super.initState();
    context.read<RemoteInspeccionCategoriaBloc>().add(GetInspeccionCategoriaPreguntas(widget.objData));
    _fechaInspeccionInicialController = TextEditingController();
  }

  @override
  void dispose() {
    _fechaInspeccionInicialController.dispose();
    super.dispose();
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
              padding: EdgeInsets.symmetric(vertical: $styles.insets.sm),
              child: Center(
                child: Text('¿Quieres terminar la evaluación más tarde?', style: $styles.textStyles.title2.copyWith(fontWeight: FontWeight.w600)),
              ),
            ),
            ListTile(
              leading   : const Icon(Icons.bookmark),
              title     : const Text('Guardar como borrador'),
              subtitle  : const Text('Puedes retomar y responder esta evaluación en otro momento.'),
              onTap     : (){},
            ),
            ListTile(
              leading   : const Icon(Icons.keyboard_return),
              textColor : Theme.of(context).colorScheme.error,
              iconColor : Theme.of(context).colorScheme.error,
              title     : const Text('Salir de la evaluación'),
              onTap     : () {
                Navigator.of(context).pop();        // Cerrar modal bottom
                // Ejecutar el callback una vez finalizada la acción pop.
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.of(context).pop();      // Cerrar página
                  widget.buildDataSourceCallback(); // Ejecutar callback
                });
              },
            ),
            ListTile(
              leading   : const Icon(Icons.check),
              textColor : Theme.of(context).colorScheme.primary,
              iconColor : Theme.of(context).colorScheme.primary,
              title     : const Text('Continuar respondiendo'),
              onTap     : () => context.pop(),
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
              // TITLE:
              Text($strings.settingsAttentionText, style: $styles.textStyles.bodyBold),
              // MESSAGE:
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

    if (isParcial) {
      if (_fechaInspeccionInicialController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // TITLE:
                Text($strings.alertWarningInvalidFormTitle, style: $styles.textStyles.bodyBold),
                Gap($styles.insets.xxs),
                // MESSAGE:
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
      } else {
        _store(isParcial);
      }
    }
  }

  void _handleNextPressed() {
    Navigator.push<void>(
      context,
      PageRouteBuilder<void>(
        transitionDuration: $styles.times.pageTransition,
        pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) =>
          _ChecklistInspeccionPhoto(objData: InspeccionIdReqEntity(idInspeccion: widget.objData.idInspeccion)),
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

  void _handleRadioChanged(String? selectedValue, List<CategoriaItem> categoriasItems) {
    // final CategoriaItem? selectedItem = categoriasItems.firstWhere((item) => item.idCategoriaItem == selectedValue);
    // if (selectedItem != null) {
    //   setState(() {
    //     selectedItem.value = selectedValue;
    //   });
    // }
  }

  Future<void> _showServerFailedDialog(BuildContext context, String? errorMessage) async {
    return showDialog<void>(
      context : context,
      builder: (BuildContext context)  => ServerFailedDialog(
        errorMessage: errorMessage ?? 'Se produjo un error inesperado. Intenta de nuevo guardar la evaluación.',
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

  // METHODS
  void _store(bool isParcial) {
    final InspeccionCategoriaStoreReqEntity objPost = InspeccionCategoriaStoreReqEntity(
      idInspeccion            : widget.objData.idInspeccion,
      isParcial               : isParcial,
      fechaInspeccionInicial  : DateFormat('dd/MM/yyyy HH:mm').parse(_fechaInspeccionInicialController.text),
      categorias              : lstCategorias,
    );

    BlocProvider.of<RemoteInspeccionCategoriaBloc>(context).add(StoreInspeccionCategoria(objPost));
  }

  void _updateFechaInspeccionInicial(DateTime? fecha) {
    if (fecha != null) {
      _fechaInspeccionInicialController.text = DateFormat('dd/MM/yyyy HH:mm').format(fecha);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (didPop) return;
        _handleDidPopPressed(context);
      },
      child: Scaffold(
        appBar  : AppBar(title: Text($strings.checklistAppBarTitle, style: $styles.textStyles.h3)),
        body    : BlocConsumer<RemoteInspeccionCategoriaBloc, RemoteInspeccionCategoriaState>(
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
                _hasServerError = true;
                _isLoading      = false;
              });
            }

            if (state is RemoteInspeccionCategoriaServerFailureGetPreguntas) {
              setState(() {
                _hasServerError = true;
                _isLoading      = false;
              });
            }

            if (state is RemoteInspeccionCategoriaServerFailedMessageStore) {
              Navigator.of(context).pop();

              _showServerFailedDialog(context, state.errorMessage);

              // Actualizando el listado de categorías.
              context.read<RemoteInspeccionCategoriaBloc>().add(GetInspeccionCategoriaPreguntas(widget.objData));

              setState(() {
                _isLoading = false;
              });
            }

            if (state is RemoteInspeccionCategoriaServerFailureStore) {
              Navigator.of(context).pop();

              _showServerFailedDialog(context, state.failure?.errorMessage);

              // Actualizando el listado de categorías.
              context.read<RemoteInspeccionCategoriaBloc>().add(GetInspeccionCategoriaPreguntas(widget.objData));

              setState(() {
                _isLoading = false;
              });
            }

            // SUCCESS:
            if (state is RemoteInspeccionCategoriaGetPreguntasSuccess) {
              setState(() {
                _hasServerError = false;
                _updateFechaInspeccionInicial(state.objResponse?.inspeccion?.fechaInspeccionInicial);
                _isLoading = false;
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
                  behavior        : SnackBarBehavior.fixed,
                  elevation       : 0,
                ),
              );

              // Actualizando el listado de categorías.
              context.read<RemoteInspeccionCategoriaBloc>().add(GetInspeccionCategoriaPreguntas(widget.objData));

              setState(() {
                _hasServerError = false;
                _isLoading      = false;
              });
            }
          },
          builder: (BuildContext context, RemoteInspeccionCategoriaState state) {
            if (state is RemoteInspeccionCategoriaGetPreguntasLoading) {
              return const Center(child: AppLoadingIndicator());
            }

            if (state is RemoteInspeccionCategoriaServerFailedMessageGetPreguntas) {
              return ErrorInfoContainer(
                onPressed     : () => context.read<RemoteInspeccionCategoriaBloc>().add(GetInspeccionCategoriaPreguntas(widget.objData)),
                errorMessage  : state.errorMessage,
              );
            }

            if (state is RemoteInspeccionCategoriaServerFailureGetPreguntas) {
              return ErrorInfoContainer(
                onPressed     : () => context.read<RemoteInspeccionCategoriaBloc>().add(GetInspeccionCategoriaPreguntas(widget.objData)),
                errorMessage  : state.failure?.errorMessage,
              );
            }

            if (state is RemoteInspeccionCategoriaGetPreguntasSuccess) {
              lstCategorias = state.objResponse?.categorias ?? [];
              inspeccion    = state.objResponse?.inspeccion;
              return Column(
                crossAxisAlignment  : CrossAxisAlignment.start,
                children            : <Widget>[
                  Padding(
                    padding: EdgeInsets.all($styles.insets.sm),
                    child: Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // FECHA DE INSPECCIÓN INICIAL:
                          LabeledDateTimeTextFormField(
                            controller  : _fechaInspeccionInicialController,
                            hintText    : 'dd/mm/aaaa hh:mm',
                            label       : '* Fecha de inspección inicial:',
                          ),
                        ],
                      ),
                    ),
                  ),

                  // DATOS GENERALES DE LA INSPECCIÓN:
                  _buildInspeccionDetails(context, inspeccion),

                  Expanded(
                    child: lstCategorias.isNotEmpty
                        // FORMULARIO DE PREGUNTAS:
                        ? ListView.builder(
                            padding     : EdgeInsets.only(bottom: $styles.insets.lg),
                            itemCount   : lstCategorias.length,
                            itemBuilder : (BuildContext context, int index) {
                              final Categoria categoria = lstCategorias[index];
                              return _ChecklistTile(
                                categoria: categoria,
                                onChanged: (_) {},
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
        bottomNavigationBar: !_hasServerError && !_isLoading ? _buildBottomAppBar() : null,
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
      height  : 70,
      child   : Row(
        mainAxisAlignment : MainAxisAlignment.end,
        children          : <Widget>[
          FilledButton(onPressed: () => _handleStorePressed(isParcial: true), child: Text($strings.saveButtonText, style: $styles.textStyles.button)),
          Gap($styles.insets.sm),
          FilledButton(onPressed: () => _handleNextPressed(), child: Text($strings.nextButtonText, style: $styles.textStyles.button)),
        ],
      ),
    );
  }
}
