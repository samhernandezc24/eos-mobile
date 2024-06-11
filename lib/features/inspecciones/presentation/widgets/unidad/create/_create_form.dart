part of '../../../pages/list/list_page.dart';

class _CreateUnidadForm extends StatefulWidget {
  const _CreateUnidadForm({Key? key, this.buildSearchUnidadCallback}) : super(key: key);

  final VoidCallback? buildSearchUnidadCallback;

  @override
  State<_CreateUnidadForm> createState() => _CreateUnidadFormState();
}

class _CreateUnidadFormState extends State<_CreateUnidadForm> {
  // GLOBAL KEY
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // CONTROLLERS
  late final TextEditingController _unidadNumeroEconomicoController;
  late final TextEditingController _unidadPlacaController;
  late final TextEditingController _unidadNumeroSerieController;
  late final TextEditingController _unidadModeloController;
  late final TextEditingController _unidadAnioEquipoController;
  late final TextEditingController _unidadDescripcionController;
  late final TextEditingController _unidadCapacidadController;
  late final TextEditingController _unidadOdometroController;
  late final TextEditingController _unidadHorometroController;

  // LIST
  List<Base> lstBases                                       = [];
  List<UnidadCapacidadMedida> lstUnidadesCapacidadesMedidas = [];
  List<UnidadMarca> lstUnidadesMarcas                       = [];
  List<UnidadTipo> lstUnidadesTipos                         = [];

  final List<UnidadPlacaTipo> lstUnidadesPlacasTipos = <UnidadPlacaTipo>[
    const UnidadPlacaTipo(idUnidadPlacaTipo: 'ea52bdfd-8af6-4f5a-b182-2b99e554eb31', name: 'Estatal'),
    const UnidadPlacaTipo(idUnidadPlacaTipo: 'ea52bdfd-8af6-4f5a-b182-2b99e554eb32', name: 'Federal'),
    const UnidadPlacaTipo(idUnidadPlacaTipo: 'ea52bdfd-8af6-4f5a-b182-2b99e554eb33', name: 'No aplica'),
  ];

  // SELECTED
  UnidadMarca? _selectedUnidadMarca;
  UnidadTipo? _selectedUnidadTipo;
  UnidadPlacaTipo? _selectedUnidadPlacaTipo;
  UnidadCapacidadMedida? _selectedUnidadCapacidadMedida;
  Base? _selectedUnidadBase;

  // STATE
  @override
  void initState() {
    super.initState();
    _unidadNumeroEconomicoController  = TextEditingController();
    _unidadPlacaController            = TextEditingController();
    _unidadNumeroSerieController      = TextEditingController();
    _unidadModeloController           = TextEditingController();
    _unidadAnioEquipoController       = TextEditingController();
    _unidadDescripcionController      = TextEditingController();
    _unidadCapacidadController        = TextEditingController();
    _unidadOdometroController         = TextEditingController();
    _unidadHorometroController        = TextEditingController();
    _create();
  }

  @override
  void dispose() {
    super.dispose();
    _unidadNumeroEconomicoController.dispose();
    _unidadPlacaController.dispose();
    _unidadNumeroSerieController.dispose();
    _unidadModeloController.dispose();
    _unidadAnioEquipoController.dispose();
    _unidadDescripcionController.dispose();
    _unidadCapacidadController.dispose();
    _unidadOdometroController.dispose();
    _unidadHorometroController.dispose();
  }

  // EVENTS
  void _handleDidPopPressed(BuildContext context) {
    showDialog<void>(
      context : context,
      builder : (BuildContext context) => AlertDialog(
        title   : const SizedBox.shrink(),
        content : Text('¿Estás seguro que deseas salir?', style: $styles.textStyles.bodySmall.copyWith(fontSize: 16)),
        actions : <Widget>[
          TextButton(
            onPressed : () => Navigator.pop(context, $strings.cancelButtonText),
            child     : Text($strings.cancelButtonText, style: $styles.textStyles.button),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();            // Cerrar dialog
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pop();          // Cerrar página
                widget.buildSearchUnidadCallback!();  // Ejecutar callback
              });
            },
            child: Text($strings.acceptButtonText, style: $styles.textStyles.button),
          ),
        ],
      ),
    );
  }

  void _handleStorePressed() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text($strings.alertWarningInvalidFormTitle, style: $styles.textStyles.bodyBold),
              const Text('Por favor, revisa los campos del formulario.', softWrap: true),
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
      _formKey.currentState!.save();
      _store();
    }
  }

  Future<void> _showServerFailedDialog(BuildContext context, String? errorMessage) async {
    return showDialog<void>(
      context : context,
      builder: (BuildContext context)  => ServerFailedDialog(
        errorMessage: errorMessage ?? 'Se produjo un error inesperado. Intenta de nuevo guardar la unidad.',
      ),
    );
  }

  // METHODS
  Future<void> _create() async {
    context.read<RemoteUnidadBloc>().add(FetchUnidadCreate());
  }

  Future<void> _store() async {
    final UnidadStoreReqEntity objPost = UnidadStoreReqEntity(
      numeroEconomico             : _unidadNumeroEconomicoController.text,
      idBase                      : _selectedUnidadBase?.idBase ?? '',
      baseName                    : _selectedUnidadBase?.name ?? '',
      idUnidadTipo                : _selectedUnidadTipo?.idUnidadTipo ?? '',
      unidadTipoName              : _selectedUnidadTipo?.name ?? '',
      idUnidadMarca               : _selectedUnidadMarca?.idUnidadMarca ?? '',
      unidadMarcaName             : _selectedUnidadMarca?.name ?? '',
      idUnidadPlacaTipo           : _selectedUnidadPlacaTipo?.idUnidadPlacaTipo ?? '',
      unidadPlacaTipoName         : _selectedUnidadPlacaTipo?.name ?? '',
      placa                       : _unidadPlacaController.text,
      numeroSerie                 : _unidadNumeroSerieController.text,
      modelo                      : _unidadModeloController.text,
      anioEquipo                  : _unidadAnioEquipoController.text,
      descripcion                 : _unidadDescripcionController.text,
      capacidad                   : double.tryParse(_unidadCapacidadController.text) ?? 0.00,
      idUnidadCapacidadMedida     : _selectedUnidadCapacidadMedida?.idUnidadCapacidadMedida ?? '',
      unidadCapacidadMedidaName   : _selectedUnidadCapacidadMedida?.name ?? '',
      odometro                    : int.tryParse(_unidadOdometroController.text),
      horometro                   : int.tryParse(_unidadHorometroController.text),
    );

    BlocProvider.of<RemoteUnidadBloc>(context).add(StoreUnidad(objPost));
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (!didPop) {
          _handleDidPopPressed(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text($strings.unidadCreateAppBarTitle, style: $styles.textStyles.h3)),
        body: BlocConsumer<RemoteUnidadBloc, RemoteUnidadState>(
          listener: (BuildContext context, RemoteUnidadState state) {
            if (state is RemoteUnidadCreateLoaded) {
              setState(() {
                // FRAGMENTO MODIFICABLE - LISTAS
                lstBases                      = state.objResponse?.bases                      ?? [];
                lstUnidadesCapacidadesMedidas = state.objResponse?.unidadesCapacidadesMedidas ?? [];
                lstUnidadesMarcas             = state.objResponse?.unidadesMarcas             ?? [];
                lstUnidadesTipos              = state.objResponse?.unidadesTipos              ?? [];
              });
            }
          },
          builder: (BuildContext context, RemoteUnidadState state) {
            // LOADING
            if (state is RemoteUnidadCreateLoading) {
              return const Center(child: AppLoadingIndicator());
            }

            // ERROR
            if (state is RemoteUnidadServerFailedMessageCreate) {
              return ErrorInfoContainer(
                onPressed     : _create,
                errorMessage  : state.errorMessage,
              );
            }

            if (state is RemoteUnidadServerFailureCreate) {
              return ErrorInfoContainer(
                onPressed     : _create,
                errorMessage  : state.failure?.errorMessage,
              );
            }

            // SUCCESS
            if (state is RemoteUnidadCreateLoaded) {
              return SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all($styles.insets.sm).copyWith(bottom: $styles.insets.lg),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        // UNIDAD NUMERO ECONOMICO:
                        LabeledTextFormField(
                          autoFocus   : true,
                          controller  : _unidadNumeroEconomicoController,
                          hintText    : 'Ingrese número económico',
                          label       : '* Número económico:',
                          validator   : FormValidators.textValidator,
                        ),

                        Gap($styles.insets.sm),

                        // SELECCIONAR UNIDAD TIPO:
                        LabeledDropdownFormField<UnidadTipo>(
                          label       : '* Tipo de unidad:',
                          items       : lstUnidadesTipos,
                          itemBuilder : (item) => Text(item.name ?? ''),
                          onChanged   : (value) => setState(() => _selectedUnidadTipo = value),
                          validator   : FormValidators.dropdownValidator,
                          value       : _selectedUnidadTipo,
                        ),

                        Gap($styles.insets.sm),

                        // SELECCIONAR UNIDAD MARCA:
                        LabeledDropdownFormField<UnidadMarca>(
                          label       : '* Marca:',
                          items       : lstUnidadesMarcas,
                          itemBuilder : (item) => Text(item.name ?? ''),
                          onChanged   : (value) => setState(() => _selectedUnidadMarca = value),
                          validator   : FormValidators.dropdownValidator,
                          value       : _selectedUnidadMarca,
                        ),

                        Gap($styles.insets.sm),

                        // UNIDAD MODELO:
                        LabeledTextFormField(
                          controller  : _unidadModeloController,
                          hintText    : 'Ingrese modelo',
                          label       : '* Modelo:',
                          validator   : FormValidators.textValidator,
                        ),

                        Gap($styles.insets.sm),

                        // UNIDAD NUMERO DE SERIE:
                        LabeledTextFormField(
                          controller  : _unidadNumeroSerieController,
                          hintText    : 'Ingrese número de serie',
                          label       : '* Número de serie:',
                          validator   : FormValidators.textValidator,
                        ),

                        Gap($styles.insets.sm),

                        // SELECCIONA LA BASE DE LA UNIDAD:
                        LabeledDropdownFormField<Base>(
                          label       : '* Base:',
                          items       : lstBases,
                          itemBuilder : (item) => Text(item.name ?? ''),
                          onChanged   : (value) => setState(() => _selectedUnidadBase = value),
                          validator   : FormValidators.dropdownValidator,
                          value       : _selectedUnidadBase,
                        ),

                        Gap($styles.insets.sm),

                        // UNIDAD PLACA / SELECCIONAR UNIDAD PLACA TIPO:
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: LabeledTextFormField(
                                controller  : _unidadPlacaController,
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

                        // UNIDAD AÑO DEL EQUIPO:
                        LabeledTextFormField(
                          controller  : _unidadAnioEquipoController,
                          hintText    : 'Ingrese año del equipo',
                          label       : 'Año del equipo:',
                        ),

                        Gap($styles.insets.sm),

                        // DESCRIPCIÓN O MOTIVO DE CREACIÓN DE UNIDAD:
                        LabeledTextareaFormField(
                          controller      : _unidadDescripcionController,
                          hintText        : 'Ingrese descripción de creación de unidad temporal...',
                          labelText       : 'Descripción (opcional):',
                          maxLines        : 3,
                          maxCharacters   : 300,
                        ),

                        Gap($styles.insets.sm),

                        // UNIDAD CAPACIDAD / SELECCIONAR UNIDAD CAPACIDAD MEDIDA:
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: LabeledTextFormField(
                                controller    : _unidadCapacidadController,
                                hintText      : 'Ingrese cantidad',
                                label         : '* Capacidad:',
                                keyboardType  : TextInputType.number,
                                validator     : FormValidators.decimalValidator,
                              ),
                            ),
                            Gap($styles.insets.sm),
                            Expanded(
                              child: LabeledDropdownFormField<UnidadCapacidadMedida>(
                                label       : '* Tipo de capacidad:',
                                items       : lstUnidadesCapacidadesMedidas,
                                itemBuilder : (item) => Text(item.name ?? ''),
                                onChanged   : (value) => setState(() => _selectedUnidadCapacidadMedida = value),
                                validator   : FormValidators.dropdownValidator,
                                value       : _selectedUnidadCapacidadMedida,
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
                                controller    : _unidadOdometroController,
                                hintText      : 'Ingrese cantidad',
                                keyboardType  : TextInputType.number,
                                label         : 'Odómetro (Si aplica):',
                                validator     : FormValidators.integerValidator,
                              ),
                            ),
                            Gap($styles.insets.sm),
                            Expanded(
                              child: LabeledTextFormField(
                                controller    : _unidadHorometroController,
                                hintText      : 'Ingrese cantidad',
                                keyboardType  : TextInputType.number,
                                label         : 'Horómetro (Si aplica):',
                                validator     : FormValidators.integerValidator,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
        bottomNavigationBar: _buildBottomAppBar(context),
      ),
    );
  }

  Widget _buildBottomAppBar(BuildContext context) {
    return BottomAppBar(
      height: 70,
      child : Row(
        children: <Widget>[
          IconButton(
            onPressed : _create,
            icon      : const Icon(Icons.refresh),
            tooltip   : 'Actualizar datos',
          ),
          const Spacer(),
          BlocConsumer<RemoteUnidadBloc, RemoteUnidadState>(
            listener: (BuildContext context, RemoteUnidadState state) {
              if (state is RemoteUnidadServerFailedMessageStore) {
                _showServerFailedDialog(context, state.errorMessage);
                _create();
              }

              if (state is RemoteUnidadServerFailureStore) {
                _showServerFailedDialog(context, state.failure?.errorMessage);
                _create();
              }

              if (state is RemoteUnidadStoreSuccess) {
                Navigator.of(context).pop();

                ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content         : Text(state.objResponse?.message ?? 'Nueva unidad', softWrap: true),
                    backgroundColor : Colors.green,
                    elevation       : 0,
                    behavior        : SnackBarBehavior.fixed,
                  ),
                );

                // Ejecutar callback.
                widget.buildSearchUnidadCallback!();
              }
            },
            builder: (BuildContext context, RemoteUnidadState state) {
              if (state is RemoteUnidadStoreLoading) {
                return const FilledButton(
                  onPressed : null,
                  child     : AppLoadingIndicator(width: 20, height: 20),
                );
              }
              return FilledButton(
                onPressed : _handleStorePressed,
                child     : Text($strings.saveButtonText, style: $styles.textStyles.button),
              );
            },
          ),
        ],
      ),
    );
  }
}
