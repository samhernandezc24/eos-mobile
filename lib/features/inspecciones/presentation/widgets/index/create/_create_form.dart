part of '../../../pages/index/index_page.dart';

/// La opción de la unidad a inspeccionar el cual se selecciona desde la UI.
enum InspeccionUnidadSelectOption {
  /// Selecciona las unidades de inventario.
  inventario,
  /// Selecciona las unidades temporales.
  temporal,
}

class _CreateInspeccionForm extends StatefulWidget {
  const _CreateInspeccionForm({Key? key}) : super(key: key);

  @override
  State<_CreateInspeccionForm> createState() => _CreateInspeccionFormState();
}

class _CreateInspeccionFormState extends State<_CreateInspeccionForm> {
  // GLOBAL KEY
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // CONTROLLERS
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

  // PROPERTIES
  InspeccionUnidadSelectOption _inspeccionUnidadSelectOption = InspeccionUnidadSelectOption.inventario;

  InspeccionTipoEntity? _selectInspeccionTipo;
  UnidadCapacidadMedida? _selectUnidadCapacidadMedida;

  // STATE
  @override
  void initState() {
    super.initState();
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

  void _handleRefreshPressed() {
    _create();
  }

  void _handleCreateUnidadPressed(BuildContext context) {
    Navigator.push<void>(
      context,
      AppModalRoute(
        child: _CreateInspeccionUnidadForm(),
      ),
    );
  }

  void _handleStorePressed() {
    if (_fechaProgramadaController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(AppStrings.errorAlertWarningTitle, style: $styles.textStyles.bodyBold),
              const Text('Ingresa la fecha programada de inspección', softWrap: true),
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

  // METHODS
  Future<void> _create() async {
    context.read<RemoteInspeccionBloc>().add(CreateInspeccion());
  }

  Future<void> _store() async {
    final InspeccionStoreReqEntity objPost = InspeccionStoreReqEntity(
      fechaProgramada           : DateFormat('dd/MM/yyyy HH:mm').parse(_fechaProgramadaController.text),
      idInspeccionTipo          : '',
      inspeccionTipoCodigo      : '',
      inspeccionTipoName        : '',
      idBase                    : '',
      baseName                  : _unidadBaseNameController.text,
      idUnidad                  : '',
      unidadNumeroEconomico     : _unidadNumeroEconomicoController.text,
      isUnidadTemporal          : _inspeccionUnidadSelectOption == InspeccionUnidadSelectOption.temporal,
      idUnidadTipo              : '',
      unidadTipoName            : '',
      idUnidadMarca             : '',
      unidadMarcaName           : '',
      idUnidadPlacaTipo         : '',
      unidadPlacaTipoName       : _unidadPlacaTipoNameController.text,
      placa                     : _unidadPlacaController.text,
      numeroSerie               : _unidadNumeroSerieController.text,
      modelo                    : _unidadModeloController.text,
      anioEquipo                : _unidadAnioEquipoController.text,
      capacidad                 : double.tryParse(_unidadCapacidadController.text) ?? 0.000,
      idUnidadCapacidadMedida   : '',
      unidadCapacidadMedidaName : '',
      locacion                  : _locacionController.text,
      tipoPlataforma            : _unidadTipoPlataformaController.text,
      odometro                  : int.tryParse(_unidadOdometroController.text)  ?? 0,
      horometro                 : int.tryParse(_unidadHorometroController.text) ?? 0,
    );

    print(objPost);

    // context.read<RemoteInspeccionBloc>().add(StoreInspeccion(objPost));
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
                      hintText      : 'Ingresa el lugar de inspección...',
                      label         : '* Locación:',
                      maxLines      : 3,
                      maxCharacters : 300,
                      validator     : FormValidators.textValidator,
                    ),

                    Gap($styles.insets.sm),

                    // CAMPO: UNIDAD TIPO PLATAFORMA (SI APLICA)
                    LabeledTextFormField(
                      controller  : _unidadTipoPlataformaController,
                      hintText    : 'Ingresa tipo de plataforma',
                      label       : 'Tipo de plataforma (Si aplica):',
                    ),

                    Gap($styles.insets.sm),

                    // CAMPOS: UNIDAD CAPACIDAD / CAPACIDAD MEDIDA
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: LabeledTextFormField(
                            controller    : _unidadCapacidadController,
                            hintText      : 'Ingresa cantidad',
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
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.inspeccionCreateAppBarTitle, style: $styles.textStyles.h3)),
      body: BlocConsumer<RemoteInspeccionBloc, RemoteInspeccionState>(
        listener: (BuildContext context, RemoteInspeccionState state) {
          // SUCCESS
          if (state is RemoteInspeccionCreate) {
            setState(() {
              // LISTAS DE COMBOBOX
              lstInspeccionesTipos            = state.objResponse?.inspeccionesTipos            ?? [];
              lstUnidadesCapacidadesMedidas   = state.objResponse?.unidadesCapacidadesMedidas   ?? [];
            });
          }
        },
        builder: (BuildContext context, RemoteInspeccionState state) {
          // LOADING
          if (state is RemoteInspeccionCreateLoading) {
            return const Center(child: AppLoadingIndicator());
          }

          // ERROR

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
    return _SearchUnidadEOSInput(onSubmit: (_){});
  }

  // BUSCADOR PREDICTIVO DE UNIDADES TEMPORALES
  Widget _buildUnidadSearch(BuildContext context) {
    return _SearchUnidadInput(onSubmit: (_){});
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
          FilledButton(
            onPressed : _handleStorePressed,
            child     : Text(AppStrings.btnSaveText, style: $styles.textStyles.button),
          ),
        ],
      ),
    );
  }
}
