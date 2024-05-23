part of '../../../pages/list/list_page.dart';

class _CreateUnidadForm extends StatefulWidget {
  const _CreateUnidadForm({Key? key}) : super(key: key);

  @override
  State<_CreateUnidadForm> createState() => _CreateUnidadFormState();
}

class _CreateUnidadFormState extends State<_CreateUnidadForm> {
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
  List<Base> lstBases                                       = <Base>[];
  List<UnidadCapacidadMedida> lstUnidadCapacidadesMedidas   = <UnidadCapacidadMedida>[];
  List<UnidadMarca> lstUnidadesMarcas                       = <UnidadMarca>[];
  List<UnidadTipo> lstUnidadesTipos                         = <UnidadTipo>[];

  final List<UnidadPlacaTipo> lstUnidadesPlacasTipos = <UnidadPlacaTipo>[
    const UnidadPlacaTipo(idUnidadPlacaTipo: 'ea52bdfd-8af6-4f5a-b182-2b99e554eb31', name: 'Estatal'),
    const UnidadPlacaTipo(idUnidadPlacaTipo: 'ea52bdfd-8af6-4f5a-b182-2b99e554eb32', name: 'Federal'),
    const UnidadPlacaTipo(idUnidadPlacaTipo: 'ea52bdfd-8af6-4f5a-b182-2b99e554eb33', name: 'No aplica'),
  ];

  // SELECTED UNIDAD PLACA TIPO
  UnidadPlacaTipo? _selectedUnidadPlacaTipo;

  // SELECTED UNIDAD MARCA
  UnidadMarca? _selectedUnidadMarca;

  // SELECTED UNIDAD TIPO
  UnidadTipo? _selectedUnidadTipo;

  // SELECTED BASE
  Base? _selectedBase;

  // SELECTED UNIDAD CAPACIDAD MEDIDA
  UnidadCapacidadMedida? _selectedUnidadCapacidadMedida;

  @override
  void initState() {
    super.initState();
    context.read<RemoteUnidadBloc>().add(FetchUnidadCreate());

    _numeroEconomicoController  = TextEditingController();
    _placaController            = TextEditingController();
    _numeroSerieController      = TextEditingController();
    _modeloController           = TextEditingController();
    _anioEquipoController       = TextEditingController();
    _descripcionController      = TextEditingController();
    _capacidadController        = TextEditingController();
    _odometroController         = TextEditingController();
    _horometroController        = TextEditingController();
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
              Navigator.of(context).pop(); // Cerrar página
              // Ejecutar el callback una vez finalizada la acción pop.
              // WidgetsBinding.instance.addPostFrameCallback((_) {
              //   Navigator.of(context).pop();      // Cerrar página
              //   widget.buildDataSourceCallback(); // Ejecutar callback
              // });
            },
            child : Text($strings.acceptButtonText, style: $styles.textStyles.button),
          ),
        ],
      ),
    );
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
        appBar  : AppBar(title: Text('Nueva unidad', style: $styles.textStyles.h3)),
        body    : SafeArea(
          child : SingleChildScrollView(
            padding : EdgeInsets.all($styles.insets.sm).copyWith(bottom: $styles.insets.lg),
            child   : Form(
              key   : _formKey,
              child : Column(
                crossAxisAlignment  : CrossAxisAlignment.stretch,
                children            : <Widget>[
                  // UNIDAD NUMERO ECONOMICO:
                  LabeledTextFormField(
                    autoFocus   : true,
                    controller  : _numeroEconomicoController,
                    hintText    : 'Ingrese número económico',
                    label       : '* Número económico:',
                    validator   : FormValidators.textValidator,
                  ),

                  Gap($styles.insets.sm),

                  // MODELO:
                  LabeledTextFormField(
                    controller  : _modeloController,
                    hintText    : 'Ingrese modelo',
                    label       : '* Modelo:',
                    validator   : FormValidators.textValidator,
                  ),

                  Gap($styles.insets.sm),

                  // NUMERO DE SERIE:
                  LabeledTextFormField(
                    controller  : _numeroSerieController,
                    hintText    : 'Ingrese número de serie',
                    label       : '* Número de serie:',
                    validator   : FormValidators.textValidator,
                  ),

                  Gap($styles.insets.sm),

                  // SELECCIONAR MARCA:
                  BlocConsumer<RemoteUnidadBloc, RemoteUnidadState>(
                    listener: (BuildContext context, RemoteUnidadState state) {
                      if (state is RemoteUnidadCreateLoaded) {
                        lstUnidadesMarcas = state.objResponse?.unidadesMarcas ?? [];
                      }
                    },
                    builder: (BuildContext context, RemoteUnidadState state) {
                      if (state is RemoteUnidadCreateLoading) {
                        return const Center(child: AppLoadingIndicator(width: 20, height: 20));
                      }

                      if (state is RemoteUnidadServerFailedMessageCreate) {
                        return ErrorBoxContainer(
                          errorMessage  : state.errorMessage ?? 'Se produjo un error al cargar el listado de marcas.',
                          onPressed     : () => context.read<RemoteUnidadBloc>().add(FetchUnidadCreate()),
                        );
                      }

                      if (state is RemoteUnidadServerFailureCreate) {
                        return ErrorBoxContainer(
                          errorMessage  : state.failure?.errorMessage ?? 'Se produjo un error al cargar el listado de marcas.',
                          onPressed     : () => context.read<RemoteUnidadBloc>().add(FetchUnidadCreate()),
                        );
                      }

                      if (state is RemoteUnidadCreateLoaded) {
                        return LabeledDropdownFormField<UnidadMarca>(
                          label       : '* Marca:',
                          items       : lstUnidadesMarcas,
                          itemBuilder : (item) => Text(item.name ?? ''),
                          onChanged   : (value) => setState(() => _selectedUnidadMarca = value),
                          validator   : FormValidators.dropdownValidator,
                          value       : _selectedUnidadMarca,
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),

                  Gap($styles.insets.sm),

                  // SELECCIONAR UNIDAD TIPO:
                  BlocConsumer<RemoteUnidadBloc, RemoteUnidadState>(
                    listener: (BuildContext context, RemoteUnidadState state) {
                      if (state is RemoteUnidadCreateLoaded) {
                        lstUnidadesTipos = state.objResponse?.unidadesTipos ?? [];
                      }
                    },
                    builder: (BuildContext context, RemoteUnidadState state) {
                      if (state is RemoteUnidadCreateLoading) {
                        return const Center(child: AppLoadingIndicator(width: 20, height: 20));
                      }

                      if (state is RemoteUnidadServerFailedMessageCreate) {
                        return ErrorBoxContainer(
                          errorMessage  : state.errorMessage ?? 'Se produjo un error al cargar el listado de tipos de unidad.',
                          onPressed     : () => context.read<RemoteUnidadBloc>().add(FetchUnidadCreate()),
                        );
                      }

                      if (state is RemoteUnidadServerFailureCreate) {
                        return ErrorBoxContainer(
                          errorMessage  : state.failure?.errorMessage ?? 'Se produjo un error al cargar el listado de tipos de unidad.',
                          onPressed     : () => context.read<RemoteUnidadBloc>().add(FetchUnidadCreate()),
                        );
                      }

                      if (state is RemoteUnidadCreateLoaded) {
                        return LabeledDropdownFormField<UnidadTipo>(
                          label       : '* Tipo de unidad:',
                          items       : lstUnidadesTipos,
                          itemBuilder : (item) => Text(item.name ?? ''),
                          onChanged   : (value) => setState(() => _selectedUnidadTipo = value),
                          validator   : FormValidators.dropdownValidator,
                          value       : _selectedUnidadTipo,
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),

                  Gap($styles.insets.sm),

                  // UNIDAD PLACA TIPO / PLACA:
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: LabeledTextFormField(
                          controller  : _placaController,
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

                  // AÑO DEL EQUIPO:
                  LabeledTextFormField(
                    controller  : _anioEquipoController,
                    label       : 'Año del equipo:',
                    validator   : FormValidators.textValidator,
                  ),

                  Gap($styles.insets.sm),

                  // SELECCIONAR BASE:
                  BlocConsumer<RemoteUnidadBloc, RemoteUnidadState>(
                    listener: (BuildContext context, RemoteUnidadState state) {
                      if (state is RemoteUnidadCreateLoaded) {
                        lstBases = state.objResponse?.bases ?? [];
                      }
                    },
                    builder: (BuildContext context, RemoteUnidadState state) {
                      if (state is RemoteUnidadCreateLoading) {
                        return const Center(child: AppLoadingIndicator(width: 20, height: 20));
                      }

                      if (state is RemoteUnidadServerFailedMessageCreate) {
                        return ErrorBoxContainer(
                          errorMessage  : state.errorMessage ?? 'Se produjo un error al cargar el listado de bases.',
                          onPressed     : () => context.read<RemoteUnidadBloc>().add(FetchUnidadCreate()),
                        );
                      }

                      if (state is RemoteUnidadServerFailureCreate) {
                        return ErrorBoxContainer(
                          errorMessage  : state.failure?.errorMessage ?? 'Se produjo un error al cargar el listado de bases.',
                          onPressed     : () => context.read<RemoteUnidadBloc>().add(FetchUnidadCreate()),
                        );
                      }

                      if (state is RemoteUnidadCreateLoaded) {
                        return LabeledDropdownFormField<Base>(
                          label       : '* Base:',
                          items       : lstBases,
                          itemBuilder : (item) => Text(item.name ?? ''),
                          onChanged   : (value) => setState(() => _selectedBase = value),
                          validator   : FormValidators.dropdownValidator,
                          value       : _selectedBase,
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),

                  Gap($styles.insets.sm),

                  // LOCACIÓN:
                  LabeledTextareaFormField(
                    controller    : _descripcionController,
                    hintText      : 'Ingrese descripción de creación de unidad',
                    labelText     : 'Descripción (opcional):',
                    maxLines      : 2,
                    maxCharacters : 300,
                  ),

                  Gap($styles.insets.sm),

                  // UNIDAD CAPACIDAD / SELECCIONAR CAPACIDAD MEDIDA:
                  Row(
                    children: <Widget>[
                      Expanded(
                        child : LabeledTextFormField(
                          controller    : _capacidadController,
                          hintText      : 'Ingrese cantidad',
                          label         : '* Capacidad:',
                          keyboardType  : TextInputType.number,
                          validator     : FormValidators.decimalValidator,
                        ),
                      ),
                      Gap($styles.insets.sm),
                      Expanded(
                        child: BlocConsumer<RemoteUnidadBloc, RemoteUnidadState>(
                          listener: (BuildContext context, RemoteUnidadState state) {
                            if (state is RemoteUnidadCreateLoaded) {
                              lstUnidadCapacidadesMedidas = state.objResponse?.unidadesCapacidadesMedidas ?? [];
                            }
                          },
                          builder: (BuildContext context, RemoteUnidadState state) {
                            if (state is RemoteUnidadCreateLoading) {
                              return const Center(child: AppLoadingIndicator(width: 20, height: 20));
                            }

                            if (state is RemoteUnidadServerFailedMessageCreate) {
                              return ErrorBoxContainer(
                                errorMessage  : state.errorMessage ?? 'Se produjo un error al cargar el listado de unidades capacidades medidas.',
                                onPressed     : () => context.read<RemoteUnidadBloc>().add(FetchUnidadCreate()),
                              );
                            }

                            if (state is RemoteUnidadServerFailureCreate) {
                              return ErrorBoxContainer(
                                errorMessage  : state.failure?.errorMessage ?? 'Se produjo un error al cargar el listado de unidades capacidades medidas.',
                                onPressed     : () => context.read<RemoteUnidadBloc>().add(FetchUnidadCreate()),
                              );
                            }

                            if (state is RemoteUnidadCreateLoaded) {
                              return LabeledDropdownFormField<UnidadCapacidadMedida>(
                                label       : '* Tipo de capacidad:',
                                items       : lstUnidadCapacidadesMedidas,
                                itemBuilder : (item) => Text(item.name ?? ''),
                                onChanged   : (value) => setState(() => _selectedUnidadCapacidadMedida = value),
                                validator   : FormValidators.dropdownValidator,
                                value       : _selectedUnidadCapacidadMedida,
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
                          hintText      : 'Ingrese cantidad',
                          keyboardType  : TextInputType.number,
                          label         : 'Odómetro (Si aplica):',
                          validator     : FormValidators.integerValidator,
                        ),
                      ),
                      Gap($styles.insets.sm),
                      Expanded(
                        child: LabeledTextFormField(
                          controller      : _horometroController,
                          hintText        : 'Ingrese cantidad',
                          keyboardType    : TextInputType.number,
                          label           : 'Horómetro (Si aplica):',
                          textInputAction : TextInputAction.done,
                          validator       : FormValidators.integerValidator,
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
}
