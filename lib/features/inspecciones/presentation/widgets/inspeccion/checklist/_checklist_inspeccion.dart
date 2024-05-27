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
  bool _hasServerError = false;

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
                child: Text('¿Quieres terminar la inspección más tarde?', style: $styles.textStyles.title2.copyWith(fontWeight: FontWeight.w600)),
              ),
            ),
            ListTile(
              onTap: (){},
              leading: const Icon(Icons.bookmark),
              title: const Text('Guardar como borrador'),
              subtitle: const Text('Puedes retomar y responder esta inspección en otro momento.'),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pop();        // Cerrar modal bottom
                // Ejecutar el callback una vez finalizada la acción pop.
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.of(context).pop();      // Cerrar página
                  widget.buildDataSourceCallback(); // Ejecutar callback
                });
              },
              leading: const Icon(Icons.delete_forever),
              textColor: Theme.of(context).colorScheme.error,
              iconColor: Theme.of(context).colorScheme.error,
              title: const Text('Descartar inspección'),
            ),
            ListTile(
              onTap: () => context.pop(),
              leading: const Icon(Icons.check),
              textColor: Theme.of(context).colorScheme.primary,
              iconColor: Theme.of(context).colorScheme.primary,
              title: const Text('Continuar respondiendo'),
            ),
          ],
        );
      },
    );
  }

  void _handleStorePressed({bool isParcial = false}) {
    // if (lstCategorias.isEmpty) {
    //   // No se puede guardar parcialmente o finalizar una evaluación que no cuenta con categorías.
    //   return;
    // }

    if (!isParcial) {
      // Ingrese la fecha de inspección inicial
      return;
    } else {
      _store(isParcial);
    }
  }

  // METHODS
  void _updateFechaInspeccionInicial(DateTime? fecha) {
    if (fecha != null) {
      final String formattedDate = DateFormat('dd/MM/yyyy HH:mm').format(fecha);
      _fechaInspeccionInicialController.text = formattedDate;
    }
  }

  void _store(bool isParcial) {
    // Verificar que la fecha de inspeccion inicial no se mande vacia.
    if (_fechaInspeccionInicialController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content         : const Text('Por favor selecciona la fecha de inspección inicial'),
          backgroundColor : Theme.of(context).colorScheme.error,
          behavior        : SnackBarBehavior.fixed,
          elevation       : 0,
        ),
      );
      return;
    }

    final DateTime fechaInspeccionInicial = DateFormat('dd/MM/yyyy HH:mm').parse(_fechaInspeccionInicialController.text);

    final InspeccionCategoriaStoreReqEntity objPost = InspeccionCategoriaStoreReqEntity(
      idInspeccion            : widget.objData.idInspeccion,
      isParcial               : isParcial,
      fechaInspeccionInicial  : fechaInspeccionInicial,
      categorias              : [],
    );

    // Evento StoreInspeccionCategoria del BLoC.
    BlocProvider.of<RemoteInspeccionCategoriaBloc>(context).add(StoreInspeccionCategoria(objPost));
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
            if (state is RemoteInspeccionCategoriaServerFailedMessageGetPreguntas) {
              setState(() {
                _hasServerError = true;
              });
            }

            if (state is RemoteInspeccionCategoriaServerFailureGetPreguntas) {
              setState(() {
                _hasServerError = true;
              });
            }

            if (state is RemoteInspeccionCategoriaGetPreguntasSuccess) {
              setState(() {
                _hasServerError = false;
                _updateFechaInspeccionInicial(state.objResponse?.inspeccion?.fechaInspeccionInicial);
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
              final Inspeccion? inspeccion = state.objResponse?.inspeccion;
              final List<Categoria> lstCategorias = state.objResponse?.categorias ?? [];

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
                              return _ChecklistTile(categoria: categoria);
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
        bottomNavigationBar: !_hasServerError
            ? BottomAppBar(
                child : Row(
                  children  : <Widget>[
                    IconButton(onPressed: (){}, icon: const Icon(Icons.camera_alt), tooltip: 'Tomar fotografía'),
                    IconButton(onPressed: (){}, icon: const Icon(Icons.sync), tooltip: 'Sincronizar información'),
                    const Spacer(),
                    FilledButton(onPressed: () => _handleStorePressed(isParcial: true), child: Text($strings.saveButtonText, style: $styles.textStyles.button)),
                  ],
                ),
              )
            : null,
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
}
