part of '../../../pages/list/list_page.dart';

class _ChecklistInspeccion extends StatefulWidget {
  const _ChecklistInspeccion({required this.idInspeccion, required this.buildDataSourceCallback, Key? key}) : super(key: key);

  final InspeccionIdReqEntity idInspeccion;
  final VoidCallback buildDataSourceCallback;

  @override
  State<_ChecklistInspeccion> createState() => _ChecklistInspeccionState();
}

class _ChecklistInspeccionState extends State<_ChecklistInspeccion> {
  // CONTROLLERS
  late final TextEditingController _fechaInspeccionInicialController;

  // PROPERTIES
  String? _selectedValueOption;
  bool _hasServerError = false;

  @override
  void initState() {
    super.initState();
    context.read<RemoteInspeccionCategoriaBloc>().add(GetInspeccionCategoriaPreguntas(widget.idInspeccion));

    _fechaInspeccionInicialController = TextEditingController();
  }

  @override
  void dispose() {
    _fechaInspeccionInicialController.dispose();
    super.dispose();
  }

  // METHODS
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
                Navigator.of(context).pop(); // Cerrar modal bottom
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
    // showModalBottomSheet<void>(
    //   context : context,
    //   builder : (BuildContext context) => AlertDialog(
    //     title   : const SizedBox.shrink(),
    //     content : Text('¿Estás seguro que deseas salir?', style: $styles.textStyles.bodySmall.copyWith(fontSize: 16)),
    //     actions : <Widget>[
    //       TextButton(
    //         onPressed : () { Navigator.of(context).pop(); },
    //         child     : Text($strings.cancelButtonText, style: $styles.textStyles.button),
    //       ),
    //       TextButton(
    //         onPressed : () {
    //           Navigator.of(context).pop(); // Cerrar dialog
    //           // Ejecutar el callback una vez finalizada la acción pop.
    //           WidgetsBinding.instance.addPostFrameCallback((_) {
    //             Navigator.of(context).pop();      // Cerrar página
    //             widget.buildDataSourceCallback(); // Ejecutar callback
    //           });
    //         },
    //         child : Text($strings.acceptButtonText, style: $styles.textStyles.button),
    //       ),
    //     ],
    //   ),
    // );
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
            if (state is RemoteInspeccionCategoriaServerFailedMessage) {
              setState(() {
                _hasServerError = true;
              });
            }

            if (state is RemoteInspeccionCategoriaServerFailure) {
              setState(() {
                _hasServerError = true;
              });
            }

            if (state is RemoteInspeccionCategoriaGetPreguntasSuccess) {
              setState(() {
                _hasServerError = false;
              });
            }
          },
          builder: (BuildContext context, RemoteInspeccionCategoriaState state) {
            if (state is RemoteInspeccionCategoriaLoading) {
              return const Center(child: AppLoadingIndicator());
            }

            if (state is RemoteInspeccionCategoriaServerFailedMessage) {
              return ErrorInfoContainer(
                onPressed     : () => context.read<RemoteInspeccionCategoriaBloc>().add(GetInspeccionCategoriaPreguntas(widget.idInspeccion)),
                errorMessage  : state.errorMessage,
              );
            }

            if (state is RemoteInspeccionCategoriaServerFailure) {
              return ErrorInfoContainer(
                onPressed     : () => context.read<RemoteInspeccionCategoriaBloc>().add(GetInspeccionCategoriaPreguntas(widget.idInspeccion)),
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
                          LabeledDateTextFormField(
                            controller  : _fechaInspeccionInicialController,
                            hintText    : 'dd/mm/aaaa',
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
                          padding: EdgeInsets.only(bottom: $styles.insets.lg),
                            itemCount   : lstCategorias.length,
                            itemBuilder : (BuildContext context, int index) {
                              final Categoria categoria = lstCategorias[index];
                              return Card(
                                elevation : 3,
                                shape     : RoundedRectangleBorder(borderRadius: BorderRadius.circular($styles.corners.md)),
                                margin    : EdgeInsets.only(bottom: $styles.insets.sm),
                                child     : ExpansionTile(
                                  leading: Container(
                                    padding: EdgeInsets.symmetric(vertical: $styles.insets.xxs, horizontal: $styles.insets.xs),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).indicatorColor,
                                      borderRadius: BorderRadius.circular($styles.corners.md),
                                    ),
                                    child: Text(
                                      '1 / 10',
                                      style: $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.onPrimary),
                                    ),
                                  ),
                                  title     : Text('${categoria.name}', style: $styles.textStyles.h4),
                                  children  : categoria.categoriasItems?.map((item) {
                                    final int itemIndex = categoria.categoriasItems!.indexOf(item) + 1;
                                    return Column(
                                      children  : <Widget>[
                                        Padding(
                                          padding : EdgeInsets.symmetric(horizontal: $styles.insets.sm),
                                          child   : Row(
                                            children  : <Widget>[
                                              CircleAvatar(radius: 14, child: Text('$itemIndex', style: $styles.textStyles.h4)),
                                              Gap($styles.insets.sm),
                                              Expanded(child: Text('${item.name}', style: $styles.textStyles.body.copyWith(height: 1.3), softWrap: true)),
                                            ],
                                          ),
                                        ),
                                        ListTile(
                                          contentPadding: EdgeInsets.symmetric(horizontal: $styles.insets.xs),
                                          title: _buildFormularioValuesContent(item),
                                        ),
                                      ],
                                    );
                                  }).toList() ?? [],
                                ),
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
        bottomNavigationBar: !_hasServerError
            ? BottomAppBar(
                child : Row(
                  children  : <Widget>[
                    IconButton(onPressed: (){}, icon: const Icon(Icons.camera_alt), tooltip: 'Tomar fotografía'),
                    IconButton(onPressed: (){}, icon: const Icon(Icons.sync), tooltip: 'Sincronizar información'),
                    const Spacer(),
                    FilledButton(onPressed: (){}, child: Text($strings.saveButtonText, style: $styles.textStyles.button)),
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

  Widget _buildFormularioValuesContent(CategoriaItem categoriaItem) {
    switch (categoriaItem.idFormularioTipo) {
      // OPCION MULTIPLE:
      case 'ea52bdfd-8af6-4f5a-b182-2b99e554eb32':
        final List<String> lstOptions = categoriaItem.formularioValor!.split(',');
        return Row(
          children  : <Widget>[
            Container(
              constraints : BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
              child       : Wrap(
                spacing     : 8,
                runSpacing  : 4,
                children    : lstOptions.map((opt) {
                  return Row(
                    mainAxisSize  : MainAxisSize.min,
                    children      : <Widget>[
                      Radio<String>(
                        value       : opt,
                        groupValue  : _selectedValueOption,
                        onChanged   : (value) {
                          setState(() {
                            _selectedValueOption = value;
                          });
                        },
                      ),
                      Text(opt, style: $styles.textStyles.body),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        );
      // DESCONOCIDO:
      default:
        return Text('Tipo de formulario desconocido', style: $styles.textStyles.body.copyWith(color: Theme.of(context).hintColor));
    }
  }
}
