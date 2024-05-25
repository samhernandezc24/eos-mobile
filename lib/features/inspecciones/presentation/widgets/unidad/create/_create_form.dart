part of '../../../pages/list/list_page.dart';

class _CreateUnidadForm extends StatefulWidget {
  const _CreateUnidadForm({required this.buildListUnidadesCallback, Key? key}) : super(key: key);

  final VoidCallback buildListUnidadesCallback;

  @override
  State<_CreateUnidadForm> createState() => _CreateUnidadFormState();
}

class _CreateUnidadFormState extends State<_CreateUnidadForm> {
  // GLOBAL KEY
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // CONTROLLERS
  late final TextEditingController _numeroEconomicoController;
  late final TextEditingController _placaController;
  late final TextEditingController _numeroSerieController;
  late final TextEditingController _modeloController;
  late final TextEditingController _anioEquipoController;
  late final TextEditingController _descripcionController;
  late final TextEditingController _capacidadController;
  late final TextEditingController _odometroController;
  late final TextEditingController _horometroController;

  // LIST
  List<Base> lstBases                                       = <Base>[];
  List<UnidadCapacidadMedida> lstUnidadCapacidadesMedidas   = <UnidadCapacidadMedida>[];
  List<UnidadMarca> lstUnidadesMarcas                       = <UnidadMarca>[];
  List<UnidadTipo> lstUnidadesTipos                         = <UnidadTipo>[];

  final List<UnidadPlacaTipo> lstUnidadesPlacasTipos = <UnidadPlacaTipo>[
    const UnidadPlacaTipo(idUnidadPlacaTipo: 'ea52bdfd-8af6-4f5a-b182-2b99e554eb31', name: 'Estatal'),
    const UnidadPlacaTipo(idUnidadPlacaTipo: 'ea52bdfd-8af6-4f5a-b182-2b99e554eb32', name: 'Federal'),
    const UnidadPlacaTipo(idUnidadPlacaTipo: 'ea52bdfd-8af6-4f5a-b182-2b99e554eb33', name: 'No aplica'),
  ];

  // SELECTED UNIDAD PLACA TIPO
  UnidadPlacaTipo? _selectedUnidadPlacaTipo;

  // SELECTED UNIDAD MARCA
  UnidadMarca? _selectedUnidadMarca;

  // SELECTED UNIDAD TIPO
  UnidadTipo? _selectedUnidadTipo;

  // SELECTED BASE
  Base? _selectedBase;

  // SELECTED UNIDAD CAPACIDAD MEDIDA
  UnidadCapacidadMedida? _selectedUnidadCapacidadMedida;

  @override
  void initState() {
    super.initState();
    context.read<RemoteUnidadBloc>().add(FetchUnidadCreate());

    _numeroEconomicoController  = TextEditingController();
    _placaController            = TextEditingController();
    _numeroSerieController      = TextEditingController();
    _modeloController           = TextEditingController();
    _anioEquipoController       = TextEditingController();
    _descripcionController      = TextEditingController();
    _capacidadController        = TextEditingController();
    _odometroController         = TextEditingController();
    _horometroController        = TextEditingController();
  }

  @override
  void dispose() {
    _numeroEconomicoController.dispose();
    _placaController.dispose();
    _numeroSerieController.dispose();
    _modeloController.dispose();
    _anioEquipoController.dispose();
    _descripcionController.dispose();
    _capacidadController.dispose();
    _odometroController.dispose();
    _horometroController.dispose();
    super.dispose();
  }

  // METHODS
  void _handleDidPopPressed(BuildContext context) {
    showDialog<void>(
      context : context,
      builder : (BuildContext context) => AlertDialog(
        title   : const SizedBox.shrink(),
        content : Text('¿Estás seguro que deseas salir?', style: $styles.textStyles.bodySmall.copyWith(fontSize: 16)),
        actions : <Widget>[
          TextButton(
            onPressed : () { Navigator.of(context).pop(); },
            child     : Text($strings.cancelButtonText, style: $styles.textStyles.button),
          ),
          TextButton(
            onPressed : () {
              Navigator.of(context).pop(); // Cerrar dialog
              // Ejecutar el callback una vez finalizada la acción pop.
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pop();        // Cerrar página
                widget.buildListUnidadesCallback(); // Ejecutar callback
              });
            },
            child : Text($strings.acceptButtonText, style: $styles.textStyles.button),
          ),
        ],
      ),
    );
  }

  void _handleStoreUnidadPressed() {
    // Verificar la validacion en el formulario.
    if (_formKey.currentState!.validate()) {
      final double? capacidad   = double.tryParse(_capacidadController.text);
      final int? odometro       = int.tryParse(_odometroController.text);
      final int? horometro      = int.tryParse(_horometroController.text);

      final UnidadStoreReqEntity objData = UnidadStoreReqEntity(
        numeroEconomico             : _numeroEconomicoController.text,
        idBase                      : _selectedBase?.idBase                                   ?? '',
        baseName                    : _selectedBase?.name                                     ?? '',
        idUnidadTipo                : _selectedUnidadTipo?.idUnidadTipo                       ?? '',
        unidadTipoName              : _selectedUnidadTipo?.name                               ?? '',
        idUnidadMarca               : _selectedUnidadMarca?.idUnidadMarca                     ?? '',
        unidadMarcaName             : _selectedUnidadMarca?.name                              ?? '',
        idUnidadPlacaTipo           : _selectedUnidadPlacaTipo?.idUnidadPlacaTipo             ?? '',
        unidadPlacaTipoName         : _selectedUnidadPlacaTipo?.name                          ?? '',
        placa                       : _placaController.text,
        numeroSerie                 : _numeroSerieController.text,
        modelo                      : _modeloController.text,
        anioEquipo                  : _anioEquipoController.text,
        descripcion                 : _descripcionController.text,
        capacidad                   : capacidad ?? 0.000,
        idUnidadCapacidadMedida     : _selectedUnidadCapacidadMedida?.idUnidadCapacidadMedida ?? '',
        unidadCapacidadMedidaName   : _selectedUnidadCapacidadMedida?.name                    ?? '',
        odometro                    : odometro,
        horometro                   : horometro,
      );

      // Guardar el estado actual del formulario.
      _formKey.currentState!.save();

      // Evento StoreUnidad del Bloc.
      BlocProvider.of<RemoteUnidadBloc>(context).add(StoreUnidad(objData));
    }
  }

  Future<void> _showServerErrorDialog(BuildContext context, String? errorMessage) {
    return showDialog<void>(
      context   : context,
      builder   : (_) => AlertDialog(
        title   : const SizedBox.shrink(),
        content : Row(
          children: <Widget>[
            Icon(Icons.error, color: Theme.of(context).colorScheme.error),
            Gap($styles.insets.sm),
            Flexible(
              child: Text(
                errorMessage ?? 'Se produjo un error inesperado. Intenta crear la unidad de nuevo.',
                style: $styles.textStyles.title2.copyWith(height: 1.5),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(onPressed: () => context.pop(), child: Text($strings.acceptButtonText, style: $styles.textStyles.button)),
        ],
      ),
    );
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
        appBar  : AppBar(title: Text('Nueva unidad', style: $styles.textStyles.h3)),
        body    : SafeArea(
          child: SingleChildScrollView(
            padding : EdgeInsets.all($styles.insets.sm).copyWith(bottom: $styles.insets.lg),
            child   : Form(
              key   : _formKey,
              child : Column(
                crossAxisAlignment  : CrossAxisAlignment.stretch,
                children            : <Widget>[
                  // UNIDAD NUMERO ECONOMICO:
                  LabeledTextFormField(
                    autoFocus   : true,
                    controller  : _numeroEconomicoController,
                    hintText    : 'Ingrese número económico',
                    label       : '* Número económico:',
                    validator   : FormValidators.textValidator,
                  ),

                  Gap($styles.insets.sm),

                  // MODELO:
                  LabeledTextFormField(
                    controller  : _modeloController,
                    hintText    : 'Ingrese modelo',
                    label       : '* Modelo:',
                    validator   : FormValidators.textValidator,
                  ),

                  Gap($styles.insets.sm),

                  // NUMERO DE SERIE:
                  LabeledTextFormField(
                    controller  : _numeroSerieController,
                    hintText    : 'Ingrese número de serie',
                    label       : '* Número de serie:',
                    validator   : FormValidators.textValidator,
                  ),

                  Gap($styles.insets.sm),

                  // SELECCIONAR MARCA:
                  BlocBuilder<RemoteUnidadBloc, RemoteUnidadState>(
                    builder: (BuildContext context, RemoteUnidadState state) {
                      if (state is RemoteUnidadCreateLoading) {
                        return const Center(child: AppLoadingIndicator(width: 20, height: 20));
                      }

                      if (state is RemoteUnidadServerFailedMessageCreate) {
                        return ErrorBoxContainer(
                          errorMessage  : state.errorMessage ?? 'Se produjo un error al cargar el listado de marcas.',
                          onPressed     : () => context.read<RemoteUnidadBloc>().add(FetchUnidadCreate()),
                        );
                      }

                      if (state is RemoteUnidadServerFailureCreate) {
                        return ErrorBoxContainer(
                          errorMessage  : state.failure?.errorMessage ?? 'Se produjo un error al cargar el listado de marcas.',
                          onPressed     : () => context.read<RemoteUnidadBloc>().add(FetchUnidadCreate()),
                        );
                      }

                      if (state is RemoteUnidadCreateLoaded) {
                        lstUnidadesMarcas = state.objResponse?.unidadesMarcas ?? [];
                        return LabeledDropdownFormField<UnidadMarca>(
                          label       : '* Marca:',
                          items       : lstUnidadesMarcas,
                          itemBuilder : (item) => Text(item.name ?? ''),
                          onChanged   : (value) => setState(() => _selectedUnidadMarca = value),
                          validator   : FormValidators.dropdownValidator,
                          value       : _selectedUnidadMarca,
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),

                  Gap($styles.insets.sm),

                  // SELECCIONAR UNIDAD TIPO:
                  BlocBuilder<RemoteUnidadBloc, RemoteUnidadState>(
                    builder: (context, state) {
                      if (state is RemoteUnidadCreateLoading) {
                        return const Center(child: AppLoadingIndicator(width: 20, height: 20));
                      }

                      if (state is RemoteUnidadServerFailedMessageCreate) {
                        return ErrorBoxContainer(
                          errorMessage  : state.errorMessage ?? 'Se produjo un error al cargar el listado de tipos de unidad.',
                          onPressed     : () => context.read<RemoteUnidadBloc>().add(FetchUnidadCreate()),
                        );
                      }

                      if (state is RemoteUnidadServerFailureCreate) {
                        return ErrorBoxContainer(
                          errorMessage  : state.failure?.errorMessage ?? 'Se produjo un error al cargar el listado de tipos de unidad.',
                          onPressed     : () => context.read<RemoteUnidadBloc>().add(FetchUnidadCreate()),
                        );
                      }

                      if (state is RemoteUnidadCreateLoaded) {
                        lstUnidadesTipos = state.objResponse?.unidadesTipos ?? [];
                        return LabeledDropdownFormField<UnidadTipo>(
                          label       : '* Tipo de unidad:',
                          items       : lstUnidadesTipos,
                          itemBuilder : (item) => Text(item.name ?? ''),
                          onChanged   : (value) => setState(() => _selectedUnidadTipo = value),
                          validator   : FormValidators.dropdownValidator,
                          value       : _selectedUnidadTipo,
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),

                  Gap($styles.insets.sm),

                  // UNIDAD PLACA TIPO / PLACA:
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: LabeledTextFormField(
                          controller  : _placaController,
                          hintText    : 'Ingrese placa',
                          label       : 'Placa:',
                        ),
                      ),
                      Gap($styles.insets.sm),
                      Expanded(
                        child: LabeledDropdownFormField<UnidadPlacaTipo>(
                          label       : 'Tipo de placa:',
                          items       : lstUnidadesPlacasTipos,
                          itemBuilder : (item) => Text(item.name ?? ''),
                          onChanged   : (value) => setState(() => _selectedUnidadPlacaTipo = value),
                          value       : _selectedUnidadPlacaTipo,
                        ),
                      ),
                    ],
                  ),

                  Gap($styles.insets.sm),

                  // AÑO DEL EQUIPO:
                  LabeledTextFormField(controller: _anioEquipoController, label: 'Año del equipo:'),

                  Gap($styles.insets.sm),

                  // SELECCIONAR BASE:
                  BlocBuilder<RemoteUnidadBloc, RemoteUnidadState>(
                    builder: (BuildContext context, RemoteUnidadState state) {
                      if (state is RemoteUnidadCreateLoading) {
                        return const Center(child: AppLoadingIndicator(width: 20, height: 20));
                      }

                      if (state is RemoteUnidadServerFailedMessageCreate) {
                        return ErrorBoxContainer(
                          errorMessage  : state.errorMessage ?? 'Se produjo un error al cargar el listado de bases.',
                          onPressed     : () => context.read<RemoteUnidadBloc>().add(FetchUnidadCreate()),
                        );
                      }

                      if (state is RemoteUnidadServerFailureCreate) {
                        return ErrorBoxContainer(
                          errorMessage  : state.failure?.errorMessage ?? 'Se produjo un error al cargar el listado de bases.',
                          onPressed     : () => context.read<RemoteUnidadBloc>().add(FetchUnidadCreate()),
                        );
                      }

                      if (state is RemoteUnidadCreateLoaded) {
                        lstBases = state.objResponse?.bases ?? [];
                        return LabeledDropdownFormField<Base>(
                          label       : '* Base:',
                          items       : lstBases,
                          itemBuilder : (item) => Text(item.name ?? ''),
                          onChanged   : (value) => setState(() => _selectedBase = value),
                          validator   : FormValidators.dropdownValidator,
                          value       : _selectedBase,
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),

                  Gap($styles.insets.sm),

                  // LOCACIÓN:
                  LabeledTextareaFormField(
                    controller    : _descripcionController,
                    hintText      : 'Ingrese descripción de creación de unidad',
                    labelText     : 'Descripción (opcional):',
                    maxLines      : 2,
                    maxCharacters : 300,
                  ),

                  Gap($styles.insets.sm),

                  // UNIDAD CAPACIDAD / SELECCIONAR CAPACIDAD MEDIDA:
                  Row(
                    children: <Widget>[
                      Expanded(
                        child : LabeledTextFormField(
                          controller    : _capacidadController,
                          hintText      : 'Ingrese cantidad',
                          label         : '* Capacidad:',
                          keyboardType  : TextInputType.number,
                          validator     : FormValidators.decimalValidator,
                        ),
                      ),
                      Gap($styles.insets.sm),
                      Expanded(
                        child: BlocBuilder<RemoteUnidadBloc, RemoteUnidadState>(
                          builder: (BuildContext context, RemoteUnidadState state) {
                            if (state is RemoteUnidadCreateLoading) {
                              return const Center(child: AppLoadingIndicator(width: 20, height: 20));
                            }

                            if (state is RemoteUnidadServerFailedMessageCreate) {
                              return ErrorBoxContainer(
                                errorMessage  : state.errorMessage ?? 'Se produjo un error al cargar el listado de tipos de unidades capacidades medidas.',
                                onPressed     : () => context.read<RemoteUnidadBloc>().add(FetchUnidadCreate()),
                              );
                            }

                            if (state is RemoteUnidadServerFailureCreate) {
                              return ErrorBoxContainer(
                                errorMessage  : state.failure?.errorMessage ?? 'Se produjo un error al cargar el listado de tipos de unidades capacidades medidas.',
                                onPressed     : () => context.read<RemoteUnidadBloc>().add(FetchUnidadCreate()),
                              );
                            }

                            if (state is RemoteUnidadCreateLoaded) {
                              lstUnidadCapacidadesMedidas = state.objResponse?.unidadesCapacidadesMedidas ?? [];
                              return LabeledDropdownFormField<UnidadCapacidadMedida>(
                                label       : '* Tipo de capacidad:',
                                items       : lstUnidadCapacidadesMedidas,
                                itemBuilder : (item) => Text(item.name ?? ''),
                                onChanged   : (value) => setState(() => _selectedUnidadCapacidadMedida = value),
                                validator   : FormValidators.dropdownValidator,
                                value       : _selectedUnidadCapacidadMedida,
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ),
                    ],
                  ),

                  Gap($styles.insets.sm),

                  // ODOMETRO / HOROMETRO:
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: LabeledTextFormField(
                          controller    : _odometroController,
                          hintText      : 'Ingrese cantidad',
                          keyboardType  : TextInputType.number,
                          label         : 'Odómetro (Si aplica):',
                          validator     : FormValidators.integerValidator,
                        ),
                      ),
                      Gap($styles.insets.sm),
                      Expanded(
                        child: LabeledTextFormField(
                          controller      : _horometroController,
                          hintText        : 'Ingrese cantidad',
                          keyboardType    : TextInputType.number,
                          label           : 'Horómetro (Si aplica):',
                          textInputAction : TextInputAction.done,
                          validator       : FormValidators.integerValidator,
                        ),
                      ),
                    ],
                  ),

                  Gap($styles.insets.lg),

                  BlocConsumer<RemoteUnidadBloc, RemoteUnidadState>(
                    listener: (BuildContext context, RemoteUnidadState state) {
                      if (state is RemoteUnidadServerFailedMessageStore) {
                        _showServerErrorDialog(context, state.errorMessage);
                        context.read<RemoteUnidadBloc>().add(FetchUnidadCreate());
                      }

                      if (state is RemoteUnidadServerFailureStore) {
                        _showServerErrorDialog(context, state.failure?.errorMessage);
                        context.read<RemoteUnidadBloc>().add(FetchUnidadCreate());
                      }

                      if (state is RemoteUnidadStored) {
                        // Cerrar el diálogo antes de mostrar el SnackBar.
                        Navigator.of(context).pop();

                        // Mostramos el SnackBar.
                        ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                            content         : Text(state.objResponse?.message ?? 'Nueva unidad', softWrap: true),
                            backgroundColor : Colors.green,
                            behavior        : SnackBarBehavior.fixed,
                            elevation       : 0,
                          ),
                        );

                        // Actualizar el listado de unidades.
                        context.read<RemoteUnidadBloc>().add(ListUnidades());
                      }
                    },
                    builder: (BuildContext context, RemoteUnidadState state) {
                      if (state is RemoteUnidadStoring) {
                        return FilledButton(
                          onPressed : null,
                          style     : ButtonStyle(minimumSize: MaterialStateProperty.all<Size?>(const Size(double.infinity, 48))),
                          child     : const AppLoadingIndicator(width: 20, height: 20),
                        );
                      }
                      return FilledButton(
                        onPressed : _handleStoreUnidadPressed,
                        style     : ButtonStyle(minimumSize: MaterialStateProperty.all<Size?>(const Size(double.infinity, 48))),
                        child     : Text($strings.saveButtonText, style: $styles.textStyles.button),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
