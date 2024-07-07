part of '../../../pages/index/index_page.dart';

class _CreateInspeccionUnidadForm extends StatefulWidget {
  const _CreateInspeccionUnidadForm({Key? key}) : super(key: key);

  @override
  State<_CreateInspeccionUnidadForm> createState() => _CreateInspeccionUnidadFormState();
}

class _CreateInspeccionUnidadFormState extends State<_CreateInspeccionUnidadForm> {
  // GLOBAL KEY
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // CONTROLLERS
  late TextEditingController _unidadNumeroEconomicoController;
  late TextEditingController _unidadPlacaController;
  late TextEditingController _unidadNumeroSerieController;
  late TextEditingController _unidadModeloController;
  late TextEditingController _unidadAnioEquipoController;
  late TextEditingController _unidadDescripcionController;
  late TextEditingController _unidadCapacidadController;
  late TextEditingController _unidadOdometroController;
  late TextEditingController _unidadHorometroController;

  // LIST
  List<Base> lstBases                                         = [];
  List<UnidadCapacidadMedida> lstUnidadesCapacidadesMedidas   = [];
  List<UnidadMarca> lstUnidadesMarcas                         = [];
  List<UnidadTipo> lstUnidadesTipos                           = [];
  final List<UnidadPlacaTipo> lstUnidadesPlacasTipos          = <UnidadPlacaTipo>[
    const UnidadPlacaTipo(idUnidadPlacaTipo: 'ea52bdfd-8af6-4f5a-b182-2b99e554eb31', name: 'Estatal'),
    const UnidadPlacaTipo(idUnidadPlacaTipo: 'ea52bdfd-8af6-4f5a-b182-2b99e554eb32', name: 'Federal'),
    const UnidadPlacaTipo(idUnidadPlacaTipo: 'ea52bdfd-8af6-4f5a-b182-2b99e554eb33', name: 'No aplica'),
  ];

  // PROPERTIES
  bool _isLoading       = false;
  bool _hasServerError  = false;

  Base? _selectUnidadBase;
  UnidadCapacidadMedida? _selectUnidadCapacidadMedida;
  UnidadMarca? _selectUnidadMarca;
  UnidadTipo? _selectUnidadTipo;
  UnidadPlacaTipo? _selectUnidadPlacaTipo;

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
    _unidadNumeroEconomicoController.dispose();
    _unidadPlacaController.dispose();
    _unidadNumeroSerieController.dispose();
    _unidadModeloController.dispose();
    _unidadAnioEquipoController.dispose();
    _unidadDescripcionController.dispose();
    _unidadCapacidadController.dispose();
    _unidadOdometroController.dispose();
    _unidadHorometroController.dispose();
    super.dispose();
  }

  // EVENTS
  void _handleDidPopPressed(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppStrings.exitConfirmationDialogTitle, style: $styles.textStyles.title1.copyWith(fontWeight: FontWeight.w600)),
          content: Text(AppStrings.exitConfirmationDialogMessage, style: $styles.textStyles.body.copyWith(height: 1.3)),
          actions: <Widget>[
            TextButton(
              onPressed : () => Navigator.pop(context, AppStrings.btnCancelText),
              child     : Text(AppStrings.btnCancelText, style: $styles.textStyles.button),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();  // Cerrar dialog
                Navigator.of(context).pop();  // Cerrar página
              },
              child: Text(AppStrings.btnAcceptText, style: $styles.textStyles.button),
            ),
          ],
        );
      },
    );
  }

  void _handleRefreshPressed() {
    _create();
  }

  void _handleStorePressed() {
    if (!_formKey.currentState!.validate()) {
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
                AppStrings.errorAlertInvalidFormMessage,
                style     : $styles.textStyles.bodySmall.copyWith(color: $styles.colors.white),
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

    _formKey.currentState!.save();
    _store();
  }

  Future<void> _showServerErrorDialog(BuildContext context, String? message) async {
    return showDialog<void>(context: context, builder: (BuildContext context) => ServerFailedDialog(message: message ?? AppStrings.errorGenericMessage));
  }

  // METHODS
  Future<void> _create() async {
    context.read<RemoteUnidadBloc>().add(CreateUnidad());
  }

  Future<void> _store() async {
    final UnidadStoreReqEntity objPost = UnidadStoreReqEntity(
      numeroEconomico           : _unidadNumeroEconomicoController.text,
      idBase                    : _selectUnidadBase?.idBase                   ?? '',
      baseName                  : _selectUnidadBase?.name                     ?? '',
      idUnidadTipo              : _selectUnidadTipo?.idUnidadTipo             ?? '',
      unidadTipoName            : _selectUnidadTipo?.name                     ?? '',
      idUnidadMarca             : _selectUnidadMarca?.idUnidadMarca           ?? '',
      unidadMarcaName           : _selectUnidadMarca?.name                    ?? '',
      idUnidadPlacaTipo         : _selectUnidadPlacaTipo?.idUnidadPlacaTipo   ?? '',
      unidadPlacaTipoName       : _selectUnidadPlacaTipo?.name                ?? '',
      placa                     : _unidadPlacaController.text,
      numeroSerie               : _unidadNumeroSerieController.text,
      modelo                    : _unidadModeloController.text,
      anioEquipo                : _unidadAnioEquipoController.text,
      descripcion               : _unidadDescripcionController.text,
      capacidad                 : double.tryParse(_unidadCapacidadController.text)        ?? 0.000,
      idUnidadCapacidadMedida   : _selectUnidadCapacidadMedida?.idUnidadCapacidadMedida   ?? '',
      unidadCapacidadMedidaName : _selectUnidadCapacidadMedida?.name                      ?? '',
      odometro                  : int.tryParse(_unidadOdometroController.text)            ?? 0,
      horometro                 : int.tryParse(_unidadHorometroController.text)           ?? 0,
    );

    context.read<RemoteUnidadBloc>().add(StoreUnidad(objPost));
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) => !didPop ? _handleDidPopPressed(context) : null,
      child: Scaffold(
        appBar: AppBar(title: Text(AppStrings.unidadCreateAppBarTitle, style: $styles.textStyles.h3)),
        body: BlocConsumer<RemoteUnidadBloc, RemoteUnidadState>(
          listener: (BuildContext context, RemoteUnidadState state) {
            // LOADING
            if (state is RemoteUnidadCreateLoading) {
              setState(() {
                _isLoading = true;
              });
            }

            // ERROR
            if (state is RemoteUnidadServerFailedMessageCreate || state is RemoteUnidadServerExceptionMessageCreate) {
              setState(() {
                _hasServerError = true;
                _isLoading      = false;
              });
            }

            // SUCCESS
            if (state is RemoteUnidadCreate) {
              setState(() {
                _hasServerError = false;
                _isLoading      = false;

                // LISTAS DE COMBOBOX
                lstBases                      = state.objResponse?.bases                        ?? [];
                lstUnidadesCapacidadesMedidas = state.objResponse?.unidadesCapacidadesMedidas   ?? [];
                lstUnidadesMarcas             = state.objResponse?.unidadesMarcas               ?? [];
                lstUnidadesTipos              = state.objResponse?.unidadesTipos                ?? [];
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
              return ErrorServerMessage(message: state.error, onPressed: _handleRefreshPressed);
            }

            if (state is RemoteUnidadServerExceptionMessageCreate) {
              return ErrorServerMessage(message: state.error?.message, onPressed: _handleRefreshPressed);
            }

            // SUCCESS
            if (state is RemoteUnidadCreate) {
              return SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all($styles.insets.sm).copyWith(bottom: $styles.insets.lg),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        // CAMPO: UNIDAD NUMERO ECONOMICO
                        LabeledTextFormField(
                          controller  : _unidadNumeroEconomicoController,
                          hintText    : 'Ingrese número económico',
                          label       : '* Número económico:',
                          validator   : FormValidators.textValidator,
                        ),

                        Gap($styles.insets.sm),

                        // CAMPO: UNIDAD TIPO
                        LabeledDropdownFormField<UnidadTipo>(
                          items       : lstUnidadesTipos,
                          itemBuilder : (item) => Text(item.name ?? ''),
                          label       : '* Tipo de unidad:',
                          onChanged   : (value) => setState(() => _selectUnidadTipo = value),
                          validator   : FormValidators.dropdownValidator,
                          value       : _selectUnidadTipo,
                        ),

                        Gap($styles.insets.sm),

                        // CAMPO: UNIDAD MARCA
                        LabeledDropdownFormField<UnidadMarca>(
                          items       : lstUnidadesMarcas,
                          itemBuilder : (item) => Text(item.name ?? ''),
                          label       : 'Marca:',
                          onChanged   : (value) => setState(() => _selectUnidadMarca = value),
                          value       : _selectUnidadMarca,
                        ),

                        Gap($styles.insets.sm),

                        // CAMPO: UNIDAD MODELO
                        LabeledTextFormField(
                          controller  : _unidadModeloController,
                          hintText    : 'Ingrese modelo',
                          label       : 'Modelo:',
                        ),

                        Gap($styles.insets.sm),

                        // CAMPO: UNIDAD NUMERO DE SERIE
                        LabeledTextFormField(
                          controller  : _unidadNumeroSerieController,
                          hintText    : 'Ingrese número de serie',
                          label       : 'Número de serie:',
                        ),

                        Gap($styles.insets.sm),

                        // CAMPO: UNIDAD BASE
                        LabeledDropdownFormField<Base>(
                          items       : lstBases,
                          itemBuilder : (item) => Text(item.name ?? ''),
                          label       : 'Base:',
                          onChanged   : (value) => setState(() => _selectUnidadBase = value),
                          value       : _selectUnidadBase,
                        ),

                        Gap($styles.insets.sm),

                        // CAMPOS: UNIDAD PLACA / PLACA TIPO
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
                                items       : lstUnidadesPlacasTipos,
                                itemBuilder : (item) => Text(item.name ?? ''),
                                label       : 'Tipo de placa:',
                                onChanged   : (value) => setState(() => _selectUnidadPlacaTipo = value),
                                value       : _selectUnidadPlacaTipo,
                              ),
                            ),
                          ],
                        ),

                        Gap($styles.insets.sm),

                        // CAMPO: UNIDAD AÑO DEL EQUIPO
                        LabeledTextFormField(
                          controller  : _unidadAnioEquipoController,
                          hintText    : 'Ingrese año del equipo',
                          label       : 'Año del equipo:',
                        ),

                        Gap($styles.insets.sm),

                        // CAMPO: UNIDAD DESCRIPCIÓN DE CREACIÓN O MOTIVO
                        LabeledTextareaFormField(
                          controller    : _unidadDescripcionController,
                          hintText      : 'Ingrese descripción de creación de unidad...',
                          label         : 'Descripción (opcional):',
                          maxCharacters : 300,
                          maxLines      : 3,
                        ),

                        Gap($styles.insets.sm),

                        // CAMPOS: UNIDAD CAPACIDAD / CAPACIDAD MEDIDA
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: LabeledTextFormField(
                                controller    : _unidadCapacidadController,
                                hintText      : 'Ingrese cantidad',
                                keyboardType  : TextInputType.number,
                                label         : 'Capacidad:',
                                validator     : FormValidators.decimalValidatorNull,
                              ),
                            ),
                            Gap($styles.insets.sm),
                            Expanded(
                              child: LabeledDropdownFormField<UnidadCapacidadMedida>(
                                items       : lstUnidadesCapacidadesMedidas,
                                itemBuilder : (item) => Text(item.name ?? ''),
                                label       : 'Tipo de capacidad:',
                                onChanged   : (value) => setState(() => _selectUnidadCapacidadMedida = value),
                                value       : _selectUnidadCapacidadMedida,
                              ),
                            ),
                          ],
                        ),

                        Gap($styles.insets.sm),

                        // CAMPOS: UNIDAD ODOMETRO / HOROMETRO
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            onPressed : _handleRefreshPressed,
            icon      : const Icon(Icons.refresh), tooltip: AppStrings.refreshDataTooltip,
          ),
          BlocConsumer<RemoteUnidadBloc, RemoteUnidadState>(
            listener: (BuildContext context, RemoteUnidadState state) {
              // ERROR
              if (state is RemoteUnidadServerFailedMessageStore) {
                _showServerErrorDialog(context, state.error);

                // Actualizar nuevamente los datos.
                _create();
              }

              if (state is RemoteUnidadServerExceptionMessageStore) {
                _showServerErrorDialog(context, state.error?.message);

                // Actualizar nuevamente los datos.
                _create();
              }

              // SUCCESS
              if (state is RemoteUnidadStore) {
                Navigator.of(context).pop(); // Cerramos el modal

                ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(
                      state.objResponse?.message ?? 'Nueva unidad',
                      style     : $styles.textStyles.bodySmall.copyWith(color: $styles.colors.white),
                      softWrap  : true,
                    ),
                    backgroundColor : $styles.colors.success,
                    elevation       : 0,
                    behavior        : SnackBarBehavior.fixed,
                  ),
                );
              }
            },
            builder: (BuildContext context, RemoteUnidadState state) {
              // LOADING
              if (state is RemoteUnidadStoreLoading) {
                return const FilledButton(
                  onPressed : null,
                  child     : AppLoadingIndicator(width: 20, height: 20),
                );
              }
              return FilledButton(
                onPressed : !_hasServerError && !_isLoading ? _handleStorePressed : null,
                child     : Text(AppStrings.btnSaveText, style: $styles.textStyles.button),
              );
            },
          ),
        ],
      ),
    );
  }
}
