part of 'create_inspeccion_page.dart';

class _CreateForm extends StatefulWidget {
  const _CreateForm({Key? key}) : super(key: key);

  @override
  State<_CreateForm> createState() => _CreateFormState();
}

class _CreateFormState extends State<_CreateForm> {
  // GLOBAL KEY
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // CONTROLLERS
  late final TextEditingController _searchUnidadController;

  late final TextEditingController _fechaProgramadaController;
  late final TextEditingController _baseNameController;
  late final TextEditingController _unidadNumeroEconomicoController;
  late final TextEditingController _unidadTipoNameController;
  late final TextEditingController _unidadMarcaNameController;
  late final TextEditingController _unidadPlacaTipoNameController;
  late final TextEditingController _placaController;
  late final TextEditingController _numeroSerieController;
  late final TextEditingController _modeloController;
  late final TextEditingController _anioEquipoController;
  late final TextEditingController _capacidadController;
  late final TextEditingController _unidadCapacidadMedidaNameController;
  late final TextEditingController _locacionController;
  late final TextEditingController _tipoPlataformaController;
  late final TextEditingController _odometroController;
  late final TextEditingController _horometroController;

  // LIST
  late List<UnidadSearchEntity> lstUnidades                        = <UnidadSearchEntity>[];
  late List<InspeccionTipoEntity> lstInspeccionesTipos             = <InspeccionTipoEntity>[];
  late List<UnidadCapacidadMedida> lstUnidadesCapacidadesMedidas   = <UnidadCapacidadMedida>[];

  // SELECTED INSPECCION TIPO
  String? _selectedInspeccionTipoId;
  String? _selectedInspeccionTipoCodigo;
  String? _selectedInspeccionTipoName;

  // SELECTED UNIDAD
  UnidadInspeccion? _selectedUnidadInspeccion;
  UnidadSearchEntity? _selectedUnidad;

  String? _selectedUnidadBaseId;
  String? _selectedUnidadId;
  String? _selectedUnidadTipoId;
  String? _selectedUnidadMarcaId;
  String? _selectedUnidadPlacaTipoId;

  // SELECTED UNIDAD CAPACIDAD MEDIDA
  String? _selectedUnidadCapacidadMedidaId;

  @override
  void initState() {
    super.initState();

    context.read<RemoteInspeccionBloc>().add(CreateInspeccion());

    _selectedUnidadInspeccion = UnidadInspeccion.inventario;

    _searchUnidadController               = TextEditingController();

    _fechaProgramadaController            = TextEditingController();
    _baseNameController                   = TextEditingController();
    _unidadNumeroEconomicoController      = TextEditingController();
    _unidadTipoNameController             = TextEditingController();
    _unidadMarcaNameController            = TextEditingController();
    _unidadPlacaTipoNameController        = TextEditingController();
    _placaController                      = TextEditingController();
    _numeroSerieController                = TextEditingController();
    _modeloController                     = TextEditingController();
    _anioEquipoController                 = TextEditingController();
    _capacidadController                  = TextEditingController();
    _unidadCapacidadMedidaNameController  = TextEditingController();
    _locacionController                   = TextEditingController();
    _tipoPlataformaController             = TextEditingController();
    _odometroController                   = TextEditingController();
    _horometroController                  = TextEditingController();
  }

  @override
  void dispose() {
    _searchUnidadController.dispose();
    _fechaProgramadaController.dispose();
    _baseNameController.dispose();
    _unidadNumeroEconomicoController.dispose();
    _unidadTipoNameController.dispose();
    _unidadMarcaNameController.dispose();
    _unidadPlacaTipoNameController.dispose();
    _placaController.dispose();
    _numeroSerieController.dispose();
    _modeloController.dispose();
    _anioEquipoController.dispose();
    _capacidadController.dispose();
    _unidadCapacidadMedidaNameController.dispose();
    _locacionController.dispose();
    _tipoPlataformaController.dispose();
    _odometroController.dispose();
    _horometroController.dispose();

    super.dispose();
  }

  // METHODS
  void _handleCreateUnidadPressed(BuildContext context) {
    Navigator.push<void>(
      context,
      PageRouteBuilder<void>(
        pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
          const Offset begin  = Offset(0, 1);
          const Offset end    = Offset.zero;
          const Cubic curve   = Curves.ease;

          final Animatable<Offset> tween = Tween<Offset>(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(position: animation.drive<Offset>(tween), child: const CreateUnidadPage());
        },
        fullscreenDialog: true,
      ),
    );
  }

  void _handleStoreInspeccion() {
    final DateTime? fechaProgramada  = _fechaProgramadaController.text.isNotEmpty ? DateFormat('dd/MM/yyyy HH:mm').parse(_fechaProgramadaController.text) : null;

    final double? capacidad         = double.tryParse(_capacidadController.text);
    final int? odometro             = int.tryParse(_odometroController.text);
    final int? horometro            = int.tryParse(_horometroController.text);

    final InspeccionStoreReqEntity objData = InspeccionStoreReqEntity(
      fechaProgramada             : fechaProgramada                 ?? DateTime.now(),
      idInspeccionTipo            : _selectedInspeccionTipoId       ?? '',
      inspeccionTipoCodigo        : _selectedInspeccionTipoCodigo   ?? '',
      inspeccionTipoName          : _selectedInspeccionTipoName     ?? '',
      idBase                      : _selectedUnidadBaseId           ?? '',
      baseName                    : _baseNameController.text,
      idUnidad                    : _selectedUnidadId               ?? '',
      unidadNumeroEconomico       : _unidadNumeroEconomicoController.text,
      isUnidadTemporal            : _selectedUnidadInspeccion == UnidadInspeccion.temporal,
      idUnidadTipo                : _selectedUnidadTipoId           ?? '',
      unidadTipoName              : _unidadTipoNameController.text,
      idUnidadMarca               : _selectedUnidadMarcaId          ?? '',
      unidadMarcaName             : _unidadMarcaNameController.text,
      idUnidadPlacaTipo           : _selectedUnidadPlacaTipoId      ?? '',
      unidadPlacaTipoName         : _unidadPlacaTipoNameController.text,
      placa                       : _unidadPlacaTipoNameController.text,
      numeroSerie                 : _numeroSerieController.text,
      modelo                      : _modeloController.text,
      anioEquipo                  : _anioEquipoController.text,
      capacidad                   : capacidad,
      idUnidadCapacidadMedida     : _selectedUnidadCapacidadMedidaId ?? '',
      unidadCapacidadMedidaName   : _unidadCapacidadMedidaNameController.text,
      locacion                    : _locacionController.text,
      tipoPlataforma              : _tipoPlataformaController.text,
      odometro                    : odometro,
      horometro                   : horometro,
    );

    final bool isValidForm = _formKey.currentState!.validate();

    // Verificar la validacion en el formulario.
    if (isValidForm) {
      _formKey.currentState!.save();
      BlocProvider.of<RemoteInspeccionBloc>(context).add(StoreInspeccion(objData));
    }
  }

  Future<DateTime?> _handleFechaProgramadaPressed(BuildContext context) async {
    final DateTime currentDate = DateTime.now();

    // Mostrar el selector de fecha.
    final DateTime? pickedDate = await showDatePicker(
      context     : context,
      initialDate : currentDate,
      firstDate   : DateTime(2000),
      lastDate    : DateTime(2100),
    );

    if (pickedDate != null) {
      // Mostrar el selector de la hora
      final TimeOfDay? pickedTime = await showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(currentDate));

      if (pickedTime != null) {
        final DateTime selectedFechaProgramada = DateTime(pickedDate.year, pickedDate.month, pickedDate.day, pickedTime.hour, pickedTime.minute);

        setState(() {
          _fechaProgramadaController.text = DateFormat('dd/MM/yyyy HH:mm').format(selectedFechaProgramada);
        });
      }
    }
    return null;
  }

  Future<void> _showFailureDialog(BuildContext context, RemoteInspeccionServerFailure state) {
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
                state.failure?.errorMessage ?? 'Se produjo un error inesperado. Intenta crear la inspección de nuevo.',
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

  Future<void> _showFailedMessageDialog(BuildContext context, RemoteInspeccionServerFailedMessage state) {
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
                state.errorMessage ?? 'Se produjo un error inesperado. Intenta crear la inspección de nuevo.',
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
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // CAMBIAR DINAMICAMENTE ENTRE UNIDAD INVENTARIO / UNIDAD TEMPORAL:
          _buildUnidadCheckbox(UnidadInspeccion.temporal, 'Unidad temporal'),

          Gap($styles.insets.sm),

          // SELECCIONAR Y BUSCAR UNIDAD A INSPECCIONAR:
          if (_selectedUnidadInspeccion == UnidadInspeccion.temporal)
            BlocBuilder<RemoteUnidadBloc, RemoteUnidadState>(
              builder: (context, state) {
                if (state is RemoteUnidadSearchLoaded) {
                  lstUnidades = state.unidades ?? [];

                  return LabeledDropdownFormSearchField<UnidadSearchEntity>(
                    hintText          : 'Seleccione la unidad a inspeccionar',
                    label             : '* Unidad:',
                    searchController  : _searchUnidadController,
                    items             : lstUnidades,
                    itemBuilder       : (unidad) => Text(unidad.value ?? ''),
                    value             : _selectedUnidad,
                    onChanged         : (selectedType) {
                      setState(() {
                        _selectedUnidad                     = selectedType;
                        _selectedUnidadId                   = selectedType?.idUnidad                  ?? '';
                        _selectedUnidadBaseId               = selectedType?.idBase                    ?? '';
                        _selectedUnidadTipoId               = selectedType?.idUnidadTipo              ?? '';
                        _selectedUnidadMarcaId              = selectedType?.idUnidadMarca             ?? '';
                        _selectedUnidadPlacaTipoId          = selectedType?.idUnidadPlacaTipo         ?? '';
                        _selectedUnidadCapacidadMedidaId    = selectedType?.idUnidadCapacidadMedida   ?? '';

                        _unidadNumeroEconomicoController.text     = selectedType?.numeroEconomico           ?? '';
                        _baseNameController.text                  = selectedType?.baseName                  ?? '';
                        _unidadTipoNameController.text            = selectedType?.unidadTipoName            ?? '';
                        _unidadMarcaNameController.text           = selectedType?.unidadMarcaName           ?? '';
                        _unidadPlacaTipoNameController.text       = selectedType?.unidadPlacaTipoName       ?? '';
                        _placaController.text                     = selectedType?.placa                     ?? '';
                        _numeroSerieController.text               = selectedType?.numeroSerie               ?? '';
                        _modeloController.text                    = selectedType?.modelo                    ?? '';
                        _anioEquipoController.text                = selectedType?.anioEquipo                ?? '';
                        _capacidadController.text                 = selectedType?.capacidad                 ?? '';
                        _unidadCapacidadMedidaNameController.text = selectedType?.unidadCapacidadMedidaName ?? '';
                        _odometroController.text                  = selectedType?.odometro                  ?? '';
                        _horometroController.text                 = selectedType?.horometro                 ?? '';
                      });
                    },
                    searchMatchFn     : (DropdownMenuItem<UnidadSearchEntity> item, String searchValue) {
                      return item.value!.numeroEconomico!.toLowerCase().contains(searchValue.toLowerCase());
                    },
                    validator         : FormValidators.dropdownValidator,
                  );
                }

                return const SizedBox.shrink();
              },
            )
          else Container(),

          // NUEVA UNIDAD TEMPORAL:
          AnimatedSwitcher(
            duration: $styles.times.fast,
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: SizeTransition(sizeFactor: animation, child: child),
              );
            },
            child: _selectedUnidadInspeccion == UnidadInspeccion.temporal
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

          // SELECCIONAR TIPO DE INSPECCIÓN:
          BlocListener<RemoteInspeccionBloc, RemoteInspeccionState>(
            listener: (BuildContext context, RemoteInspeccionState state) {
              if (state is RemoteInspeccionCreateLoaded) {
                // FRAGMENTO NO MODIFICABLE - LISTAS
                setState(() {
                  lstInspeccionesTipos = state.objResponse?.inspeccionesTipos ?? [];
                });
              }
            },
            child: LabeledDropdownFormField<InspeccionTipoEntity>(
              hintText    : 'Seleccionar',
              label       : '* Tipo de inspección:',
              items       : lstInspeccionesTipos,
              itemBuilder : (item) => Text(item.name),
              onChanged   : (selectedType) {
                setState(() {
                  _selectedInspeccionTipoId       = selectedType?.idInspeccionTipo;
                  _selectedInspeccionTipoCodigo   = selectedType?.codigo;
                  _selectedInspeccionTipoName     = selectedType?.name;
                });
              },
              validator : FormValidators.dropdownValidator,
            ),
          ),

          Gap($styles.insets.sm),

          // FECHA PROGRAMADA:
          LabeledTextFormField(
            controller  : _fechaProgramadaController,
            isReadOnly  : true,
            label       : '* Fecha programada:',
            onTap       : () async => _handleFechaProgramadaPressed(context),
            textAlign   : TextAlign.end,
            validator   : FormValidators.textValidator,
          ),

          Gap($styles.insets.sm),

          // UNIDAD NUMERO ECONOMICO:
          LabeledTextFormField(
            controller  : _unidadNumeroEconomicoController,
            isReadOnly  : true,
            label       : '* Número económico:',
            // validator   : FormValidators.textValidator,
          ),

          Gap($styles.insets.sm),

          // UNIDAD TIPO NAME:
          LabeledTextFormField(
            controller  : _unidadTipoNameController,
            isReadOnly  : true,
            label       : '* Tipo de unidad:',
            // validator   : FormValidators.textValidator,
          ),

          Gap($styles.insets.sm),

          // UNIDAD MARCA NAME / MODELO:
          Row(
            children: <Widget>[
              Expanded(
                child: LabeledTextFormField(
                  controller  : _unidadMarcaNameController,
                  isReadOnly  : true,
                  label       : 'Marca:',
                ),
              ),
              Gap($styles.insets.sm),
              Expanded(
                child: LabeledTextFormField(
                  controller  : _modeloController,
                  isReadOnly  : true,
                  label       : 'Modelo:',
                ),
              ),
            ],
          ),

          Gap($styles.insets.sm),

          // UNIDAD PLACA TIPO NAME / PLACA:
          Row(
            children: <Widget>[
              Expanded(
                child: LabeledTextFormField(
                  controller  : _unidadPlacaTipoNameController,
                  isReadOnly  : true,
                  label       : 'Tipo de placa:',
                ),
              ),
              Gap($styles.insets.sm),
              Expanded(
                child: LabeledTextFormField(
                  controller  : _placaController,
                  isReadOnly  : true,
                  label       : 'Placa:',
                ),
              ),
            ],
          ),

          Gap($styles.insets.sm),

          // NUMERO SERIE / AÑO DEL EQUIPO:
          Row(
            children: <Widget>[
              Expanded(
                child: LabeledTextFormField(
                  controller  : _numeroSerieController,
                  isReadOnly  : true,
                  label       : 'Número de serie:',
                ),
              ),
              Gap($styles.insets.sm),
              Expanded(
                child: LabeledTextFormField(
                  controller  : _anioEquipoController,
                  isReadOnly  : true,
                  label       : 'Año del equipo:',
                ),
              ),
            ],
          ),

          Gap($styles.insets.sm),

          // LOCACIÓN DE INSPECCIÓN:
          LabeledTextareaFormField(
            controller    : _locacionController,
            hintText      : 'Ingresa lugar de inspección',
            labelText     : '* Locación:',
            maxLines      : 2,
            maxCharacters : 300,
            validator     : FormValidators.textValidator,
          ),

          Gap($styles.insets.sm),

          // BASE:
          LabeledTextFormField(
            controller  : _baseNameController,
            isReadOnly  : true,
            label       : '* Base:',
          ),

          Gap($styles.insets.sm),

          // TIPO DE PLATAFORMA:
          LabeledTextFormField(
            controller  : _tipoPlataformaController,
            label       : 'Tipo de plataforma:',
          ),

          Gap($styles.insets.sm),

          // UNIDAD CAPACIDAD / UNIDAD CAPACIDAD MEDIDA:
          Row(
            children: <Widget>[
              Expanded(
                child: LabeledTextFormField(
                  controller    : _capacidadController,
                  isReadOnly    : true,
                  label         : '* Capacidad:',
                ),
              ),
              Gap($styles.insets.xs),
              Expanded(
                child: LabeledTextFormField(
                  controller    : _unidadCapacidadMedidaNameController,
                  isReadOnly    : true,
                  label         : '* Tipo de capacidad',
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
                  hintText      : 'Ingresa cantidad',
                  keyboardType  : TextInputType.number,
                  label         : 'Odómetro:',
                ),
              ),
              Gap($styles.insets.sm),
              Expanded(
                child: LabeledTextFormField(
                  controller    : _horometroController,
                  hintText      : 'Ingresa cantidad',
                  keyboardType  : TextInputType.number,
                  label         : 'Horómetro:',
                ),
              ),
            ],
          ),

          Gap($styles.insets.lg),

          BlocConsumer<RemoteInspeccionBloc, RemoteInspeccionState>(
            listener: (BuildContext context, RemoteInspeccionState state) {
              if (state is RemoteInspeccionServerFailure) {
                _showFailureDialog(context, state);
              }

              if (state is RemoteInspeccionServerFailedMessage) {
                _showFailedMessageDialog(context, state);
              }

              if (state is RemoteInspeccionStored) {
                Navigator.pop(context);

                ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content         : Text(state.objResponse?.message ?? '', softWrap: true),
                    backgroundColor : Colors.green,
                    behavior        : SnackBarBehavior.fixed,
                    elevation       : 0,
                  ),
                );
              }
            },
            builder: (BuildContext context, RemoteInspeccionState state) {
              if (state is RemoteInspeccionStoring) {
                return FilledButton(
                  onPressed : null,
                  style     : ButtonStyle(minimumSize: MaterialStateProperty.all<Size?>(const Size(double.infinity, 48))),
                  child     : const AppLoadingIndicator(width: 20, height: 20),
                );
              }

              return FilledButton(
                onPressed : _handleStoreInspeccion,
                style     : ButtonStyle(minimumSize: MaterialStateProperty.all<Size?>(const Size(double.infinity, 48))),
                child     : Text($strings.saveButtonText, style: $styles.textStyles.button),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildUnidadCheckbox(UnidadInspeccion unidad, String value) {
    if (unidad == UnidadInspeccion.temporal) {
      final bool isSelectedUnidad = _selectedUnidadInspeccion == unidad;

      return GestureDetector(
        onTap: () {
          setState(() {
            _selectedUnidadInspeccion = isSelectedUnidad ? null : unidad;
          });
        },
        child: Row(
          children: <Widget>[
            Checkbox(
              value: isSelectedUnidad,
              onChanged: (value) {
                if (value != null) {
                   setState(() {
                    _selectedUnidadInspeccion = value ? unidad : null;
                  });
                }
              },
            ),
            Text(value, style: $styles.textStyles.label),
          ],
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
