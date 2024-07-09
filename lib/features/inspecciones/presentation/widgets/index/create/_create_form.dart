part of '../../../pages/index/index_page.dart';

/// La opción de la unidad a inspeccionar el cual se selecciona desde la UI.
enum InspeccionUnidadSelectOption {
  /// Selecciona las unidades de inventario.
  inventario,
  /// Selecciona las unidades temporales.
  temporal,
}

class _CreateInspeccionForm extends StatefulWidget {
  const _CreateInspeccionForm({Key? key, this.onComplete}) : super(key: key);

  final VoidCallback? onComplete;

  @override
  State<_CreateInspeccionForm> createState() => _CreateInspeccionFormState();
}

class _CreateInspeccionFormState extends State<_CreateInspeccionForm> {
  // GLOBAL KEY
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // CONTROLLERS
  late TextEditingController _searchUnidadController;
  late TextEditingController _searchUnidadEOSController;
  late TextEditingController _fechaProgramadaController;
  late TextEditingController _unidadBaseNameController;
  late TextEditingController _unidadNumeroEconomicoController;
  late TextEditingController _unidadTipoNameController;
  late TextEditingController _unidadMarcaNameController;
  late TextEditingController _unidadPlacaTipoNameController;
  late TextEditingController _unidadPlacaController;
  late TextEditingController _unidadNumeroSerieController;
  late TextEditingController _unidadModeloController;
  late TextEditingController _unidadAnioEquipoController;
  late TextEditingController _unidadCapacidadController;
  late TextEditingController _unidadTipoPlataformaController;
  late TextEditingController _unidadOdometroController;
  late TextEditingController _unidadHorometroController;
  late TextEditingController _locacionController;

  // LIST
  List<InspeccionTipoEntity> lstInspeccionesTipos             = [];
  List<UnidadCapacidadMedida> lstUnidadesCapacidadesMedidas   = [];
  List<UnidadPredictiveEntity> lstUnidades                    = [];
  List<UnidadEOSPredictiveEntity> lstUnidadesEOS              = [];

  // PROPERTIES
  InspeccionUnidadSelectOption _inspeccionUnidadSelectOption = InspeccionUnidadSelectOption.inventario;

  bool _isLoading       = false;
  bool _hasServerError  = false;

  InspeccionTipoEntity? _selectInspeccionTipo;
  UnidadCapacidadMedida? _selectUnidadCapacidadMedida;
  UnidadPredictiveEntity? _selectUnidad;
  UnidadEOSPredictiveEntity? _selectUnidadEOS;

  // STATE
  @override
  void initState() {
    super.initState();
    _searchUnidadController           = TextEditingController();
    _searchUnidadEOSController        = TextEditingController();
    _fechaProgramadaController        = TextEditingController();
    _unidadBaseNameController         = TextEditingController();
    _unidadNumeroEconomicoController  = TextEditingController();
    _unidadTipoNameController         = TextEditingController();
    _unidadMarcaNameController        = TextEditingController();
    _unidadPlacaTipoNameController    = TextEditingController();
    _unidadPlacaController            = TextEditingController();
    _unidadNumeroSerieController      = TextEditingController();
    _unidadModeloController           = TextEditingController();
    _unidadAnioEquipoController       = TextEditingController();
    _unidadCapacidadController        = TextEditingController();
    _unidadTipoPlataformaController   = TextEditingController();
    _unidadOdometroController         = TextEditingController();
    _unidadHorometroController        = TextEditingController();
    _locacionController               = TextEditingController();

    _create();
  }

  @override
  void dispose() {
    _searchUnidadController.dispose();
    _searchUnidadEOSController.dispose();
    _fechaProgramadaController.dispose();
    _unidadBaseNameController.dispose();
    _unidadNumeroEconomicoController.dispose();
    _unidadTipoNameController.dispose();
    _unidadMarcaNameController.dispose();
    _unidadPlacaTipoNameController.dispose();
    _unidadPlacaController.dispose();
    _unidadNumeroSerieController.dispose();
    _unidadModeloController.dispose();
    _unidadAnioEquipoController.dispose();
    _unidadCapacidadController.dispose();
    _unidadTipoPlataformaController.dispose();
    _unidadOdometroController.dispose();
    _unidadHorometroController.dispose();
    _locacionController.dispose();
    super.dispose();
  }

  // EVENTS
  void _selectOptionChange(bool? value) {
    setState(() {
      _inspeccionUnidadSelectOption = value ?? false
          ? InspeccionUnidadSelectOption.temporal
          : InspeccionUnidadSelectOption.inventario;
    });
  }

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
                Navigator.of(context).pop();    // Cerrar dialog
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  Navigator.of(context).pop();  // Cerrar página
                  widget.onComplete!();         // Ejecutar callback
                });
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

  void _handleCreateUnidadPressed(BuildContext context) {
    Navigator.push<void>(
      context,
      AppModalRoute(
        child: const _CreateInspeccionUnidadForm(),
      ),
    );
  }

  void _handleUnidadSearchSubmitted(String query) {
    if (!Globals.isValidStringValue(query)) return;

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

    context.read<RemoteUnidadBloc>().add(PredictiveUnidades(varArgs));
  }

  void _handleUnidadEOSSearchSubmitted(String query) {
    if (!Globals.isValidStringValue(query)) return;

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

    context.read<RemoteUnidadEOSBloc>().add(PredictiveUnidadesEOS(varArgs));
  }

  void _handleSelectUnidad(UnidadPredictiveEntity? value) {
    setState(() {
      _selectUnidad = value;
      _updateUnidadFormFields(value);
    });
  }

  void _handleSelectUnidadEOS(UnidadEOSPredictiveEntity? value) {
    setState(() {
      _selectUnidadEOS = value;
      _updateUnidadEOSFormFields(value);
    });
  }

  void _handleStorePressed() {
    if (_fechaProgramadaController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(AppStrings.errorAlertWarningTitle, style: $styles.textStyles.bodyBold),
              const Text('Ingrese la fecha programada de inspección', softWrap: true),
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
    context.read<RemoteInspeccionBloc>().add(CreateInspeccion());
  }

  Future<void> _store() async {
    final InspeccionStoreReqEntity objPost = InspeccionStoreReqEntity(
      fechaProgramada           : DateFormat('dd/MM/yyyy HH:mm').parse(_fechaProgramadaController.text),
      idInspeccionTipo          : _selectInspeccionTipo?.idInspeccionTipo   ?? '',
      inspeccionTipoCodigo      : _selectInspeccionTipo?.codigo             ?? '',
      inspeccionTipoName        : _selectInspeccionTipo?.name               ?? '',
      idBase                    : _selectUnidad?.idBase ?? _selectUnidadEOS?.idBase ?? '',
      baseName                  : _unidadBaseNameController.text,
      idUnidad                  : _selectUnidad?.idUnidad ?? _selectUnidadEOS?.idUnidad ?? '',
      unidadNumeroEconomico     : _unidadNumeroEconomicoController.text,
      isUnidadTemporal          : _inspeccionUnidadSelectOption == InspeccionUnidadSelectOption.temporal,
      idUnidadTipo              : _selectUnidad?.idUnidadTipo ?? _selectUnidadEOS?.idUnidadTipo ?? '',
      unidadTipoName            : _selectUnidad?.unidadTipoName ?? _selectUnidadEOS?.unidadTipoName ?? '',
      idUnidadMarca             : _selectUnidad?.idUnidadMarca ?? _selectUnidadEOS?.idUnidadMarca ?? '',
      unidadMarcaName           : _selectUnidad?.unidadMarcaName ?? _selectUnidadEOS?.unidadMarcaName ?? '',
      idUnidadPlacaTipo         : _selectUnidad?.idUnidadPlacaTipo ?? _selectUnidadEOS?.idUnidadPlacaTipo ?? '',
      unidadPlacaTipoName       : _unidadPlacaTipoNameController.text,
      placa                     : _unidadPlacaController.text,
      numeroSerie               : _unidadNumeroSerieController.text,
      modelo                    : _unidadModeloController.text,
      anioEquipo                : _unidadAnioEquipoController.text,
      capacidad                 : double.tryParse(_unidadCapacidadController.text) ?? 0.000,
      idUnidadCapacidadMedida   : _selectUnidadCapacidadMedida?.idUnidadCapacidadMedida ?? '',
      unidadCapacidadMedidaName : _selectUnidadCapacidadMedida?.name ?? '',
      locacion                  : _locacionController.text,
      tipoPlataforma            : _unidadTipoPlataformaController.text,
      odometro                  : int.tryParse(_unidadOdometroController.text)  ?? 0,
      horometro                 : int.tryParse(_unidadHorometroController.text) ?? 0,
    );

    context.read<RemoteInspeccionBloc>().add(StoreInspeccion(objPost));
  }

  void _updateUnidadFormFields(UnidadPredictiveEntity? value) {
    setState(() {
      _unidadBaseNameController.text         = value?.baseName              ?? '';
      _unidadNumeroEconomicoController.text  = value?.numeroEconomico       ?? '';
      _unidadTipoNameController.text         = value?.unidadTipoName        ?? '';
      _unidadMarcaNameController.text        = value?.unidadMarcaName       ?? '';
      _unidadPlacaTipoNameController.text    = value?.unidadPlacaTipoName   ?? '';
      _unidadPlacaController.text            = value?.placa                 ?? '';
      _unidadNumeroSerieController.text      = value?.numeroSerie           ?? '';
      _unidadModeloController.text           = value?.modelo                ?? '';
      _unidadAnioEquipoController.text       = value?.anioEquipo            ?? '';
      _unidadCapacidadController.text        = value?.capacidad             ?? '';
      _unidadOdometroController.text         = value?.odometro              ?? '';
      _unidadHorometroController.text        = value?.horometro             ?? '';

      _selectUnidadCapacidadMedida = lstUnidadesCapacidadesMedidas.firstWhereOrNull((item) =>
        item.idUnidadCapacidadMedida == value!.idUnidadCapacidadMedida,
      );
    });
  }

  void _updateUnidadEOSFormFields(UnidadEOSPredictiveEntity? value) {
    setState(() {
      _unidadBaseNameController.text         = value?.baseName              ?? '';
      _unidadNumeroEconomicoController.text  = value?.numeroEconomico       ?? '';
      _unidadTipoNameController.text         = value?.unidadTipoName        ?? '';
      _unidadMarcaNameController.text        = value?.unidadMarcaName       ?? '';
      _unidadPlacaTipoNameController.text    = value?.unidadPlacaTipoName   ?? '';
      _unidadPlacaController.text            = value?.placa                 ?? '';
      _unidadNumeroSerieController.text      = value?.numeroSerie           ?? '';
      _unidadModeloController.text           = value?.modelo                ?? '';
      _unidadAnioEquipoController.text       = value?.anioFabricacion       ?? '';
      _unidadCapacidadController.text        = '0.000';
      _unidadOdometroController.text         = '0';
      _unidadHorometroController.text        = '0';

      _selectUnidadCapacidadMedida = lstUnidadesCapacidadesMedidas.firstWhereOrNull((item) =>
        item.idUnidadCapacidadMedida == value!.idUnidadCapacidadMedida,
      );
    });
  }

  void _clearFormFields() {
    setState(() {
      _unidadBaseNameController.clear();
      _unidadNumeroEconomicoController.clear();
      _unidadTipoNameController.clear();
      _unidadMarcaNameController.clear();
      _unidadPlacaTipoNameController.clear();
      _unidadPlacaController.clear();
      _unidadNumeroSerieController.clear();
      _unidadModeloController.clear();
      _unidadAnioEquipoController.clear();
      _unidadCapacidadController.clear();
      _unidadOdometroController.clear();
      _unidadHorometroController.clear();
      _selectUnidadCapacidadMedida = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Widget content = GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // ALTERNAR ENTRE UNIDAD INVENTARIO / TEMPORAL
          Container(
            color   : Theme.of(context).colorScheme.background,
            padding : EdgeInsets.zero,
            child   : _buildInspeccionUnidadSelector(),
          ),

          // CAJA DE SUGERENCIA
          Container(
            color   : Theme.of(context).colorScheme.background,
            padding : EdgeInsets.symmetric(horizontal: $styles.insets.xs * 1.5),
            child   : RichText(
              text: TextSpan(
                style: $styles.textStyles.bodySmall.copyWith(color: Theme.of(context).colorScheme.onBackground, height: 1.3),
                children: const <TextSpan>[
                  TextSpan(text: AppStrings.suggestionBoxTitle, style: TextStyle(fontWeight: FontWeight.w600)),
                  TextSpan(text: ': ${AppStrings.inspeccionCreateSuggestion}'),
                ],
              ),
            ),
          ),

          // BUSCADOR PREDICTIVO DE UNIDADES
          Container(
            color   : Theme.of(context).colorScheme.background,
            padding : EdgeInsets.fromLTRB($styles.insets.sm, $styles.insets.sm, $styles.insets.sm, $styles.insets.xs),
            child   : _buildUnidadSearchPredictive(context),
          ),

          // NUEVA UNIDAD TEMPORAL
          AnimatedSwitcher(
            duration: $styles.times.medium,
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(opacity: animation, child: SizeTransition(sizeFactor: animation, child: child));
            },
            child: _inspeccionUnidadSelectOption == InspeccionUnidadSelectOption.temporal
                ? Padding(
                    padding: EdgeInsets.fromLTRB(0, $styles.insets.xs, $styles.insets.sm, $styles.insets.xs),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FilledButton.icon(
                          onPressed : () => _handleCreateUnidadPressed(context),
                          icon      : const Icon(Icons.add),
                          label     : Text(AppStrings.btnCreateUnidadText, style: $styles.textStyles.button),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ),

          const Divider(thickness: 1.3),

          // FORMULARIO PARA CREAR LA INSPECCION
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all($styles.insets.sm).copyWith(bottom: $styles.insets.lg),
              child: Form(
                key   : _formKey,
                child : Column(
                  children: <Widget>[
                    // CAMPO: FECHA PROGRAMADA
                    LabeledDateTimeFormField(
                      controller  : _fechaProgramadaController,
                      hintText    : 'dd/mm/aaaa hh:mm',
                      label       : '* Fecha programada de inspección:',
                    ),

                    Gap($styles.insets.sm),

                    // CAMPO: UNIDAD NUMERO ECONOMICO
                    LabeledTextFormField(
                      controller  : _unidadNumeroEconomicoController,
                      isEnabled   : false,
                      label       : '* Número económico:',
                      readOnly    : true,
                      validator   : FormValidators.textValidator,
                    ),

                    Gap($styles.insets.sm),

                    // CAMPO: UNIDAD TIPO
                    LabeledTextFormField(
                      controller  : _unidadTipoNameController,
                      isEnabled   : false,
                      label       : '* Tipo de unidad:',
                      readOnly    : true,
                      validator   : FormValidators.textValidator,
                    ),

                    Gap($styles.insets.sm),

                    // CAMPO: TIPO DE INSPECCION
                    LabeledDropdownFormField<InspeccionTipoEntity>(
                      items         : lstInspeccionesTipos,
                      itemBuilder   : (item) => Text(item.name),
                      label         : '* Tipo de inspección:',
                      onChanged     : (value) => setState(() => _selectInspeccionTipo = value),
                      value         : _selectInspeccionTipo,
                      validator     : FormValidators.dropdownValidator,
                    ),

                    Gap($styles.insets.sm),

                    // CAMPOS: UNIDAD MARCA / MODELO
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: LabeledTextFormField(
                            controller  : _unidadMarcaNameController,
                            isEnabled   : false,
                            label       : 'Marca:',
                            readOnly    : true,
                          ),
                        ),
                        Gap($styles.insets.sm),
                        Expanded(
                          child: LabeledTextFormField(
                            controller  : _unidadModeloController,
                            isEnabled   : false,
                            label       : 'Modelo:',
                            readOnly    : true,
                          ),
                        ),
                      ],
                    ),

                    Gap($styles.insets.sm),

                    // CAMPOS: UNIDAD PLACA TIPO / PLACA
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: LabeledTextFormField(
                            controller  : _unidadPlacaTipoNameController,
                            isEnabled   : false,
                            label       : 'Tipo de placa:',
                            readOnly    : true,
                          ),
                        ),
                        Gap($styles.insets.sm),
                        Expanded(
                          child: LabeledTextFormField(
                            controller  : _unidadPlacaController,
                            isEnabled   : false,
                            label       : 'Placa:',
                            readOnly    : true,
                          ),
                        ),
                      ],
                    ),

                    Gap($styles.insets.sm),

                    // CAMPOS: UNIDAD NUMERO SERIE / AÑO DEL EQUIPO
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: LabeledTextFormField(
                            controller  : _unidadNumeroSerieController,
                            isEnabled   : false,
                            label       : 'Número de serie:',
                            readOnly    : true,
                          ),
                        ),
                        Gap($styles.insets.sm),
                        Expanded(
                          child: LabeledTextFormField(
                            controller  : _unidadAnioEquipoController,
                            isEnabled   : false,
                            label       : 'Año del equipo:',
                            readOnly    : true,
                          ),
                        ),
                      ],
                    ),

                    Gap($styles.insets.sm),

                    // CAMPO: UNIDAD BASE
                    LabeledTextFormField(
                      controller  : _unidadBaseNameController,
                      isEnabled   : false,
                      label       : 'Base:',
                      readOnly    : true,
                    ),

                    Gap($styles.insets.sm),

                    // CAMPO: LOCACIÓN
                    LabeledTextareaFormField(
                      controller    : _locacionController,
                      hintText      : 'Ingrese el lugar de inspección...',
                      label         : '* Locación:',
                      maxLines      : 3,
                      maxCharacters : 300,
                      validator     : FormValidators.textValidator,
                    ),

                    Gap($styles.insets.sm),

                    // CAMPO: UNIDAD TIPO PLATAFORMA (SI APLICA)
                    LabeledTextFormField(
                      controller  : _unidadTipoPlataformaController,
                      hintText    : 'Ingrese tipo de plataforma',
                      label       : 'Tipo de plataforma (Si aplica):',
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
                            items         : lstUnidadesCapacidadesMedidas,
                            itemBuilder   : (item) => Text(item.name ?? ''),
                            label         : 'Capacidad medida:',
                            onChanged     : (value) => setState(() => _selectUnidadCapacidadMedida = value),
                            value         : _selectUnidadCapacidadMedida,
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
          ),
        ],
      ),
    );

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) => !didPop ? _handleDidPopPressed(context) : null,
      child: Scaffold(
        appBar: AppBar(title: Text(AppStrings.inspeccionCreateAppBarTitle, style: $styles.textStyles.h3)),
        body: BlocConsumer<RemoteInspeccionBloc, RemoteInspeccionState>(
          listener: (BuildContext context, RemoteInspeccionState state) {
            // LOADING
            if (state is RemoteInspeccionCreateLoading) {
              setState(() {
                _isLoading = true;
              });
            }

            // SUCCESS
            if (state is RemoteInspeccionCreate) {
              setState(() {
                _hasServerError = false;
                _isLoading      = false;

                // LISTAS DE COMBOBOX
                lstInspeccionesTipos            = state.objResponse?.inspeccionesTipos            ?? [];
                lstUnidadesCapacidadesMedidas   = state.objResponse?.unidadesCapacidadesMedidas   ?? [];
              });
            }

            // ERROR
            if (state is RemoteInspeccionServerFailedMessageCreate || state is RemoteInspeccionServerExceptionMessageCreate) {
              setState(() {
                _hasServerError = true;
                _isLoading      = false;
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
              return ErrorServerMessage(message: state.error, onPressed: _handleRefreshPressed);
            }

            if (state is RemoteInspeccionServerExceptionMessageCreate) {
              return ErrorServerMessage(message: state.error?.message, onPressed: _handleRefreshPressed);
            }

            // SUCCESS
            if (state is RemoteInspeccionCreate) {
              return Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: ColoredBox(color: Theme.of(context).colorScheme.background.withOpacity(0.4), child: content),
                  ),
                ],
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
      onTap: () => _selectOptionChange(!isSelected),
      child: Row(
        children: <Widget>[
          Checkbox(value: isSelected, onChanged: _selectOptionChange),
          Text(
            isSelected ? 'Buscar unidades inventario' : 'Buscar unidades temporales',
            style     : $styles.textStyles.label,
            overflow  : TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // CONSTRUCTOR DE BUSCADORES DE UNIDADES
  Widget _buildUnidadSearchPredictive(BuildContext context) {
    return _inspeccionUnidadSelectOption == InspeccionUnidadSelectOption.inventario
        ? _buildUnidadEOSSearch(context)
        : _buildUnidadSearch(context);
  }

  // BUSCADOR PREDICTIVO DE UNIDADES INVENTARIO
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
              _showServerErrorDialog(context, state.error);

              setState(() {
                _hasServerError  = true;
                _isLoading       = false;
              });
            }

            if (state is RemoteUnidadEOSServerExceptionMessagePredictive) {
              _showServerErrorDialog(context, state.error?.message);

              setState(() {
                _hasServerError  = true;
                _isLoading       = false;
              });
            }

            // SUCCESS
            if (state is RemoteUnidadEOSPredictive) {
              setState(() {
                _hasServerError  = false;
                _isLoading       = false;

                lstUnidadesEOS = state.objResponse ?? [];
              });
            }
          },
          child: _SearchUnidadEOSInput(
            controller    : _searchUnidadEOSController,
            results       : lstUnidadesEOS,
            onSubmit      : _handleUnidadEOSSearchSubmitted,
            onSelected    : _handleSelectUnidadEOS,
            onClearField  : _clearFormFields,
            boolSearch    : _isLoading,
            boolError     : _hasServerError,
          ),
        ),
      ],
    );
  }

  // BUSCADOR PREDICTIVO DE UNIDADES TEMPORALES
  Widget _buildUnidadSearch(BuildContext context) {
    return Column(
      children: <Widget>[
        BlocListener<RemoteUnidadBloc, RemoteUnidadState>(
          listener: (BuildContext context, RemoteUnidadState state) {
            // LOADING
            if (state is RemoteUnidadPredictiveLoading) {
              setState(() {
                _isLoading = true;
              });
            }

            // ERROR
            if (state is RemoteUnidadServerFailedMessagePredictive) {
              _showServerErrorDialog(context, state.error);

              setState(() {
                _hasServerError = true;
                _isLoading      = false;
              });
            }

            if (state is RemoteUnidadServerExceptionMessagePredictive) {
              _showServerErrorDialog(context, state.error?.message);

              setState(() {
                _hasServerError = true;
                _isLoading      = false;
              });
            }

            // SUCCESS
            if (state is RemoteUnidadPredictive) {
              setState(() {
                _hasServerError = false;
                _isLoading      = false;
                lstUnidades = state.objResponse ?? [];
              });
            }
          },
          child: _SearchUnidadInput(
            controller    : _searchUnidadController,
            results       : lstUnidades,
            onSubmit      : _handleUnidadSearchSubmitted,
            onSelected    : _handleSelectUnidad,
            onClearField  : _clearFormFields,
            boolSearch    : _isLoading,
            boolError     : _hasServerError,
          ),
        ),
      ],
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
          BlocConsumer<RemoteInspeccionBloc, RemoteInspeccionState>(
            listener: (BuildContext context, RemoteInspeccionState state) {
              // ERROR
              if (state is RemoteInspeccionServerFailedMessageStore) {
                _showServerErrorDialog(context, state.error);

                _create();
              }

              if (state is RemoteInspeccionServerExceptionMessageStore) {
                _showServerErrorDialog(context, state.error?.message);

                _create();
              }

              // SUCCESS
              if (state is RemoteInspeccionStore) {
                Navigator.of(context).pop(); // Cerramos el modal

                ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(
                      state.objResponse?.message ?? 'Nueva inspección',
                      style     : $styles.textStyles.bodySmall.copyWith(color: $styles.colors.white),
                      softWrap  : true,
                    ),
                    backgroundColor : $styles.colors.success,
                    elevation       : 0,
                    behavior        : SnackBarBehavior.fixed,
                  ),
                );

                // Ejecutar callback.
                widget.onComplete!();
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
