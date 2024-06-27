part of '../../../pages/list/list_page.dart';

class _CreateInspeccionForm extends StatefulWidget {
  const _CreateInspeccionForm({Key? key, this.onFinish}) : super(key: key);

  final VoidCallback? onFinish;

  @override
  State<_CreateInspeccionForm> createState() => _CreateInspeccionFormState();
}

class _CreateInspeccionFormState extends State<_CreateInspeccionForm> {
  // GLOBAL KEY
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // CONTROLLERS
  late final TextEditingController _fechaProgramadaController;
  late final TextEditingController _unidadNumeroEconomicoController;
  late final TextEditingController _unidadTipoNameController;
  late final TextEditingController _unidadMarcaNameController;
  late final TextEditingController _unidadModeloController;
  late final TextEditingController _unidadPlacaTipoNameController;
  late final TextEditingController _unidadPlacaController;
  late final TextEditingController _unidadNumeroSerieController;
  late final TextEditingController _unidadAnioEquipoController;
  late final TextEditingController _unidadBaseNameController;
  late final TextEditingController _unidadTipoPlataformaController;
  late final TextEditingController _unidadCapacidadController;
  late final TextEditingController _unidadOdometroController;
  late final TextEditingController _unidadHorometroController;
  late final TextEditingController _locacionController;

  // PROPERTIES
  InspeccionUnidadSelectOption _inspeccionUnidadSelectOption = InspeccionUnidadSelectOption.inventario;

  InspeccionTipoEntity? _selectInspeccionTipo;
  UnidadCapacidadMedida? _selectUnidadCapacidadMedida;

  UnidadPredictiveListEntity? _selectedUnidad;
  UnidadEOSPredictiveListEntity? _selectedUnidadEOS;

  String _errorMessage  = '';
  bool _hasServerError  = false;
  bool _isLoading       = false;

  // LIST
  List<InspeccionTipoEntity> lstInspeccionesTipos           = [];
  List<UnidadCapacidadMedida> lstUnidadesCapacidadesMedidas = [];
  List<UnidadPredictiveListEntity> lstUnidades              = [];
  List<UnidadEOSPredictiveListEntity> lstUnidadesEOS        = [];

  // STATE
  @override
  void initState() {
    super.initState();
    _fechaProgramadaController            = TextEditingController();
    _unidadNumeroEconomicoController      = TextEditingController();
    _unidadTipoNameController             = TextEditingController();
    _unidadMarcaNameController            = TextEditingController();
    _unidadModeloController               = TextEditingController();
    _unidadPlacaTipoNameController        = TextEditingController();
    _unidadPlacaController                = TextEditingController();
    _unidadNumeroSerieController          = TextEditingController();
    _unidadAnioEquipoController           = TextEditingController();
    _unidadBaseNameController             = TextEditingController();
    _unidadTipoPlataformaController       = TextEditingController();
    _unidadCapacidadController            = TextEditingController();
    _unidadOdometroController             = TextEditingController();
    _unidadHorometroController            = TextEditingController();
    _locacionController                   = TextEditingController();
    _create();
  }

  @override
  void dispose() {
    _fechaProgramadaController.dispose();
    _unidadNumeroEconomicoController.dispose();
    _unidadTipoNameController.dispose();
    _unidadMarcaNameController.dispose();
    _unidadModeloController.dispose();
    _unidadPlacaTipoNameController.dispose();
    _unidadPlacaController.dispose();
    _unidadNumeroSerieController.dispose();
    _unidadAnioEquipoController.dispose();
    _unidadBaseNameController.dispose();
    _unidadTipoPlataformaController.dispose();
    _unidadCapacidadController.dispose();
    _unidadOdometroController.dispose();
    _unidadHorometroController.dispose();
    _locacionController.dispose();
    super.dispose();
  }

  // EVENTS
  void _handleDidPopPressed(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text($strings.exitConfirmationDialogTitle, style: $styles.textStyles.title1.copyWith(fontWeight: FontWeight.w600)),
          content: Text($strings.exitConfirmationDialogMessage, style: $styles.textStyles.body.copyWith(height: 1.3)),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, $strings.cancelButtonText),
              child: Text($strings.cancelButtonText, style: $styles.textStyles.button),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();    // Cerrar dialog
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.of(context).pop();  // Cerrar ventana
                  widget.onFinish!();           // Ejecutar callback de actualización
                });
              },
              child: Text($strings.acceptButtonText, style: $styles.textStyles.button),
            ),
          ],
        );
      },
    );
  }

  void _handleCreateUnidadPressed(BuildContext context) {
    Navigator.push<void>(
      context,
      PageRouteBuilder<void>(
        transitionDuration: $styles.times.pageTransition,
        pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
          const Offset begin    = Offset(0, 1);
          const Offset end      = Offset.zero;
          const Cubic curve     = Curves.ease;

          final Animatable<Offset> tween = Tween<Offset>(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(position: animation.drive<Offset>(tween), child: const _CreateUnidadForm());
        },
        fullscreenDialog: true,
      ),
    );
  }

  void _onChangeSelectOption(bool? value) {
    setState(() {
      _inspeccionUnidadSelectOption = value ?? false
          ? InspeccionUnidadSelectOption.temporal
          : InspeccionUnidadSelectOption.inventario;
    });
  }

  void _handleUnidadSearchSubmitted(String query) {
    if (!Globals.isValidStringValue(query)) { return; }

    final List<SearchFilterPredictive> lstSearchFilters = [
      const SearchFilterPredictive(field: 'NumeroEconomico'),
      const SearchFilterPredictive(field: 'NumeroSerie'),
      const SearchFilterPredictive(field: 'UnidadTipoName'),
    ];

    final Predictive varArgs = Predictive(
      search          : query,
      searchFilters   : lstSearchFilters,
      filters         : const {},
      columns         : const {},
      dateFilters     : const DateFilter(dateStart: '', dateEnd: ''),
    );

    BlocProvider.of<RemoteUnidadBloc>(context).add(PredictiveUnidades(varArgs));
  }

  void _handleUnidadEOSSearchSubmitted(String query) {
    if (!Globals.isValidStringValue(query)) { return; }

    final List<SearchFilterPredictive> lstSearchFilters = [
      const SearchFilterPredictive(field: 'NumeroEconomico'),
      const SearchFilterPredictive(field: 'NumeroSerie'),
      const SearchFilterPredictive(field: 'UnidadTipoName'),
    ];

    final Predictive varArgs = Predictive(
      search          : query,
      searchFilters   : lstSearchFilters,
      filters         : const {},
      columns         : const {},
      dateFilters     : const DateFilter(dateStart: '', dateEnd: ''),
    );

    BlocProvider.of<RemoteUnidadEOSBloc>(context).add(PredictiveEOSUnidades(varArgs));
  }

  void _handleSelectedUnidad(UnidadPredictiveListEntity? value) {
    setState(() {
      _selectedUnidad = value;
      _updateFormFieldsUnidad(value);
    });
  }

  void _handleSelectedUnidadEOS(UnidadEOSPredictiveListEntity? value) {
    setState(() {
      _selectedUnidadEOS = value;
      _updateFormFieldsUnidadEOS(value);
    });
  }

  void _handleStorePressed() {
    if (_fechaProgramadaController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text($strings.alertWarningInvalidFormTitle, style: $styles.textStyles.bodyBold),
              const Text('Ingresa la fecha programada de inspección', softWrap: true),
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

    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text($strings.alertWarningInvalidFormTitle, style: $styles.textStyles.bodyBold),
              const Text('Por favor, revisa los campos del formulario', softWrap: true),
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

    _formKey.currentState!.save();
    _store();
  }

  Future<void> _showServerFailedDialog(BuildContext context, String? errorMessage) async {
    return showDialog<void>(
      context : context,
      builder: (BuildContext context)  => ServerFailedDialog(
        errorMessage: errorMessage ?? 'Se produjo un error inesperado. Intenta de nuevo guardar la inspección.',
      ),
    );
  }

  // METHODS
  Future<void> _create() async {
    context.read<RemoteInspeccionBloc>().add(FetchInspeccionCreate());
  }

  Future<void> _store() async {
    final InspeccionStoreReqEntity objPost = InspeccionStoreReqEntity(
      fechaProgramada             : DateFormat('dd/MM/yyy HH:mm').parse(_fechaProgramadaController.text),
      idInspeccionTipo            : _selectInspeccionTipo?.idInspeccionTipo   ?? '',
      inspeccionTipoCodigo        : _selectInspeccionTipo?.codigo             ?? '',
      inspeccionTipoName          : _selectInspeccionTipo?.name               ?? '',
      idBase                      : _selectedUnidad?.idBase ?? _selectedUnidadEOS?.idBase ?? '',
      baseName                    : _unidadBaseNameController.text,
      idUnidad                    : _selectedUnidad?.idUnidad ?? _selectedUnidadEOS?.idUnidad ?? '',
      unidadNumeroEconomico       : _unidadNumeroEconomicoController.text,
      isUnidadTemporal            : _inspeccionUnidadSelectOption == InspeccionUnidadSelectOption.temporal,
      idUnidadTipo                : _selectedUnidad?.idUnidadTipo ?? _selectedUnidadEOS?.idUnidadTipo ?? '',
      unidadTipoName              : _unidadTipoNameController.text,
      idUnidadMarca               : _selectedUnidad?.idUnidadMarca ?? _selectedUnidadEOS?.idUnidadMarca ?? '',
      unidadMarcaName             : _unidadMarcaNameController.text,
      idUnidadPlacaTipo           : _selectedUnidad?.idUnidadPlacaTipo ?? _selectedUnidadEOS?.idUnidadPlacaTipo ?? '',
      unidadPlacaTipoName         : _unidadPlacaTipoNameController.text,
      placa                       : _unidadPlacaController.text,
      numeroSerie                 : _unidadNumeroSerieController.text,
      modelo                      : _unidadModeloController.text,
      anioEquipo                  : _unidadAnioEquipoController.text,
      capacidad                   : double.tryParse(_unidadCapacidadController.text) ?? 0.000,
      idUnidadCapacidadMedida     : _selectUnidadCapacidadMedida?.idUnidadCapacidadMedida   ?? '',
      unidadCapacidadMedidaName   : _selectUnidadCapacidadMedida?.name                      ?? '',
      locacion                    : _locacionController.text,
      tipoPlataforma              : _unidadTipoPlataformaController.text,
      odometro                    : int.tryParse(_unidadOdometroController.text) ?? 0,
      horometro                   : int.tryParse(_unidadHorometroController.text) ?? 0,
    );

    BlocProvider.of<RemoteInspeccionBloc>(context).add(StoreInspeccion(objPost));
  }

  void _updateFormFieldsUnidad(UnidadPredictiveListEntity? value) {
    _unidadNumeroEconomicoController.text      = value?.numeroEconomico     ?? '';
    _unidadTipoNameController.text             = value?.unidadTipoName      ?? '';
    _unidadMarcaNameController.text            = value?.unidadMarcaName     ?? '';
    _unidadModeloController.text               = value?.modelo              ?? '';
    _unidadPlacaTipoNameController.text        = value?.unidadPlacaTipoName ?? '';
    _unidadPlacaController.text                = value?.placa               ?? '';
    _unidadNumeroSerieController.text          = value?.numeroSerie         ?? '';
    _unidadAnioEquipoController.text           = value?.anioEquipo          ?? '';
    _unidadBaseNameController.text             = value?.baseName            ?? '';
    _unidadCapacidadController.text            = value?.capacidad           ?? '';
    _unidadOdometroController.text             = value?.odometro            ?? '';
    _unidadHorometroController.text            = value?.horometro           ?? '';
  }

  void _updateFormFieldsUnidadEOS(UnidadEOSPredictiveListEntity? value) {
    _unidadNumeroEconomicoController.text      = value?.numeroEconomico     ?? '';
    _unidadTipoNameController.text             = value?.unidadTipoName      ?? '';
    _unidadMarcaNameController.text            = value?.unidadMarcaName     ?? '';
    _unidadModeloController.text               = value?.modelo              ?? '';
    _unidadPlacaTipoNameController.text        = value?.unidadPlacaTipoName ?? '';
    _unidadPlacaController.text                = value?.placa               ?? '';
    _unidadNumeroSerieController.text          = value?.numeroSerie         ?? '';
    _unidadAnioEquipoController.text           = value?.anioFabricacion     ?? '';
    _unidadBaseNameController.text             = value?.baseName            ?? '';
    _unidadCapacidadController.text            = '0.000';
    _unidadOdometroController.text             = '0';
    _unidadHorometroController.text            = '0';
  }

  void _clearFormFields() {
    _unidadNumeroEconomicoController.clear();
    _unidadTipoNameController.clear();
    _unidadMarcaNameController.clear();
    _unidadModeloController.clear();
    _unidadPlacaTipoNameController.clear();
    _unidadPlacaController.clear();
    _unidadNumeroSerieController.clear();
    _unidadAnioEquipoController.clear();
    _unidadBaseNameController.clear();
    _unidadCapacidadController.clear();
    _unidadOdometroController.clear();
    _unidadHorometroController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) => !didPop ? _handleDidPopPressed(context) : null,
      child: Scaffold(
        appBar: AppBar(title: Text($strings.inspeccionCreateAppBarTitle, style: $styles.textStyles.h3)),
        body: BlocConsumer<RemoteInspeccionBloc, RemoteInspeccionState>(
          listener: (BuildContext context, RemoteInspeccionState state) {
            // SUCCESS
            if (state is RemoteInspeccionCreateLoaded) {
              setState(() {
                // LISTAS DE COMBOBOX
                lstInspeccionesTipos            = state.objResponse?.inspeccionesTipos          ?? [];
                lstUnidadesCapacidadesMedidas   = state.objResponse?.unidadesCapacidadesMedidas ?? [];
              });
            }
          },
          builder: (BuildContext context, RemoteInspeccionState state) {
            // LOADING
            if (state is RemoteInspeccionCreateLoading) {
              return const Center(child: AppLoadingIndicator());
            }

            // ERROR
            if (state is RemoteInspeccionServerFailedMessageCreate) {
              return ErrorInfoContainer(onPressed: _create, errorMessage: state.errorMessage);
            }

            if (state is RemoteInspeccionServerFailureCreate) {
              return ErrorInfoContainer(onPressed: _create, errorMessage: state.failure?.errorMessage);
            }

            // SUCCESS
            if (state is RemoteInspeccionCreateLoaded) {
              return SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all($styles.insets.sm).copyWith(bottom: $styles.insets.lg),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        // ALTERNAR ENTRE UNIDAD INVENTARIO / UNIDAD TEMPORAL
                        _buildInspeccionUnidadSelector(),

                        // SECCION DE SUGERENCIA
                        RichText(
                          text: TextSpan(
                            style: $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.onBackground),
                            children: <TextSpan>[
                              TextSpan(text: $strings.settingsSuggestionsText, style: const TextStyle(fontWeight: FontWeight.w600)),
                              TextSpan(text: ': ${$strings.inspeccionCreateSuggestion}'),
                            ],
                          ),
                        ),

                        Gap($styles.insets.xs),

                        // BUSCADOR PREDICTIVO DE UNIDADES
                        _buildUnidadSearchPredictive(context),

                        // NUEVA UNIDAD TEMPORAL
                        AnimatedSwitcher(
                          duration: $styles.times.medium,
                          transitionBuilder: (Widget child, Animation<double> animation) {
                            return FadeTransition(opacity: animation, child: SizeTransition(sizeFactor: animation, child: child));
                          },
                          child: _inspeccionUnidadSelectOption == InspeccionUnidadSelectOption.temporal
                              ? Padding(
                                  padding: EdgeInsets.only(top: $styles.insets.sm),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      FilledButton.icon(
                                        onPressed : () => _handleCreateUnidadPressed(context),
                                        icon      : const Icon(Icons.add),
                                        label     : Text('Nueva unidad', style: $styles.textStyles.button),
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ),

                        Gap($styles.insets.sm),

                        // CAMPO: FECHA PROGRAMADA
                        LabeledDateTimeTextFormField(
                          controller  : _fechaProgramadaController,
                          hintText    : 'dd/mm/aaaa hh:mm',
                          label       : '* Fecha programada de inspección:',
                        ),

                        Gap($styles.insets.sm),

                        // CAMPO DE TEXTO: UNIDAD NUMERO ECONOMICO
                        LabeledTextFormField(
                          controller  : _unidadNumeroEconomicoController,
                          isReadOnly  : true,
                          isEnabled   : false,
                          label       : '* Número económico:',
                          validator   : FormValidators.textValidator,
                        ),

                        Gap($styles.insets.sm),

                        // CAMPO DE TEXTO: UNIDAD TIPO
                        LabeledTextFormField(
                          controller  : _unidadTipoNameController,
                          isReadOnly  : true,
                          isEnabled   : false,
                          label       : '* Tipo de unidad:',
                          validator   : FormValidators.textValidator,
                        ),

                        Gap($styles.insets.sm),

                        // SELECT: TIPO DE INSPECCION
                        LabeledDropdownFormField<InspeccionTipoEntity>(
                          items       : lstInspeccionesTipos,
                          itemBuilder : (item) => Text(item.name),
                          label       : '* Tipo de inspección:',
                          onChanged   : (value) => setState(() => _selectInspeccionTipo = value),
                          validator   : FormValidators.dropdownValidator,
                          value       : _selectInspeccionTipo,
                        ),

                        Gap($styles.insets.sm),

                        // CAMPOS DE TEXTO: UNIDAD MARCA / MODELO
                         Row(
                          children: <Widget>[
                            Expanded(
                              child: LabeledTextFormField(
                                controller  : _unidadMarcaNameController,
                                isReadOnly  : true,
                                isEnabled   : false,
                                label       : 'Marca:',
                              ),
                            ),
                            Gap($styles.insets.sm),
                            Expanded(
                              child: LabeledTextFormField(
                                controller  : _unidadModeloController,
                                isReadOnly  : true,
                                isEnabled   : false,
                                label       : 'Modelo:',
                              ),
                            ),
                          ],
                        ),

                        Gap($styles.insets.sm),

                        // CAMPOS DE TEXTO: UNIDAD PLACA TIPO / PLACA
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: LabeledTextFormField(
                                controller  : _unidadPlacaTipoNameController,
                                isReadOnly  : true,
                                isEnabled   : false,
                                label       : 'Tipo de placa:',
                              ),
                            ),
                            Gap($styles.insets.sm),
                            Expanded(
                              child: LabeledTextFormField(
                                controller  : _unidadPlacaController,
                                isReadOnly  : true,
                                isEnabled   : false,
                                label       : 'Placa:',
                              ),
                            ),
                          ],
                        ),

                        Gap($styles.insets.sm),

                        // CAMPOS DE TEXTO: NUMERO DE SERIE / AÑO DEL EQUIPO
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: LabeledTextFormField(
                                controller  : _unidadNumeroSerieController,
                                isReadOnly  : true,
                                isEnabled   : false,
                                label       : 'Número de serie:',
                              ),
                            ),
                            Gap($styles.insets.sm),
                            Expanded(
                              child: LabeledTextFormField(
                                controller  : _unidadAnioEquipoController,
                                isReadOnly  : true,
                                isEnabled   : false,
                                label       : 'Año del equipo:',
                              ),
                            ),
                          ],
                        ),

                        Gap($styles.insets.sm),

                        // CAMPO DE TEXTO: UNIDAD BASE
                        LabeledTextFormField(
                          controller  : _unidadBaseNameController,
                          isReadOnly  : true,
                          isEnabled   : false,
                          label       : '* Base:',
                          validator   : FormValidators.textValidator,
                        ),

                        Gap($styles.insets.sm),

                        // CAMPO DE TEXTO: LOCACIÓN DE INSPECCION
                        LabeledTextareaFormField(
                          controller    : _locacionController,
                          hintText      : 'Ingresa el lugar de inspección...',
                          labelText     : '* Locación:',
                          maxLines      : 3,
                          maxCharacters : 300,
                          validator     : FormValidators.textValidator,
                        ),

                        Gap($styles.insets.sm),

                        // CAMPO DE TEXTO: TIPO DE PLATAFORMA (SI APLICA)
                        LabeledTextFormField(
                          controller  : _unidadTipoPlataformaController,
                          hintText    : 'Ingresa el tipo de plataforma',
                          label       : 'Tipo de plataforma (Si aplica):',
                        ),

                        Gap($styles.insets.sm),

                        // CAMPO DE TEXTO Y SELECT:  UNIDAD CAPACIDAD / CAPACIDAD MEDIDA
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: LabeledTextFormField(
                                controller    : _unidadCapacidadController,
                                hintText      : 'Ingresa cantidad',
                                keyboardType  : TextInputType.number,
                                label         : '* Capacidad:',
                                validator     : FormValidators.decimalValidator,
                              ),
                            ),
                            Gap($styles.insets.sm),
                            Expanded(
                              child: LabeledDropdownFormField<UnidadCapacidadMedida>(
                                items       : lstUnidadesCapacidadesMedidas,
                                itemBuilder : (item) => Text(item.name ?? ''),
                                label       : '* Capacidad medida:',
                                onChanged   : (value) => setState(() => _selectUnidadCapacidadMedida = value),
                                validator   : FormValidators.dropdownValidator,
                                value       : _selectUnidadCapacidadMedida,
                              ),
                            ),
                          ],
                        ),

                        Gap($styles.insets.sm),

                        // CAMPOS DE TEXTO: ODOMETRO / HOROMETRO
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: LabeledTextFormField(
                                controller    : _unidadOdometroController,
                                hintText      : 'Ingresa cantidad',
                                keyboardType  : TextInputType.number,
                                label         : 'Odómetro (Si aplica):',
                                validator     : FormValidators.integerValidator,
                              ),
                            ),
                            Gap($styles.insets.sm),
                            Expanded(
                              child: LabeledTextFormField(
                                controller    : _unidadHorometroController,
                                hintText      : 'Ingresa cantidad',
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

  Widget _buildInspeccionUnidadSelector() {
    final bool isSelected = _inspeccionUnidadSelectOption == InspeccionUnidadSelectOption.temporal;
    return GestureDetector(
      onTap: () => _onChangeSelectOption(!isSelected),
      child: Row(
        children: <Widget>[
          Checkbox(value: isSelected, onChanged : _onChangeSelectOption),
          Text(
            isSelected
                ? 'Buscador de unidades inventario'
                : 'Buscador de unidades temporales',
            style: $styles.textStyles.body,
          ),
        ],
      ),
    );
  }

  Widget _buildUnidadSearchPredictive(BuildContext context) {
    return _inspeccionUnidadSelectOption == InspeccionUnidadSelectOption.inventario
        ? _buildUnidadEOSSearch(context)
        : _buildUnidadSearch(context);
  }

  // BUSCADOR PREDICTIVO DE UNIDADES TEMPORALES
  Widget _buildUnidadSearch(BuildContext context) {
    return Column(
      children: <Widget>[
        BlocListener<RemoteUnidadBloc, RemoteUnidadState>(
          listener: (context, state) {
            // LOADING
            if (state is RemoteUnidadPredictiveLoading) {
              setState(() {
                _isLoading = true;
              });
            }

            // ERROR
            if (state is RemoteUnidadServerFailedMessagePredictive) {
              setState(() {
                _hasServerError = true;
                _isLoading      = false;
                _errorMessage   = state.errorMessage ?? 'Error inesperado';
              });
            }

            if (state is RemoteUnidadServerFailurePredictive) {
              setState(() {
                _hasServerError = true;
                _isLoading      = false;
                _errorMessage   = state.failure?.errorMessage ?? 'Error inesperado';
              });
            }

            // SUCCESS
            if (state is RemoteUnidadPredictiveLoaded) {
              setState(() {
                _isLoading      = false;
                _hasServerError = false;

                lstUnidades = state.objResponse ?? [];
              });
            }
          },
          child: _SearchUnidad(
            lstRows       : lstUnidades,
            onSubmit      : _handleUnidadSearchSubmitted,
            onSelected    : _handleSelectedUnidad,
            onClearField  : _clearFormFields,
            boolSearch    : _isLoading,
          ),
        ),
      ],
    );
  }

  // BUSCADOR PREDICTIVO DE UNIDADES DE INVENTARIO
  Widget _buildUnidadEOSSearch(BuildContext context) {
    return Column(
      children: <Widget>[
        BlocListener<RemoteUnidadEOSBloc, RemoteUnidadEOSState>(
          listener: (context, state) {
            // LOADING
            if (state is RemoteUnidadEOSPredictiveLoading) {
              setState(() {
                _isLoading = true;
              });
            }

            // ERROR
            if (state is RemoteUnidadEOSServerFailedMessagePredictive) {
              setState(() {
                _hasServerError = true;
                _isLoading      = false;
                _errorMessage   = state.errorMessage ?? 'Error inesperado';
              });
            }

            if (state is RemoteUnidadEOSServerFailurePredictive) {
              setState(() {
                _hasServerError = true;
                _isLoading      = false;
                _errorMessage   = state.failure?.errorMessage ?? 'Error inesperado';
              });
            }

            // SUCCESS
            if (state is RemoteUnidadEOSPredictiveLoaded) {
              setState(() {
                _isLoading      = false;
                _hasServerError = false;

                lstUnidadesEOS = state.objResponse ?? [];
              });
            }
          },
          child: _SearchUnidadEOS(
            lstRows       : lstUnidadesEOS,
            onSubmit      : _handleUnidadEOSSearchSubmitted,
            onSelected    : _handleSelectedUnidadEOS,
            onClearField  : _clearFormFields,
            boolSearch    : _isLoading,
          ),
        ),
      ],
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
          BlocConsumer<RemoteInspeccionBloc, RemoteInspeccionState>(
            listener: (BuildContext context, RemoteInspeccionState state) {
              if (state is RemoteInspeccionServerFailedMessageStore) {
                _showServerFailedDialog(context, state.errorMessage);
              }

              if (state is RemoteInspeccionServerFailureStore) {
                _showServerFailedDialog(context, state.failure?.errorMessage);
              }

              if (state is RemoteInspeccionStoreSuccess) {
                Navigator.of(context).pop();

                ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content         : Text(state.objResponse?.message ?? 'Nueva inspección', softWrap: true),
                    backgroundColor : Colors.green,
                    elevation       : 0,
                    behavior        : SnackBarBehavior.fixed,
                  ),
                );

                // Ejecutar callback.
                widget.onFinish!();
              }
            },
            builder: (BuildContext context, RemoteInspeccionState state) {
              if (state is RemoteInspeccionStoreLoading) {
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
