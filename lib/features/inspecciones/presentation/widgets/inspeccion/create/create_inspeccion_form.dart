import 'package:eos_mobile/core/common/data/catalogos/predictive_search_req.dart';
import 'package:eos_mobile/core/common/widgets/controls/error_box_container.dart';
import 'package:eos_mobile/core/common/widgets/controls/labeled_dropdown_form_field.dart';
import 'package:eos_mobile/core/common/widgets/controls/labeled_dropdown_form_search_field.dart';
import 'package:eos_mobile/core/common/widgets/controls/loading_indicator.dart';
import 'package:eos_mobile/core/enums/unidad_inspeccion_tipo.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad_inventario/unidad_inventario_entity.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/inspeccion/remote/remote_inspeccion_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/unidad/remote/remote_unidad_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/unidad_inventario/remote/remote_unidad_inventario_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/widgets/unidad/create_unidad_page.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:intl/intl.dart';

class CreateInspeccionForm extends StatefulWidget {
  const CreateInspeccionForm({Key? key}) : super(key: key);

  @override
  State<CreateInspeccionForm> createState() => _CreateInspeccionFormState();
}

class _CreateInspeccionFormState extends State<CreateInspeccionForm> {
  /// INSTANCES
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// CONTROLLERS
  late final TextEditingController _searchUnidadController;

  late final TextEditingController _fechaInspeccionController;
  late final TextEditingController _baseNameController;
  late final TextEditingController _numeroEconomicoController;
  late final TextEditingController _unidadTipoController;
  late final TextEditingController _marcaController;
  late final TextEditingController _placaTipoController;
  late final TextEditingController _placaController;
  late final TextEditingController _numeroSerieController;
  late final TextEditingController _modeloController;
  late final TextEditingController _anioEquipoController;
  late final TextEditingController _locacionController;
  late final TextEditingController _tipoPlataformaController;
  late final TextEditingController _capacidadController;
  late final TextEditingController _horometroController;
  late final TextEditingController _odometroController;

  /// LIST
  late List<InspeccionTipoEntity> lstInspeccionesTipos      = <InspeccionTipoEntity>[];
  late List<UnidadInventarioEntity> lstUnidadesInventarios  = <UnidadInventarioEntity>[];
  late List<UnidadEntity> lstUnidades                       = <UnidadEntity>[];

  /// PROPERTIES
  UnidadInspeccionTipo? _selectedUnidad;
  UnidadInventarioEntity? _selectedUnidadInventario;
  UnidadEntity? _selectedUnidadTemporal;

  String? selectedInspeccionTipoId;
  String? selectedInspeccionTipoCodigo;
  String? selectedInspeccionTipoName;

  String? selectedUnidadId;
  String? selectedUnidadIdBase;
  String? selectedUnidadBaseName;
  String? selectedUnidadNumeroEconomico;
  String? selectedUnidadIdTipo;
  String? selectedUnidadTipoName;
  String? selectedUnidadIdMarca;
  String? selectedUnidadMarcaName;
  String? selectedUnidadIdPlacaTipo;
  String? selectedUnidadPlacaTipoName;
  String? selectedUnidadPlaca;
  String? selectedUnidadNumeroSerie;
  String? selectedUnidadAnioEquipo;

  @override
  void initState() {
    super.initState();
    context.read<RemoteInspeccionBloc>().add(CreateInspeccionData());

    _loadPredictiveSearch('');
    _loadPredictiveUnidades('');

    _selectedUnidad = UnidadInspeccionTipo.inventario;

    _searchUnidadController             = TextEditingController();
    _fechaInspeccionController          = TextEditingController(text: DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now()));
    _baseNameController                 = TextEditingController();
    _numeroEconomicoController          = TextEditingController();
    _unidadTipoController               = TextEditingController();
    _marcaController                    = TextEditingController();
    _placaTipoController                = TextEditingController();
    _placaController                    = TextEditingController();
    _numeroSerieController              = TextEditingController();
    _modeloController                   = TextEditingController();
    _anioEquipoController               = TextEditingController();
    _locacionController                 = TextEditingController();
    _tipoPlataformaController           = TextEditingController();
    _capacidadController                = TextEditingController();
    _horometroController                = TextEditingController();
    _odometroController                 = TextEditingController();
  }

  @override
  void dispose() {
    _searchUnidadController.dispose();
    _baseNameController.dispose();
    _numeroEconomicoController.dispose();
    _unidadTipoController.dispose();
    _marcaController.dispose();
    _placaTipoController.dispose();
    _placaController.dispose();
    _numeroSerieController.dispose();
    _modeloController.dispose();
    _anioEquipoController.dispose();
    _locacionController.dispose();
    _tipoPlataformaController.dispose();
    _capacidadController.dispose();
    _horometroController.dispose();
    _odometroController.dispose();
    super.dispose();
  }

  /// METHODS
  Future<void> _showFailureDialog(BuildContext context, RemoteInspeccionFailure state) {
    return showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: const SizedBox.shrink(),
        content: Row(
          children: <Widget>[
            Icon(Icons.error, color: Theme.of(context).colorScheme.error),
            SizedBox(width: $styles.insets.xs + 2),
            Flexible(
              child: Text(
                state.failure?.errorMessage ?? 'Se produjo un error inesperado. Intenta crear la inspección de nuevo.',
                style: $styles.textStyles.title2.copyWith(
                  height: 1.5,
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => context.pop(),
            child: Text($strings.acceptButtonText, style: $styles.textStyles.button),
          ),
        ],
      ),
    );
  }

  Future<void> _showFailedMessageDialog(BuildContext context, RemoteInspeccionFailedMessage state) {
    return showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: const SizedBox.shrink(),
        content: Row(
          children: <Widget>[
            Icon(Icons.error, color: Theme.of(context).colorScheme.error),
            SizedBox(width: $styles.insets.xs + 2),
            Flexible(
              child: Text(
                state.errorMessage.toString(),
                style: $styles.textStyles.title2.copyWith(
                  height: 1.5,
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => context.pop(),
            child: Text($strings.acceptButtonText, style: $styles.textStyles.button),
          ),
        ],
      ),
    );
  }

  void _loadPredictiveSearch(String search) {
    final predictiveSearch = PredictiveSearchReqEntity(search: search);
    context.read<RemoteUnidadInventarioBloc>().add(PredictiveUnidadInventario(predictiveSearch));
  }

  void _loadPredictiveUnidades(String search) {
    final predictiveSearch = PredictiveSearchReqEntity(search: search);
    context.read<RemoteUnidadBloc>().add(PredictiveUnidad(predictiveSearch));
  }

  void _handleStoreInspeccion() {
    final DateTime fecha    = DateFormat('dd/MM/yyyy HH:mm').parse(_fechaInspeccionController.text);
    final double? capacidad = double.tryParse(_capacidadController.text);
    final int? odometro     = int.tryParse(_odometroController.text);
    final int? horometro    = int.tryParse(_horometroController.text);

    final InspeccionReqEntity objData = InspeccionReqEntity(
      fecha                       : fecha,
      idBase                      : selectedUnidadIdBase ?? '',
      baseName                    : selectedUnidadBaseName ?? '',
      idInspeccionTipo            : selectedInspeccionTipoId ?? '',
      inspeccionTipoCodigo        : selectedInspeccionTipoCodigo ?? '',
      inspeccionTipoName          : selectedInspeccionTipoName ?? '',
      idUnidad                    : selectedUnidadId ?? '',
      unidadNumeroEconomico       : _numeroEconomicoController.text,
      isUnidadTemporal            : _selectedUnidad == UnidadInspeccionTipo.temporal,
      idUnidadTipo                : selectedUnidadIdTipo ?? '',
      unidadTipoName              : selectedUnidadTipoName ?? '',
      idUnidadMarca               : selectedUnidadIdMarca ?? '',
      unidadMarcaName             : _marcaController.text,
      idUnidadPlacaTipo           : selectedUnidadIdPlacaTipo ?? '',
      unidadPlacaTipoName         : _placaTipoController.text,
      placa                       : _placaController.text,
      numeroSerie                 : _numeroSerieController.text,
      modelo                      : _modeloController.text,
      locacion                    : _locacionController.text,
      anioEquipo                  : _anioEquipoController.text,
      tipoPlataforma              : _tipoPlataformaController.text,
      capacidad                   : capacidad,
      odometro                    : odometro,
      horometro                   : horometro,
    );

    final bool isValidForm = _formKey.currentState!.validate();

    if (isValidForm) {
      _formKey.currentState!.save();
      BlocProvider.of<RemoteInspeccionBloc>(context).add(StoreInspeccion(objData));
    }
  }

  void _handleCreateUnidadPressed(BuildContext context) {
    Navigator.push<void>(
      context,
      PageRouteBuilder<void>(
        transitionDuration: $styles.times.pageTransition,
        pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
          const Offset begin  = Offset(0, 1);
          const Offset end    = Offset.zero;
          const Cubic curve   = Curves.ease;

          final Animatable<Offset> tween = Tween<Offset>(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive<Offset>(tween),
            child: const CreateUnidadPage(),
          );
        },
        fullscreenDialog: true,
      ),
    );
  }

  void _resetFields() {
    _searchUnidadController.clear();
    _baseNameController.clear();
    _numeroEconomicoController.clear();
    _unidadTipoController.clear();
    _marcaController.clear();
    _placaTipoController.clear();
    _placaController.clear();
    _numeroSerieController.clear();
    _modeloController.clear();
    _anioEquipoController.clear();
    _locacionController.clear();
    _tipoPlataformaController.clear();
    _capacidadController.clear();
    _horometroController.clear();
    _odometroController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // CHECKBOX PARA CAMBIAR ENTRE UNIDAD INVENTARIO / UNIDAD TEMPORAL:
          _buildUnidadCheckbox(UnidadInspeccionTipo.temporal, 'Unidad temporal'),

          Gap($styles.insets.xs),

          // SELECCIONAR Y BUSCAR UNIDAD A INSPECCIONAR:
          if (_selectedUnidad == UnidadInspeccionTipo.temporal)
            BlocBuilder<RemoteUnidadBloc, RemoteUnidadState>(
              builder: (BuildContext context, RemoteUnidadState state) {
                if (state is RemoteUnidadLoading) {
                  return Center(
                    child: LoadingIndicator(
                      color: Theme.of(context).primaryColor,
                      width: 20,
                      height: 20,
                      strokeWidth: 3,
                    ),
                  );
                }

                if (state is RemoteUnidadFailedMessage) {
                  return ErrorBoxContainer(
                    errorMessage: state.errorMessage ??
                        'Se produjo un error al cargar el listado de unidades. Inténtalo de nuevo.',
                    onPressed: () => _loadPredictiveUnidades(''),
                  );
                }

                if (state is RemoteUnidadFailure) {
                  return ErrorBoxContainer(
                    errorMessage: state.failure?.errorMessage ??
                        'Se produjo un error al cargar el listado de unidades. Inténtalo de nuevo.',
                    onPressed: () => _loadPredictiveUnidades(''),
                  );
                }

                if (state is RemoteUnidadSuccess) {
                  lstUnidades = state.unidades?.rows ?? [];

                  return LabeledDropdownFormSearchField<UnidadEntity>(
                    label: '* Unidad:',
                    hintSearchText: 'Buscar unidad',
                    searchController: _searchUnidadController,
                    items: lstUnidades,
                    itemBuilder: (unidad) => Text(unidad.numeroEconomico ?? ''),
                    value: _selectedUnidadTemporal,
                    onChanged: (newValue) {
                      setState(() {
                          _selectedUnidadTemporal       = newValue;
                          selectedUnidadId              = newValue?.idUnidad;
                          selectedUnidadIdBase          = newValue?.idBase;
                          selectedUnidadBaseName        = newValue?.baseName;
                          selectedUnidadNumeroEconomico = newValue?.numeroEconomico;
                          selectedUnidadIdTipo          = newValue?.idUnidadTipo;
                          selectedUnidadTipoName        = newValue?.unidadTipoName;
                          selectedUnidadIdMarca         = newValue?.idUnidadMarca;
                          selectedUnidadMarcaName       = newValue?.unidadMarcaName;
                          selectedUnidadIdPlacaTipo     = newValue?.idUnidadPlacaTipo;
                          selectedUnidadPlacaTipoName   = newValue?.unidadPlacaTipoName;
                          selectedUnidadPlaca           = newValue?.placa;
                          selectedUnidadNumeroSerie     = newValue?.numeroSerie;
                          selectedUnidadAnioEquipo      = newValue?.anioEquipo;

                          // Actualización de valores.
                          _baseNameController.text          = selectedUnidadBaseName ?? '';
                          _numeroEconomicoController.text   = selectedUnidadNumeroEconomico ?? '';
                          _unidadTipoController.text        = selectedUnidadTipoName ?? '';
                          _marcaController.text             = selectedUnidadMarcaName ?? '';
                          _placaTipoController.text         = selectedUnidadPlacaTipoName ?? '';
                          _placaController.text             = selectedUnidadPlaca ?? '';
                          _numeroSerieController.text       = selectedUnidadNumeroSerie ?? '';
                          _anioEquipoController.text        = selectedUnidadAnioEquipo ?? '';
                      });
                    },
                    searchMatchFn: (DropdownMenuItem<UnidadEntity> item, String searchValue) {
                      return item.value!.numeroEconomico!.toLowerCase().contains(searchValue.toLowerCase());
                    },
                    onMenuStateChange: (isOpen) {
                      if (!isOpen) {
                        _searchUnidadController.clear();
                      }
                    },
                    validator: FormValidators.dropdownValidator,
                  );
                }
                return const SizedBox.shrink();
              },
            )
          else
            BlocBuilder<RemoteUnidadInventarioBloc, RemoteUnidadInventarioState>(
              builder: (BuildContext context, RemoteUnidadInventarioState state) {
                if (state is RemoteUnidadInventarioLoading) {
                  return Center(
                    child: LoadingIndicator(
                      color: Theme.of(context).primaryColor,
                      width: 20,
                      height: 20,
                      strokeWidth: 3,
                    ),
                  );
                }

                if (state is RemoteUnidadInventarioFailedMessage) {
                  return ErrorBoxContainer(
                    errorMessage: state.errorMessage ??
                        'Se produjo un error al cargar el listado de unidades. Inténtalo de nuevo.',
                    onPressed: () => _loadPredictiveSearch(''),
                  );
                }

                if (state is RemoteUnidadInventarioFailure) {
                  return ErrorBoxContainer(
                    errorMessage: state.failure?.errorMessage ??
                        'Se produjo un error al cargar el listado de unidades. Inténtalo de nuevo.',
                    onPressed: () => _loadPredictiveSearch(''),
                  );
                }

                if (state is RemoteUnidadInventarioSuccess) {
                  lstUnidadesInventarios = state.unidades?.rows ?? [];

                  return LabeledDropdownFormSearchField<UnidadInventarioEntity>(
                    label: '* Unidad:',
                    hintSearchText: 'Buscar unidad',
                    searchController: _searchUnidadController,
                    items: lstUnidadesInventarios,
                    itemBuilder: (unidad) => Text(unidad.numeroEconomico ?? ''),
                    value: _selectedUnidadInventario,
                    onChanged: (newValue) {
                      setState(() {
                          _selectedUnidadInventario     = newValue;
                          selectedUnidadId              = newValue?.idUnidad;
                          selectedUnidadIdBase          = newValue?.idBase;
                          selectedUnidadBaseName        = newValue?.baseName;
                          selectedUnidadNumeroEconomico = newValue?.numeroEconomico;
                          selectedUnidadIdTipo          = newValue?.idUnidadTipo;
                          selectedUnidadTipoName        = newValue?.unidadTipoName;
                          selectedUnidadIdMarca         = '';
                          selectedUnidadMarcaName       = '';
                          selectedUnidadIdPlacaTipo     = '';
                          selectedUnidadPlacaTipoName   = '';
                          selectedUnidadPlaca           = '';
                          selectedUnidadNumeroSerie     = '';
                          selectedUnidadAnioEquipo      = '';

                          // Actualización de valores.
                          _baseNameController.text          = selectedUnidadBaseName ?? '';
                          _numeroEconomicoController.text   = selectedUnidadNumeroEconomico ?? '';
                          _unidadTipoController.text        = selectedUnidadTipoName ?? '';
                          _marcaController.text             = selectedUnidadMarcaName ?? '';
                          _placaTipoController.text         = selectedUnidadPlacaTipoName ?? '';
                          _placaController.text             = selectedUnidadPlaca ?? '';
                          _numeroSerieController.text       = selectedUnidadNumeroSerie ?? '';
                          _anioEquipoController.text        = selectedUnidadAnioEquipo ?? '';
                      });
                    },
                    searchMatchFn: (DropdownMenuItem<UnidadInventarioEntity> item, String searchValue) {
                      return item.value!.numeroEconomico!.toLowerCase().contains(searchValue.toLowerCase());
                    },
                    onMenuStateChange: (isOpen) {
                      if (!isOpen) {
                        _searchUnidadController.clear();
                      }
                    },
                    validator: FormValidators.dropdownValidator,
                  );
                }
                return const SizedBox.shrink();
              },
            ),

          // MOSTRAR BOTON PARA NUEVA UNIDAD CON ANIMACION:
          AnimatedSwitcher(
            duration: $styles.times.fast,
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: SizeTransition(sizeFactor: animation, child: child),
              );
            },
            child: _selectedUnidad == UnidadInspeccionTipo.temporal
                ? Padding(
                    padding: EdgeInsets.only(top: $styles.insets.sm),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FilledButton.icon(
                          onPressed: () => _handleCreateUnidadPressed(context),
                          icon: const Icon(Icons.add),
                          label: Text('Nueva unidad', style: $styles.textStyles.button),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ),

          Gap($styles.insets.sm),

          // SELECCIONAR EL TIPO DE INSPECCIÓN:
          BlocBuilder<RemoteInspeccionBloc, RemoteInspeccionState>(
            builder: (BuildContext context, RemoteInspeccionState state) {
              if (state is RemoteInspeccionLoading) {
                return Center(
                  child: LoadingIndicator(
                    color: Theme.of(context).primaryColor,
                    width: 20,
                    height: 20,
                    strokeWidth: 3,
                  ),
                );
              }

              if (state is RemoteInspeccionFailedMessage) {
                return ErrorBoxContainer(
                  errorMessage: state.errorMessage ??
                      'Se produjo un error al cargar el listado de tipos de inspecciones. Inténtalo de nuevo.',
                  onPressed: () => BlocProvider.of<RemoteInspeccionBloc>(context).add(CreateInspeccionData()),
                );
              }

              if (state is RemoteInspeccionFailure) {
                return ErrorBoxContainer(
                  errorMessage: state.failure?.errorMessage ??
                      'Se produjo un error al cargar el listado de tipos de inspecciones. Inténtalo de nuevo.',
                  onPressed: () => BlocProvider.of<RemoteInspeccionBloc>(context).add(CreateInspeccionData()),
                );
              }

              if (state is RemoteInspeccionCreateSuccess) {
                lstInspeccionesTipos = state.objInspeccion?.inspeccionesTipos ?? [];

                return LabeledDropdownFormField<InspeccionTipoEntity>(
                  label: '* Tipo de inspección:',
                  hintText: 'Seleccionar',
                  items: lstInspeccionesTipos,
                  itemBuilder: (inspeccionTipo) => Text(inspeccionTipo.name),
                  onChanged: (newValue) {
                    setState(() {
                      selectedInspeccionTipoId      = newValue?.idInspeccionTipo;
                      selectedInspeccionTipoCodigo  = newValue?.codigo;
                      selectedInspeccionTipoName    = newValue?.name;
                    });
                  },
                  validator: FormValidators.dropdownValidator,
                );
              }
              return const SizedBox.shrink();
            },
          ),

          Gap($styles.insets.sm),

          // FECHA DE LA INSPECCIÓN:
          LabeledTextField(
            controller: _fechaInspeccionController,
            isReadOnly: true,
            labelText: '* Fecha de la inspección:',
            textAlign: TextAlign.end,
          ),

          Gap($styles.insets.sm),

          // NO. ECONÓMICO
          LabeledTextField(
            controller: _numeroEconomicoController,
            labelText: '* No. económico:',
            isReadOnly: true,
            validator: FormValidators.textValidator,
          ),

          Gap($styles.insets.sm),

          // NO. ECONÓMICO
          LabeledTextField(
            controller: _unidadTipoController,
            labelText: '* Tipo de unidad:',
            isReadOnly: true,
            validator: FormValidators.textValidator,
          ),

          Gap($styles.insets.sm),

          // MARCA / MODELO DE LA UNIDAD
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: LabeledTextField(
                  controller: _marcaController,
                  labelText: 'Marca:',
                  isReadOnly: true,
                ),
              ),
              SizedBox(width: $styles.insets.sm),
              Expanded(
                child: LabeledTextField(
                  controller: _modeloController,
                  labelText: 'Modelo:',
                  isReadOnly: true,
                ),
              ),
            ],
          ),

          Gap($styles.insets.sm),

          // NO. DE SERIE
          LabeledTextField(
            controller: _numeroSerieController,
            isReadOnly: true,
            labelText: 'Número de serie:',
          ),

          Gap($styles.insets.sm),

           // NO. DE SERIE
          LabeledTextField(
            controller: _anioEquipoController,
            isReadOnly: true,
            labelText: 'Año del equipo:',
          ),

          Gap($styles.insets.sm),

          // PLACA TIPO / PLACA DE LA UNIDAD
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: LabeledTextField(
                  controller: _placaTipoController,
                  isReadOnly: true,
                  labelText: 'Tipo de placa:',
                ),
              ),
              SizedBox(width: $styles.insets.sm),
              Expanded(
                child: LabeledTextField(
                  controller: _placaController,
                  isReadOnly: true,
                  labelText: 'Placa:',
                ),
              ),
            ],
          ),

          Gap($styles.insets.sm),

          // LOCACIÓN
          LabeledTextField(
            controller: _locacionController,
            labelText: '* Locación:',
            validator: FormValidators.textValidator,
          ),

          Gap($styles.insets.sm),

          // BASE DE LA UNIDAD
          LabeledTextField(
            controller: _baseNameController,
            labelText: '* Base de la unidad:',
            isReadOnly: true,
            validator: FormValidators.textValidator,
          ),

          Gap($styles.insets.sm),

          // CAPACIDAD
          LabeledTextField(
            controller: _capacidadController,
            labelText: 'Capacidad:',
            keyboardType: TextInputType.number,
            validator: FormValidators.decimalValidator,
          ),

          Gap($styles.insets.sm),

          // HOROMETRO / ODOMETRO (SI APLICA)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: LabeledTextField(
                  controller: _horometroController,
                  labelText: 'Horómetro:',
                  keyboardType: TextInputType.number,
                  validator: FormValidators.integerValidator,
                ),
              ),
              SizedBox(width: $styles.insets.sm),
              Expanded(
                child: LabeledTextField(
                  controller: _odometroController,
                  labelText: 'Odómetro:',
                  keyboardType: TextInputType.number,
                  validator: FormValidators.integerValidator,
                ),
              ),
            ],
          ),

          Gap($styles.insets.lg),

          BlocConsumer<RemoteInspeccionBloc, RemoteInspeccionState>(
            listener: (BuildContext context, RemoteInspeccionState state) {
              if (state is RemoteInspeccionFailure) {
                _showFailureDialog(context, state);
              }

              if (state is RemoteInspeccionFailedMessage) {
                _showFailedMessageDialog(context, state);
              }

              if (state is RemoteInspeccionResponseSuccess) {
                Navigator.pop(context);

                ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(state.apiResponse.message, softWrap: true),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.fixed,
                    elevation: 0,
                  ),
                );
              }
            },
            builder: (BuildContext context, RemoteInspeccionState state) {
              if (state is RemoteInspeccionLoading) {
                return FilledButton(
                  onPressed: null,
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all<Size?>(
                      const Size(double.infinity, 48),
                    ),
                  ),
                  child: LoadingIndicator(
                    color: Theme.of(context).primaryColor,
                    width: 20,
                    height: 20,
                    strokeWidth: 2,
                  ),
                );
              }

              return FilledButton(
                onPressed: _handleStoreInspeccion,
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size?>(
                    const Size(double.infinity, 48),
                  ),
                ),
                child: Text($strings.saveButtonText, style: $styles.textStyles.button),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildUnidadCheckbox(UnidadInspeccionTipo unidad, String label) {
    if (unidad == UnidadInspeccionTipo.temporal) {
      return GestureDetector(
        onTap: () {
          setState(() {
            if (_selectedUnidad == unidad) {
              _selectedUnidad = null;
              _resetFields();
            } else {
              _selectedUnidad = unidad;
              _resetFields();
            }
          });
        },
        child: Row(
          children: <Widget>[
            Checkbox(
              value: _selectedUnidad == unidad,
              onChanged: (value) {
                setState(() {
                  if (value!) {
                    _selectedUnidad = unidad;
                    _resetFields();
                  } else {
                    _selectedUnidad = null;
                    _resetFields();
                  }
                });
              },
            ),
            Text(label, style: $styles.textStyles.label),
          ],
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
