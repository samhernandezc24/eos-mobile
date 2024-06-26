part of '../../../pages/list/list_page.dart';

class _CreateInspeccionForm extends StatefulWidget {
  const _CreateInspeccionForm({Key? key, this.buildDataSourceCallback}) : super(key: key);

  final VoidCallback? buildDataSourceCallback;

  @override
  State<_CreateInspeccionForm> createState() => _CreateInspeccionFormState();
}

class _CreateInspeccionFormState extends State<_CreateInspeccionForm> {
  // GLOBAL KEY
  final GlobalKey<FormState> _formKey   = GlobalKey<FormState>();
  final LayerLink _optionsLayerLink     = LayerLink();

  // CONTROLLERS
  late final TextEditingController _searchUnidadInventarioController;
  late final TextEditingController _searchUnidadTemporalController;

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
  late final TextEditingController _unidadCapacidadMedidaNameController;
  late final TextEditingController _unidadOdometroController;
  late final TextEditingController _unidadHorometroController;
  late final TextEditingController _locacionController;

  // PROPERTIES
  String? idUnidad = '';
  bool _userHideOptions                 = false;
  bool _floatingOptionsUpdateScheduled  = false;

  // LIST
  List<InspeccionTipoEntity> lstInspeccionesTipos             = [];
  List<UnidadCapacidadMedida> lstUnidadesCapacidadesMedidas   = [];
  List<UnidadEntity> lstUnidades                              = [];
  List<UnidadPredictiveListEntity> lstRows                    = [];

  // SELECTED
  UnidadInspeccion? _selectedSearchUnidad;
  UnidadPredictiveListEntity? _selectedUnidad;
  InspeccionTipoEntity? _selectedInspeccionTipo;

  // El OverlayEntry que contiene las opciones.
  OverlayEntry? _floatingOptions;

  // True si el estado indica que las opciones deben ser visibles.
  bool get _shouldShowOptions {
    return !_userHideOptions && lstRows.isNotEmpty;
    // return !_userHideOptions && _focusNode.hasFocus && _selection == null && _options.isNotEmpty;
  }

  // STATE
  @override
  void initState() {
    super.initState();
    _searchUnidadInventarioController     = TextEditingController();
    _searchUnidadTemporalController       = TextEditingController();
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
    _unidadCapacidadMedidaNameController  = TextEditingController();
    _unidadOdometroController             = TextEditingController();
    _unidadHorometroController            = TextEditingController();
    _locacionController                   = TextEditingController();

    _create();
  }

  @override
  void dispose() {
    _searchUnidadInventarioController.dispose();
    _searchUnidadTemporalController.dispose();
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
    _unidadCapacidadMedidaNameController.dispose();
    _unidadOdometroController.dispose();
    _unidadHorometroController.dispose();
    _locacionController.dispose();
    super.dispose();
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
              Navigator.of(context).pop();          // Cerrar dialog
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pop();        // Cerrar página
                widget.buildDataSourceCallback!();  // Ejecutar callback
              });
            },
            child: Text($strings.acceptButtonText, style: $styles.textStyles.button),
          ),
        ],
      ),
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

          return SlideTransition(position: animation.drive<Offset>(tween), child: _CreateUnidadForm(buildSearchUnidadCallback: _getUnidadesList));
        },
        fullscreenDialog: true,
      ),
    );
  }

  void _handleSearchSubmitted(String query) {
    lstRows = [];

    if (!Globals.isValidStringValue(query)) {
      return;
    }

    final List<SearchFilterPredictive> lstSearchFilters = [];

    lstSearchFilters.add(const SearchFilterPredictive(field: 'NumeroEconomico'));
    lstSearchFilters.add(const SearchFilterPredictive(field: 'NumeroSerie'));
    lstSearchFilters.add(const SearchFilterPredictive(field: 'UnidadTipoName'));

    final Predictive varArgs = Predictive(
      search            : query,
      searchFilters     : lstSearchFilters,
      filters           : const {},
      columns           : const {},
      dateFilters       : const DateFilter(dateStart: '', dateEnd: ''),
    );

    BlocProvider.of<RemoteUnidadBloc>(context).add(PredictiveUnidades(varArgs));
  }

  void _handleSelectedPressed(UnidadPredictiveListEntity event) {
    idUnidad = '';

    if (event.idUnidad == '') {
      return;
    }

    lstRows = [];

    setState(() {
      _selectedUnidad = event;
      _fillFormFields(event);
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

    if (lstInspeccionesTipos.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text($strings.alertWarningAttentionTitle, style: $styles.textStyles.bodyBold),
              const Text('No se puede guardar la nueva inspección debido a que no se selecciono el tipo de inspección', softWrap: true),
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
    } else {
      _formKey.currentState!.save();
      _store();
    }
  }

  void _updateOverlay() {
    if (SchedulerBinding.instance.schedulerPhase == SchedulerPhase.persistentCallbacks) {
      if (!_floatingOptionsUpdateScheduled) {
        _floatingOptionsUpdateScheduled = true;
        SchedulerBinding.instance.addPostFrameCallback((Duration timeStamp) {
            _floatingOptionsUpdateScheduled = false;
            _updateOverlay();
        });
      }
      return;
    }

    _floatingOptions?.remove();
    _floatingOptions?.dispose();
    if (_shouldShowOptions) {
      final OverlayEntry newFloatingOptions = OverlayEntry(
        builder: (BuildContext context) {
          return CompositedTransformFollower(
            link: _optionsLayerLink,
            showWhenUnlinked: false,
            // targetAnchor: switch (PredictiveOptionsViewOpenDirection) {
            //   PredictiveOptionsViewOpenDirection.up     => Alignment.topLeft,
            //   PredictiveOptionsViewOpenDirection.down   => Alignment.bottomLeft,
            // },
            // followerAnchor: switch (PredictiveOptionsViewOpenDirection) {
            //   PredictiveOptionsViewOpenDirection.up     => Alignment.bottomLeft,
            //   PredictiveOptionsViewOpenDirection.down   => Alignment.topLeft,
            // },
            child: Builder(
              builder: (BuildContext context) {
                return Material(
                  elevation: 3,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: lstRows.length,
                    itemBuilder: (context, index) {
                      final unidad = lstRows[index];
                      return ListTile(
                        title: Text(unidad.numeroEconomico),
                        onTap: () {
                          // Handle item tap
                          _searchUnidadTemporalController.text = unidad.numeroEconomico;
                          // _hideOverlay();
                        },
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      );
      Overlay.of(context, rootOverlay: true, debugRequiredFor: widget).insert(newFloatingOptions);
      _floatingOptions = newFloatingOptions;
    } else {
      _floatingOptions = null;
    }
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

  Future<void> _getUnidadesList() async {
    context.read<RemoteUnidadBloc>().add(ListUnidades());
  }

  Future<void> _store() async {
    final InspeccionStoreReqEntity objPost = InspeccionStoreReqEntity(
      fechaProgramada             : DateFormat('dd/MM/yyyy HH:mm').parse(_fechaProgramadaController.text),
      idInspeccionTipo            : _selectedInspeccionTipo?.idInspeccionTipo ?? '',
      inspeccionTipoCodigo        : _selectedInspeccionTipo?.codigo ?? '',
      inspeccionTipoName          : _selectedInspeccionTipo?.name ?? '',
      idBase                      : _selectedUnidad?.idBase ?? '',
      baseName                    : _unidadBaseNameController.text,
      idUnidad                    : _selectedUnidad?.idUnidad ?? '',
      unidadNumeroEconomico       : _unidadNumeroEconomicoController.text,
      isUnidadTemporal            : _selectedSearchUnidad == UnidadInspeccion.temporal,
      idUnidadTipo                : _selectedUnidad?.idUnidadTipo ?? '',
      unidadTipoName              : _unidadTipoNameController.text,
      idUnidadMarca               : _selectedUnidad?.idUnidadMarca ?? '',
      unidadMarcaName             : _unidadMarcaNameController.text,
      idUnidadPlacaTipo           : _selectedUnidad?.idUnidadPlacaTipo ?? '',
      unidadPlacaTipoName         : _unidadPlacaTipoNameController.text,
      placa                       : _unidadPlacaController.text,
      numeroSerie                 : _unidadNumeroSerieController.text,
      modelo                      : _unidadModeloController.text,
      anioEquipo                  : _unidadAnioEquipoController.text,
      capacidad                   : double.tryParse(_unidadCapacidadController.text) ?? 0.000,
      idUnidadCapacidadMedida     : _selectedUnidad?.idUnidadCapacidadMedida ?? '',
      unidadCapacidadMedidaName   : _unidadCapacidadMedidaNameController.text,
      locacion                    : _locacionController.text,
      tipoPlataforma              : _unidadTipoPlataformaController.text,
      odometro                    : int.tryParse(_unidadOdometroController.text),
      horometro                   : int.tryParse(_unidadHorometroController.text),
    );

    BlocProvider.of<RemoteInspeccionBloc>(context).add(StoreInspeccion(objPost));
  }

  void _fillFormFields(UnidadPredictiveListEntity? value) {
    _unidadNumeroEconomicoController.text       = value?.numeroEconomico            ?? '';
    _unidadTipoNameController.text              = value?.unidadTipoName             ?? '';
    _unidadMarcaNameController.text             = value?.unidadMarcaName            ?? '';
    _unidadModeloController.text                = value?.modelo                     ?? '';
    _unidadPlacaTipoNameController.text         = value?.unidadPlacaTipoName        ?? '';
    _unidadPlacaController.text                 = value?.placa                      ?? '';
    _unidadNumeroSerieController.text           = value?.numeroSerie                ?? '';
    _unidadAnioEquipoController.text            = value?.anioEquipo                 ?? '';
    _unidadBaseNameController.text              = value?.baseName                   ?? '';
    _unidadCapacidadController.text             = value?.capacidad                  ?? '';
    _unidadCapacidadMedidaNameController.text   = value?.unidadCapacidadMedidaName  ?? '';
    _unidadOdometroController.text              = value?.odometro                   ?? '';
    _unidadHorometroController.text             = value?.horometro                  ?? '';
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
    _unidadCapacidadMedidaNameController.clear();
    _unidadOdometroController.clear();
    _unidadHorometroController.clear();
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
        appBar: AppBar(title: Text($strings.inspeccionCreateAppBarTitle, style: $styles.textStyles.h3)),
        body: BlocConsumer<RemoteInspeccionBloc, RemoteInspeccionState>(
          listener: (BuildContext context, RemoteInspeccionState state) {
            if (state is RemoteInspeccionCreateLoaded) {
              setState(() {
                // FRAGMENTO MODIFICABLE - LISTAS
                lstInspeccionesTipos            = state.objResponse?.inspeccionesTipos          ?? [];
                lstUnidadesCapacidadesMedidas   = state.objResponse?.unidadesCapacidadesMedidas ?? [];
              });

              // FRAGMENTO NO MODIFICABLE - RENDERIZACION DEL LISTADO DE UNIDADES
              _getUnidadesList();
            }
          },
          builder: (BuildContext context, RemoteInspeccionState state) {
            // LOADING
            if (state is RemoteInspeccionCreateLoading) {
              return const Center(child: AppLoadingIndicator());
            }

            // ERROR
            if (state is RemoteInspeccionServerFailedMessageCreate) {
              return ErrorInfoContainer(
                onPressed     : _create,
                errorMessage  : state.errorMessage,
              );
            }

            if (state is RemoteInspeccionServerFailureCreate) {
              return ErrorInfoContainer(
                onPressed     : _create,
                errorMessage  : state.failure?.errorMessage,
              );
            }

            // SUCCESS
            if (state is RemoteInspeccionCreateLoaded) {
              return SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all($styles.insets.sm).copyWith(bottom: $styles.insets.lg),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        // ALTERNAR ENTRE UNIDAD INVENTARIO / UNIDAD TEMPORAL:
                        _buildSearchUnidad(UnidadInspeccion.temporal, 'Unidad temporal'),

                        // SUGERENCIA:
                        RichText(
                          text: TextSpan(
                            style: $styles.textStyles.label.copyWith(color: Theme.of(context).colorScheme.onBackground),
                            children: <TextSpan>[
                              TextSpan(text: $strings.settingsSuggestionsText, style: const TextStyle(fontWeight: FontWeight.w600)),
                              TextSpan(text: ': ${$strings.inspeccionCreateSuggestion}'),
                            ],
                          ),
                        ),

                        Gap($styles.insets.xs),

                        if (_selectedSearchUnidad == UnidadInspeccion.inventario)...[
                          // BUSCADOR DE UNIDADES INVENTARIO (PREDICTIVO):
                          _SearchUnidadTemporalInput(
                            controller  : _searchUnidadInventarioController,
                            onSubmit    : _handleSearchSubmitted,
                          ),
                        ] else ...[
                          // BUSCADOR DE UNIDADES TEMPORALES (PREDICTIVO):
                          _SearchUnidadTemporalInput(
                            controller  : _searchUnidadTemporalController,
                            onSubmit    : _handleSearchSubmitted,
                          ),

                          BlocBuilder<RemoteUnidadBloc, RemoteUnidadState>(
                            builder: (BuildContext context, RemoteUnidadState state) {
                              if (state is RemoteUnidadPredictiveLoading) {
                                return const AppLinearIndicator();
                              }

                              if (state is RemoteUnidadPredictiveLoaded) {
                                lstRows = state.objResponse ?? [];

                                if (lstRows.isNotEmpty) {
                                  return _ResultsPredictiveOptions(
                                    options: lstRows,
                                    onSelected: _handleSelectedPressed,
                                  );
                                } else {
                                  return const SizedBox.shrink();
                                }
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                        ],

                        // NUEVA UNIDAD TEMPORAL:
                        AnimatedSwitcher(
                          duration: $styles.times.medium,
                          transitionBuilder: (Widget child, Animation<double> animation) {
                            return FadeTransition(opacity: animation, child: SizeTransition(sizeFactor: animation, child: child));
                          },
                          child: _selectedSearchUnidad == UnidadInspeccion.temporal
                              ? Padding(
                                  padding : EdgeInsets.only(top: $styles.insets.sm),
                                  child   : Row(
                                    mainAxisAlignment : MainAxisAlignment.end,
                                    children          : <Widget>[
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

                        // FECHA PROGRAMADA:
                        LabeledDateTimeTextFormField(
                          controller  : _fechaProgramadaController,
                          hintText    : 'dd/mm/aaaa hh:mm',
                          label       : '* Fecha programada de inspección:',
                        ),

                        Gap($styles.insets.sm),

                        // UNIDAD NUMERO ECONOMICO:
                        LabeledTextFormField(
                          controller  : _unidadNumeroEconomicoController,
                          isReadOnly  : true,
                          isEnabled   : false,
                          label       : '* Número económico:',
                          validator   : FormValidators.textValidator,
                        ),

                        Gap($styles.insets.sm),

                        // UNIDAD TIPO NAME:
                        LabeledTextFormField(
                          controller  : _unidadTipoNameController,
                          isReadOnly  : true,
                          isEnabled   : false,
                          label       : '* Tipo de unidad:',
                          validator   : FormValidators.textValidator,
                        ),

                        Gap($styles.insets.sm),

                        // SELECCIONAR TIPO DE INSPECCION:
                        LabeledDropdownFormField<InspeccionTipoEntity>(
                          items       : lstInspeccionesTipos,
                          itemBuilder : (item) => Text(item.name),
                          label       : '* Tipo de inspección:',
                          onChanged   : (value) => setState(() => _selectedInspeccionTipo = value),
                          validator   : FormValidators.dropdownValidator,
                          value       : _selectedInspeccionTipo,
                        ),

                        Gap($styles.insets.sm),

                        // UNIDAD MARCA / MODELO:
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: LabeledTextFormField(
                                controller  : _unidadMarcaNameController,
                                isReadOnly  : true,
                                isEnabled   : false,
                                label       : '* Marca:',
                                validator   : FormValidators.textValidator,
                              ),
                            ),
                            Gap($styles.insets.sm),
                            Expanded(
                              child: LabeledTextFormField(
                                controller  : _unidadModeloController,
                                isReadOnly  : true,
                                isEnabled   : false,
                                label       : '* Modelo:',
                                validator   : FormValidators.textValidator,
                              ),
                            ),
                          ],
                        ),

                        Gap($styles.insets.sm),

                        // UNIDAD PLACA TIPO / PLACA:
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

                        // UNIDAD NUMERO DE SERIE / AÑO DEL EQUIPO:
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

                        // BASE DE LA UNIDAD:
                        LabeledTextFormField(
                          controller  : _unidadBaseNameController,
                          isReadOnly  : true,
                          isEnabled   : false,
                          label       : '* Base:',
                          validator   : FormValidators.textValidator,
                        ),

                        Gap($styles.insets.sm),

                        // LOCACIÓN DE LA INSPECCION:
                        LabeledTextareaFormField(
                          controller    : _locacionController,
                          hintText      : 'Ingresa el lugar de la inspección...',
                          labelText     : '* Locación:',
                          maxLines      : 2,
                          maxCharacters : 300,
                          validator     : FormValidators.textValidator,
                        ),

                        Gap($styles.insets.sm),

                        // TIPO DE PLATAFORMA (SI APLICA):
                        LabeledTextFormField(
                          controller  : _unidadTipoPlataformaController,
                          hintText    : 'Ingresa el tipo de plataforma',
                          label       : 'Tipo de plataforma (Si aplica):',
                        ),

                        Gap($styles.insets.sm),

                        // UNIDAD CAPACIDAD MEDIDA / TIPO DE CAPACIDAD:
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
                              child: LabeledTextFormField(
                                controller    : _unidadCapacidadMedidaNameController,
                                isReadOnly    : true,
                                isEnabled     : false,
                                label         : '* Tipo de capacidad:',
                                validator     : FormValidators.textValidator,
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

  Widget _buildSearchUnidad(UnidadInspeccion unidadInspeccion, String value) {
    if (unidadInspeccion != UnidadInspeccion.temporal) return const SizedBox.shrink();

    final bool isSelectedUnidad = _selectedSearchUnidad == unidadInspeccion;

    void onCheckboxChanged(bool? value) {
      setState(() {
        _selectedSearchUnidad = value ?? false ? unidadInspeccion : null;

        // Reiniciar el campo de búsqueda y actualizar los valores de los campos de solo lectura.
        if (_selectedSearchUnidad == UnidadInspeccion.temporal) {
          _selectedUnidad = null;
          _clearFormFields(); // Limpia los campos.
        } else {
          _clearFormFields(); // Limpia los campos.
        }
      });
    }

    return GestureDetector(
      onTap : () => onCheckboxChanged(!isSelectedUnidad),
      child : Row(
        children: <Widget>[
          Checkbox(
            value     : isSelectedUnidad,
            onChanged : onCheckboxChanged,
          ),
          Text(value, style: $styles.textStyles.bodySmall),
        ],
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
          BlocConsumer<RemoteInspeccionBloc, RemoteInspeccionState>(
            listener: (BuildContext context, RemoteInspeccionState state) {
              if (state is RemoteInspeccionServerFailedMessageStore) {
                _showServerFailedDialog(context, state.errorMessage);
                _create();
              }

              if (state is RemoteInspeccionServerFailureStore) {
                _showServerFailedDialog(context, state.failure?.errorMessage);
                _create();
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
                widget.buildDataSourceCallback!();
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
