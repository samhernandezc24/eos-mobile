part of '../../../pages/list/list_page.dart';

class _CreateForm extends StatefulWidget {
  const _CreateForm({required this.buildDataSourceCallback, Key? key}) : super(key: key);

  final VoidCallback buildDataSourceCallback;

  @override
  State<_CreateForm> createState() => _CreateFormState();
}

class _CreateFormState extends State<_CreateForm> {
  // GLOBAL KEY
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // CONTROLLERS
  late final TextEditingController _fechaProgramadaController;
  late final TextEditingController _unidadNumeroEconomicoController;
  late final TextEditingController _unidadTipoNameController;
  late final TextEditingController _unidadMarcaNameController;
  late final TextEditingController _modeloController;
  late final TextEditingController _unidadPlacaTipoNameController;
  late final TextEditingController _placaController;
  late final TextEditingController _numeroSerieController;
  late final TextEditingController _anioEquipoController;
  late final TextEditingController _baseNameController;
  late final TextEditingController _locacionController;
  late final TextEditingController _tipoPlataformaController;
  late final TextEditingController _capacidadController;
  late final TextEditingController _unidadCapacidadMedidaNameController;
  late final TextEditingController _odometroController;
  late final TextEditingController _horometroController;

  // LIST
  List<InspeccionTipoEntity> lstInspeccionesTipos = <InspeccionTipoEntity>[];
  List<UnidadEntity> lstUnidades                  = <UnidadEntity>[];

  // SELECTED INSPECCION TIPO
  InspeccionTipoEntity? _selectedInspeccionTipo;

  // SELECTED UNIDAD (TEMPORAL / INVENTARIO)
  UnidadInspeccion? _selectedUnidadInspeccion;
  UnidadEntity? _selectedUnidad;

  @override
  void initState() {
    super.initState();
    context.read<RemoteInspeccionBloc>().add(FetchInspeccionCreate());
    context.read<RemoteUnidadBloc>().add(ListUnidades());

    _selectedUnidadInspeccion = UnidadInspeccion.inventario;

    _fechaProgramadaController            = TextEditingController();
    _unidadNumeroEconomicoController      = TextEditingController();
    _unidadTipoNameController             = TextEditingController();
    _unidadMarcaNameController            = TextEditingController();
    _modeloController                     = TextEditingController();
    _unidadPlacaTipoNameController        = TextEditingController();
    _placaController                      = TextEditingController();
    _numeroSerieController                = TextEditingController();
    _anioEquipoController                 = TextEditingController();
    _baseNameController                   = TextEditingController();
    _locacionController                   = TextEditingController();
    _tipoPlataformaController             = TextEditingController();
    _capacidadController                  = TextEditingController();
    _unidadCapacidadMedidaNameController  = TextEditingController();
    _odometroController                   = TextEditingController();
    _horometroController                  = TextEditingController();
  }

  @override
  void dispose() {
    _fechaProgramadaController.dispose();
    _unidadNumeroEconomicoController.dispose();
    _unidadTipoNameController.dispose();
    _unidadMarcaNameController.dispose();
    _modeloController.dispose();
    _unidadPlacaTipoNameController.dispose();
    _placaController.dispose();
    _numeroSerieController.dispose();
    _anioEquipoController.dispose();
    _baseNameController.dispose();
    _locacionController.dispose();
    _tipoPlataformaController.dispose();
    _capacidadController.dispose();
    _unidadCapacidadMedidaNameController.dispose();
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
                Navigator.of(context).pop();      // Cerrar página
                widget.buildDataSourceCallback(); // Ejecutar callback
              });
            },
            child : Text($strings.acceptButtonText, style: $styles.textStyles.button),
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

          return SlideTransition(position: animation.drive<Offset>(tween), child: const _CreateUnidadForm());
        },
        fullscreenDialog: true,
      ),
    );
  }

  void _handleSearchUnidadSubmitted(UnidadEntity? value) {
    setState(() {
      // UNIDAD SELECCIONADA:
      _selectedUnidad = value;

      if (_selectedUnidadInspeccion != UnidadInspeccion.temporal) {
        // Limpiar los controladores si la unidad no es temporal.
        _clearTextFields();
      } else {
        // Rellenar la información de los controles.
        _fillTextFields(value);
      }
    });
  }

  void _fillTextFields(UnidadEntity? value) {
    // RELLENAR LA INFORMACION DE LOS CONTROLES:
    _unidadNumeroEconomicoController.text       = value?.numeroEconomico            ?? '';
    _unidadTipoNameController.text              = value?.unidadTipoName             ?? '';
    _unidadMarcaNameController.text             = value?.unidadMarcaName            ?? '';
    _modeloController.text                      = value?.modelo                     ?? '';
    _unidadPlacaTipoNameController.text         = value?.unidadPlacaTipoName        ?? '';
    _placaController.text                       = value?.placa                      ?? '';
    _numeroSerieController.text                 = value?.numeroSerie                ?? '';
    _anioEquipoController.text                  = value?.anioEquipo                 ?? '';
    _baseNameController.text                    = value?.baseName                   ?? '';
    _capacidadController.text                   = value?.capacidad                  ?? '';
    _unidadCapacidadMedidaNameController.text   = value?.unidadCapacidadMedidaName  ?? '';
    _odometroController.text                    = value?.odometro                   ?? '';
    _horometroController.text                   = value?.horometro                  ?? '';
  }

  void _clearTextFields() {
    _unidadNumeroEconomicoController.clear();
    _unidadTipoNameController.clear();
    _unidadMarcaNameController.clear();
    _modeloController.clear();
    _unidadPlacaTipoNameController.clear();
    _placaController.clear();
    _numeroSerieController.clear();
    _anioEquipoController.clear();
    _baseNameController.clear();
    _capacidadController.clear();
    _unidadCapacidadMedidaNameController.clear();
    _odometroController.clear();
    _horometroController.clear();
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
        appBar  : AppBar(title: Text('Nueva inspección', style: $styles.textStyles.h3)),
        body    : SafeArea(
          child : SingleChildScrollView(
            padding : EdgeInsets.all($styles.insets.sm).copyWith(bottom: $styles.insets.lg),
            child   : Form(
              key   : _formKey,
              child : Column(
                crossAxisAlignment  : CrossAxisAlignment.stretch,
                children            : <Widget>[
                  // ALTERNAR ENTRE UNIDAD INVENTARIO / UNIDAD TEMPORAL:
                  _buildUnidadCheckbox(UnidadInspeccion.temporal, 'Unidad temporal'),

                  // SUGERENCIA:
                  RichText(
                    text: TextSpan(
                      style: $styles.textStyles.label.copyWith(color: Theme.of(context).colorScheme.onBackground),
                      children: <TextSpan>[
                        TextSpan(text: $strings.settingsSuggestionsText, style: const TextStyle(fontWeight: FontWeight.w600)),
                        TextSpan(text: ': ${$strings.inspectionSuggestionCreate}'),
                      ],
                    ),
                  ),

                  Gap($styles.insets.xs),

                  // BUSCAR Y SELECCIONAR UNIDAD:
                  if (_selectedUnidadInspeccion == UnidadInspeccion.temporal)
                    BlocBuilder<RemoteUnidadBloc, RemoteUnidadState>(
                      builder: (BuildContext context, RemoteUnidadState state) {
                        if (state is RemoteUnidadListLoading) {
                          return const Center(child: AppLoadingIndicator(width: 20, height: 20));
                        }

                        if (state is RemoteUnidadServerFailedMessageList) {
                          return ErrorBoxContainer(
                            errorMessage  : state.errorMessage ?? 'Se produjo un error al cargar el listado de unidades.',
                            onPressed     : () => context.read<RemoteUnidadBloc>().add(ListUnidades()),
                          );
                        }

                        if (state is RemoteUnidadServerFailureList) {
                          return ErrorBoxContainer(
                            errorMessage  : state.failure?.errorMessage ?? 'Se produjo un error al cargar el listado de unidades.',
                            onPressed     : () => context.read<RemoteUnidadBloc>().add(ListUnidades()),
                          );
                        }

                        if (state is RemoteUnidadListLoaded) {
                          lstUnidades = state.objResponse ?? [];
                          return Column(
                            crossAxisAlignment  : CrossAxisAlignment.start,
                            children            : <Widget>[
                              _SearchInputUnidad(onSelected: _handleSearchUnidadSubmitted, unidades: lstUnidades),
                            ],
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),

                  // NUEVA UNIDAD TEMPORAL:
                  AnimatedSwitcher(
                    duration: $styles.times.medium,
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      return FadeTransition(opacity: animation, child: SizeTransition(sizeFactor: animation, child: child));
                    },
                    child: _selectedUnidadInspeccion == UnidadInspeccion.temporal
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

                  // SELECCIONAR TIPO DE INSPECCIÓN:
                  BlocConsumer<RemoteInspeccionBloc, RemoteInspeccionState>(
                    listener: (BuildContext context, RemoteInspeccionState state) {
                      if (state is RemoteInspeccionCreateLoaded) {
                        lstInspeccionesTipos = state.objResponse?.inspeccionesTipos ?? [];
                      }
                    },
                    builder: (BuildContext context, RemoteInspeccionState state) {
                      if (state is RemoteInspeccionCreateLoading) {
                        return const Center(child: AppLoadingIndicator(width: 20, height: 20));
                      }

                      if (state is RemoteInspeccionServerFailedMessageCreate) {
                        return ErrorBoxContainer(
                          errorMessage  : state.errorMessage ?? 'Se produjo un error al cargar el listado de tipos de inspecciones.',
                          onPressed     : () => context.read<RemoteInspeccionBloc>().add(FetchInspeccionCreate()),
                        );
                      }

                      if (state is RemoteInspeccionServerFailureCreate) {
                        return ErrorBoxContainer(
                          errorMessage  : state.failure?.errorMessage ?? 'Se produjo un error al cargar el listado de tipos de inspecciones.',
                          onPressed     : () => context.read<RemoteInspeccionBloc>().add(FetchInspeccionCreate()),
                        );
                      }

                      if (state is RemoteInspeccionCreateLoaded) {
                        return LabeledDropdownFormField<InspeccionTipoEntity>(
                          label       : '* Tipo de inspección:',
                          items       : lstInspeccionesTipos,
                          itemBuilder : (item) => Text(item.name),
                          onChanged   : (value) => setState(() => _selectedInspeccionTipo = value),
                          validator   : FormValidators.dropdownValidator,
                          value       : _selectedInspeccionTipo,
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),

                  Gap($styles.insets.sm),

                  // FECHA PROGRAMADA:
                  LabeledDateTextFormField(
                    controller  : _fechaProgramadaController,
                    hintText    : 'dd/mm/aaaa',
                    label       : '* Fecha programada de inspección:',
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

                  // UNIDAD TIPO:
                  LabeledTextFormField(
                    controller  : _unidadTipoNameController,
                    isReadOnly  : true,
                    label       : '* Tipo de unidad:',
                    validator   : FormValidators.textValidator,
                  ),

                  Gap($styles.insets.sm),

                  // UNIDAD MARCA / MODELO:
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: LabeledTextFormField(
                          controller  : _unidadMarcaNameController,
                          isReadOnly  : true,
                          label       : '* Marca:',
                          validator   : FormValidators.textValidator,
                        ),
                      ),
                      Gap($styles.insets.sm),
                      Expanded(
                        child: LabeledTextFormField(
                          controller  : _modeloController,
                          isReadOnly  : true,
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

                  // NUMERO DE SERIE / AÑO DEL EQUIPO:
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

                  // BASE DE LA UNIDAD:
                  LabeledTextFormField(
                    controller  : _baseNameController,
                    isReadOnly  : true,
                    label       : '* Base:',
                    validator   : FormValidators.textValidator,
                  ),

                  Gap($styles.insets.sm),

                  // LOCACIÓN:
                  LabeledTextareaFormField(
                    controller    : _locacionController,
                    hintText      : 'Ingresa lugar de la inspección',
                    labelText     : '* Locación:',
                    maxLines      : 2,
                    maxCharacters : 300,
                    validator     : FormValidators.textValidator,
                  ),

                  Gap($styles.insets.sm),

                  // TIPO DE PLATAFORMA:
                  LabeledTextFormField(controller: _tipoPlataformaController, hintText: 'Ingresa tipo de plataforma', label: 'Tipo de plataforma (Si aplica):'),

                  Gap($styles.insets.sm),

                  // UNIDAD CAPACIDAD / CAPACIDAD MEDIDA:
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: LabeledTextFormField(
                          controller  : _capacidadController,
                          isReadOnly  : true,
                          label       : '* Capacidad:',
                          validator   : FormValidators.textValidator,
                        ),
                      ),
                      Gap($styles.insets.sm),
                      Expanded(
                        child: LabeledTextFormField(
                          controller  : _unidadCapacidadMedidaNameController,
                          isReadOnly  : true,
                          label       : '* Tipo de capacidad:',
                          validator   : FormValidators.textValidator,
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
                          label         : 'Odómetro (Si aplica):',
                          validator     : FormValidators.integerValidator,
                        ),
                      ),
                      Gap($styles.insets.sm),
                      Expanded(
                        child: LabeledTextFormField(
                          controller    : _horometroController,
                          hintText      : 'Ingresa cantidad',
                          keyboardType  : TextInputType.number,
                          label         : 'Horómetro (Si aplica):',
                          validator     : FormValidators.integerValidator,
                        ),
                      ),
                    ],
                  ),

                  Gap($styles.insets.lg),

                  FilledButton(
                    onPressed : (){},
                    style     : ButtonStyle(minimumSize: MaterialStateProperty.all<Size?>(const Size(double.infinity, 48))),
                    child     : Text($strings.saveButtonText, style: $styles.textStyles.button),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUnidadCheckbox(UnidadInspeccion unidadInspeccion, String value) {
    if (unidadInspeccion != UnidadInspeccion.temporal) return const SizedBox.shrink();

    final bool isSelectedUnidad = _selectedUnidadInspeccion == unidadInspeccion;

    void onCheckboxChanged(bool? value) {
      setState(() {
        _selectedUnidadInspeccion = value ?? false ? unidadInspeccion : null;
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
}
