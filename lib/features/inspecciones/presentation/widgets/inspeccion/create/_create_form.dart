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
  List<InspeccionTipoEntity> lstInspeccionesTipos = [];
  List<UnidadCapacidadMedida> lstUnidadesCapacidadesMedidas = [];

  List<String> list = <String>['One', 'Two', 'Three', 'Four'];

  // SELECTED INSPECCION TIPO
  String? _selectedInspeccionTipoId;
  String? _selectedInspeccionTipoCodigo;
  String? _selectedInspeccionTipoName;

  // SELECTED UNIDAD CAPACIDAD MEDIDA
  String? _selectedUnidadCapacidadMedidaId;
  String? _selectedUnidadCapacidadMedidaName;

  @override
  void initState() {
    super.initState();

    context.read<RemoteInspeccionBloc>().add(CreateInspeccion());

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
  void _handleStoreInspeccion() {
    final DateTime? fechaProgramada  = _fechaProgramadaController.text.isNotEmpty ? DateFormat('dd/MM/yyyy HH:mm').parse(_fechaProgramadaController.text) : null;

    final double? capacidad         = double.tryParse(_capacidadController.text);
    final int? odometro             = int.tryParse(_odometroController.text);
    final int? horometro            = int.tryParse(_horometroController.text);

    final InspeccionStoreReqEntity objData = InspeccionStoreReqEntity(
      fechaProgramada             : fechaProgramada ?? DateTime.now(),
      idInspeccionTipo            : _selectedInspeccionTipoId       ?? '',
      inspeccionTipoCodigo        : _selectedInspeccionTipoCodigo   ?? '',
      inspeccionTipoName          : _selectedInspeccionTipoName     ?? '',
      idBase                      : 'idBase',
      baseName                    : 'baseName',
      idUnidad                    : 'idUnidad',
      unidadNumeroEconomico       : 'unidadNumeroEconomico',
      isUnidadTemporal            : false,
      idUnidadTipo                : 'idUnidadTipo',
      unidadTipoName              : 'unidadTipoName',
      idUnidadMarca               : 'idUnidadMarca',
      unidadMarcaName             : 'unidadMarcaName',
      idUnidadPlacaTipo           : 'idUnidadPlacaTipo',
      unidadPlacaTipoName         : 'unidadPlacaTipoName',
      placa                       : 'placa',
      numeroSerie                 : 'numeroSerie',
      modelo                      : 'modelo',
      anioEquipo                  : 'anioEquipo',
      capacidad                   : capacidad,
      idUnidadCapacidadMedida     : _selectedUnidadCapacidadMedidaId    ?? '',
      unidadCapacidadMedidaName   : _selectedUnidadCapacidadMedidaName  ?? '',
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // CAMBIAR DINAMICAMENTE ENTRE UNIDAD INVENTARIO / UNIDAD TEMPORAL:
          _buildUnidadCheckbox(UnidadInspeccionTipo.temporal, 'Unidad temporal'),

          // SELECCIONAR TIPO DE INSPECCIÓN:
          BlocBuilder<RemoteInspeccionBloc, RemoteInspeccionState>(
            builder: (BuildContext context, RemoteInspeccionState state) {
              if (state is RemoteInspeccionCreating) {
                return const Center(child: AppLoadingIndicator(width: 20, height: 20));
              }

              if (state is RemoteInspeccionServerFailedMessage) {
                return const Center(child: AppLoadingIndicator(width: 20, height: 20));
              }

              if (state is RemoteInspeccionServerFailure) {
                return const Center(child: AppLoadingIndicator(width: 20, height: 20));
              }

              if (state is RemoteInspeccionCreateLoaded) {
                // FRAGMENTO NO MODIFICABLE - LISTAS
                lstInspeccionesTipos = state.objResponse?.inspeccionesTipos ?? [];

                return LabeledDropdownFormField<InspeccionTipoEntity>(
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
                );
              }

              return const SizedBox.shrink();
            },
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
            validator   : FormValidators.textValidator,
          ),

          Gap($styles.insets.sm),

          // UNIDAD TIPO NAME:
          LabeledTextFormField(
            controller  : _unidadTipoNameController,
            isReadOnly  : true,
            label       : '* Tipo de unidad:',
            validator   : FormValidators.textValidator,
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
                flex: 2,
                child: LabeledTextFormField(
                  controller    : _capacidadController,
                  hintText      : 'Ingresa cantidad',
                  label         : '* Capacidad:',
                  keyboardType  : TextInputType.number,
                  validator     : FormValidators.decimalValidator,
                ),
              ),
              Gap($styles.insets.xs),
              Expanded(
                child: BlocBuilder<RemoteInspeccionBloc, RemoteInspeccionState>(
                  builder: (BuildContext context, RemoteInspeccionState state) {
                    if (state is RemoteInspeccionCreating) {
                      return const Center(child: AppLoadingIndicator(width: 20, height: 20));
                    }

                    if (state is RemoteInspeccionServerFailedMessage) {
                      return const Center(child: AppLoadingIndicator(width: 20, height: 20));
                    }

                    if (state is RemoteInspeccionServerFailure) {
                      return const Center(child: AppLoadingIndicator(width: 20, height: 20));
                    }

                    if (state is RemoteInspeccionCreateLoaded) {
                      // FRAGMENTO NO MODIFICABLE - LISTAS
                      lstUnidadesCapacidadesMedidas = state.objResponse?.unidadesCapacidadesMedidas ?? [];

                      return LabeledDropdownFormField<UnidadCapacidadMedida>(
                        hintText    : 'Seleccionar',
                        label       : '',
                        items       : lstUnidadesCapacidadesMedidas,
                        itemBuilder : (item) => Text(item.name ?? ''),
                        onChanged   : (selectedType) {
                          setState(() {
                            _selectedUnidadCapacidadMedidaId     = selectedType?.idUnidadCapacidadMedida;
                            _selectedUnidadCapacidadMedidaName   = selectedType?.name;
                          });
                        },
                        validator : FormValidators.dropdownValidator,
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
            listener: (context, state) {
              if (state is RemoteInspeccionStored) {

              }
            },
            builder: (context, state) {
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

  Widget _buildUnidadCheckbox(UnidadInspeccionTipo unidad, String value) {
    return Container();
    // if (unidad == UnidadInspeccionTipo.temporal) {
    //   return GestureDetector(
    //     onTap: () {},
    //     child: Row(
    //       children: <Widget>[
    //         Checkbox(value: null, onChanged: (_){}),
    //         Text(value, style: $styles.textStyles.label),
    //       ],
    //     ),
    //   );
    // } else {
    //   return const SizedBox.shrink();
    // }
  }
}
