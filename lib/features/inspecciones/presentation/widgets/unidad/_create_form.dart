part of 'create_unidad_page.dart';

class _CreateForm extends StatefulWidget {
  const _CreateForm({Key? key}) : super(key: key);

  @override
  State<_CreateForm> createState() => _CreateFormState();
}

class _CreateFormState extends State<_CreateForm> {
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
  late List<Base> lstBases                                         = <Base>[];
  late List<UnidadCapacidadMedida> lstUnidadesCapacidadesMedidas   = <UnidadCapacidadMedida>[];
  late List<UnidadMarca> lstUnidadesMarcas                         = <UnidadMarca>[];
  late List<UnidadTipo> lstUnidadesTipos                           = <UnidadTipo>[];

  final List<UnidadPlacaTipo> lstUnidadesPlacasTipos = <UnidadPlacaTipo>[
    const UnidadPlacaTipo(idUnidadPlacaTipo: 'ea52bdfd-8af6-4f5a-b182-2b99e554eb31', name: 'Estatal'),
    const UnidadPlacaTipo(idUnidadPlacaTipo: 'ea52bdfd-8af6-4f5a-b182-2b99e554eb32', name: 'Federal'),
    const UnidadPlacaTipo(idUnidadPlacaTipo: 'ea52bdfd-8af6-4f5a-b182-2b99e554eb33', name: 'No aplica'),
  ];

  bool _dataLoaded = false;

  // SELECTED UNIDAD
  String? _selectedUnidadBaseId;
  String? _selectedUnidadBaseName;
  String? _selectedUnidadTipoId;
  String? _selectedUnidadTipoName;
  String? _selectedUnidadMarcaId;
  String? _selectedUnidadMarcaName;
  String? _selectedUnidadPlacaTipoId;
  String? _selectedUnidadPlacaTipoName;

  // SELECTED UNIDAD CAPACIDAD MEDIDA
  String? _selectedUnidadCapacidadMedidaId;
  String? _selectedUnidadCapacidadMedidaName;

  @override
  void initState() {
    super.initState();

    if (!_dataLoaded) {
      context.read<RemoteUnidadBloc>().add(CreateUnidad());
      _dataLoaded = true;
    }

    _numeroEconomicoController    = TextEditingController();
    _placaController              = TextEditingController();
    _numeroSerieController        = TextEditingController();
    _modeloController             = TextEditingController();
    _anioEquipoController         = TextEditingController();
    _descripcionController        = TextEditingController();
    _capacidadController          = TextEditingController();
    _odometroController           = TextEditingController();
    _horometroController          = TextEditingController();
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

    _dataLoaded = false;

    super.dispose();
  }

  // METHODS
  void _handleStoreUnidad() {
    final double? capacidad   = double.tryParse(_capacidadController.text);
    final int? odometro       = int.tryParse(_odometroController.text);
    final int? horometro      = int.tryParse(_horometroController.text);

    final UnidadStoreReqEntity objData = UnidadStoreReqEntity(
      numeroEconomico             : _numeroEconomicoController.text,
      idBase                      : _selectedUnidadBaseId         ?? '',
      baseName                    : _selectedUnidadBaseName       ?? '',
      idUnidadTipo                : _selectedUnidadTipoId         ?? '',
      unidadTipoName              : _selectedUnidadTipoName       ?? '',
      idUnidadMarca               : _selectedUnidadMarcaId        ?? '',
      unidadMarcaName             : _selectedUnidadMarcaName      ?? '',
      idUnidadPlacaTipo           : _selectedUnidadPlacaTipoId    ?? '',
      unidadPlacaTipoName         : _selectedUnidadPlacaTipoName  ?? '',
      placa                       : _placaController.text,
      numeroSerie                 : _numeroSerieController.text,
      modelo                      : _modeloController.text,
      anioEquipo                  : _anioEquipoController.text,
      descripcion                 : _descripcionController.text,
      capacidad                   : capacidad,
      idUnidadCapacidadMedida     : _selectedUnidadCapacidadMedidaId    ?? '',
      unidadCapacidadMedidaName   : _selectedUnidadCapacidadMedidaName  ?? '',
      odometro                    : odometro,
      horometro                   : horometro,
    );

    final bool isValidForm = _formKey.currentState!.validate();

    // Verificar la validacion en el formulario.
    if (isValidForm) {
      _formKey.currentState!.save();
      BlocProvider.of<RemoteUnidadBloc>(context).add(StoreUnidad(objData));
    }
  }

  Future<void> _showFailureDialog(BuildContext context, RemoteUnidadServerFailure state) {
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
                state.failure?.errorMessage ?? 'Se produjo un error inesperado. Intenta crear la unidad de nuevo.',
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

  Future<void> _showFailedMessageDialog(BuildContext context, RemoteUnidadServerFailedMessage state) {
    return showDialog<void>(
      context   : context,
      builder   : (_) => AlertDialog(
        title   : const SizedBox.shrink(),
        content : Row(
          children: <Widget>[
            Icon(Icons.error, color: Theme.of(context).colorScheme.error),
            Gap($styles.insets.sm),
            Flexible(child: Text(state.errorMessage ?? 'Error inesperado', style: $styles.textStyles.title2.copyWith(height: 1.5))),
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
          // NUMERO ECONOMICO:
          LabeledTextFormField(
            controller  : _numeroEconomicoController,
            hintText    : 'Ingrese número económico...',
            label       : '* No. económico:',
            validator   : FormValidators.textValidator,
          ),

          Gap($styles.insets.sm),

          // SELECCIONAR TIPO DE UNIDAD:
          BlocListener<RemoteUnidadBloc, RemoteUnidadState>(
            listener: (BuildContext context, RemoteUnidadState state) {
              if (state is RemoteUnidadCreateLoaded) {
                // FRAGMENTO NO MODIFICABLE - LISTAS
                setState(() {
                  lstUnidadesTipos = state.objResponse?.unidadesTipos ?? [];
                });
              }
            },
            child: LabeledDropdownFormField<UnidadTipo>(
              hintText    : 'Seleccionar',
              label       : '* Tipo de unidad:',
              items       : lstUnidadesTipos,
              itemBuilder : (item) => Text(item.name ?? ''),
              onChanged   : (selectedType) {
                setState(() {
                  _selectedUnidadTipoId   = selectedType?.idUnidadTipo  ?? '';
                  _selectedUnidadTipoName = selectedType?.name          ?? '';
                });
              },
              validator : FormValidators.dropdownValidator,
            ),
          ),

          Gap($styles.insets.sm),

          // SELECCIONAR MARCA:
          BlocListener<RemoteUnidadBloc, RemoteUnidadState>(
            listener: (BuildContext context, RemoteUnidadState state) {
              if (state is RemoteUnidadCreateLoaded) {
                // FRAGMENTO NO MODIFICABLE - LISTAS
                setState(() {
                  lstUnidadesMarcas = state.objResponse?.unidadesMarcas ?? [];
                });
              }
            },
            child: LabeledDropdownFormField<UnidadMarca>(
              hintText    : 'Seleccionar',
              label       : '* Marca:',
              items       : lstUnidadesMarcas,
              itemBuilder : (item) => Text(item.name ?? ''),
              onChanged   : (selectedType) {
                setState(() {
                  _selectedUnidadMarcaId   = selectedType?.idUnidadMarca  ?? '';
                  _selectedUnidadMarcaName = selectedType?.name           ?? '';
                });
              },
              validator : FormValidators.dropdownValidator,
            ),
          ),

          Gap($styles.insets.sm),

          // MODELO:
          LabeledTextFormField(
            controller  : _modeloController,
            hintText    : 'Ingrese modelo...',
            label       : '* Modelo:',
            validator   : FormValidators.textValidator,
          ),

          Gap($styles.insets.sm),

          // NUMERO DE SERIE:
          LabeledTextFormField(
            controller  : _numeroSerieController,
            hintText    : 'Ingrese número serie...',
            label       : '* No. serie:',
            validator   : FormValidators.textValidator,
          ),

          Gap($styles.insets.sm),

          // AÑO DEL EQUIPO:
          LabeledTextFormField(
            controller  : _anioEquipoController,
            hintText    : 'Ingrese año equipo...',
            label       : 'Año del equipo:',
          ),

          Gap($styles.insets.sm),

          // UNIDAD PLACA TIPO / PLACA:
          Row(
            children: <Widget>[
              Expanded(
                child: LabeledTextFormField(
                  controller  : _placaController,
                  hintText    : 'Ingrese placa...',
                  label       : 'Placa:',
                ),
              ),
              Gap($styles.insets.sm),
              Expanded(
                child: LabeledDropdownFormField(
                  hintText    : 'Seleccionar',
                  label       : 'Tipo de placa',
                  items       : lstUnidadesPlacasTipos,
                  itemBuilder : (item) => Text(item.name ?? ''),
                  onChanged   : (selectedType) {
                    setState(() {
                      _selectedUnidadPlacaTipoId    = selectedType?.idUnidadPlacaTipo   ?? '';
                      _selectedUnidadPlacaTipoName  = selectedType?.name                ?? '';
                    });
                  },
                ),
              ),
            ],
          ),

          Gap($styles.insets.sm),

          // DESCRIPCION:
          LabeledTextareaFormField(
            controller    : _descripcionController,
            hintText      : 'Ingresa descripción o motivo de creación...',
            labelText     : 'Descripción (opcional):',
            maxLines      : 2,
            maxCharacters : 300,
          ),

          Gap($styles.insets.sm),

          // SELECCIONAR BASE:
          BlocListener<RemoteUnidadBloc, RemoteUnidadState>(
            listener: (BuildContext context, RemoteUnidadState state) {
              if (state is RemoteUnidadCreateLoaded) {
                // FRAGMENTO NO MODIFICABLE - LISTAS
                setState(() {
                  lstBases = state.objResponse?.bases ?? [];
                });
              }
            },
            child: LabeledDropdownFormField<Base>(
              hintText    : 'Seleccionar',
              label       : '* Base:',
              items       : lstBases,
              itemBuilder : (item) => Text(item.name ?? ''),
              onChanged   : (selectedType) {
                setState(() {
                  _selectedUnidadBaseId   = selectedType?.idBase  ?? '';
                  _selectedUnidadBaseName = selectedType?.name    ?? '';
                });
              },
              validator : FormValidators.dropdownValidator,
            ),
          ),

          Gap($styles.insets.sm),

          // CAPACIDAD / UNIDAD CAPACIDAD MEDIDA:
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
                child: BlocListener<RemoteUnidadBloc, RemoteUnidadState>(
                  listener: (BuildContext context, RemoteUnidadState state) {
                    if (state is RemoteUnidadCreateLoaded) {
                      // FRAGMENTO NO MODIFICABLE - LISTAS
                      setState(() {
                        lstUnidadesCapacidadesMedidas = state.objResponse?.unidadesCapacidadesMedidas ?? [];
                      });
                    }
                  },
                  child: LabeledDropdownFormField<UnidadCapacidadMedida>(
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
                  ),
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

          BlocConsumer<RemoteUnidadBloc, RemoteUnidadState>(
            listener: (BuildContext context, RemoteUnidadState state) {
              if (state is RemoteUnidadServerFailure) {
                _showFailureDialog(context, state);
              }

              if (state is RemoteUnidadServerFailedMessage) {
                _showFailedMessageDialog(context, state);
              }

              if (state is RemoteUnidadStored) {
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
                onPressed : _handleStoreUnidad,
                style     : ButtonStyle(minimumSize: MaterialStateProperty.all<Size?>(const Size(double.infinity, 48))),
                child     : Text($strings.saveButtonText, style: $styles.textStyles.button),
              );
            },
          ),
        ],
      ),
    );
  }
}
