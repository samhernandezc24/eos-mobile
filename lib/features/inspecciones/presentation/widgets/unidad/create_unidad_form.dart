import 'package:eos_mobile/core/common/data/catalogos/base_data.dart';
import 'package:eos_mobile/core/common/data/catalogos/predictive_search_req.dart';
import 'package:eos_mobile/core/common/data/catalogos/unidad_marca_data.dart';
import 'package:eos_mobile/core/common/data/catalogos/unidad_placa_tipo_data.dart';
import 'package:eos_mobile/core/common/data/catalogos/unidad_tipo_data.dart';
import 'package:eos_mobile/core/common/widgets/controls/error_box_container.dart';
import 'package:eos_mobile/core/common/widgets/controls/labeled_dropdown_form_search_field.dart';
import 'package:eos_mobile/core/common/widgets/controls/labeled_textarea_field.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/unidad/remote/remote_unidad_bloc.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';

class CreateUnidadForm extends StatefulWidget {
  const CreateUnidadForm({Key? key}) : super(key: key);

  @override
  State<CreateUnidadForm> createState() => _CreateUnidadFormState();
}

class _CreateUnidadFormState extends State<CreateUnidadForm> {
  // GENERAL INSTANCES
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // CONTROLLERS
  late final TextEditingController _searchUnidadTipoController;

  late final TextEditingController _numeroEconomicoController;
  late final TextEditingController _placaController;
  late final TextEditingController _numeroSerieController;
  late final TextEditingController _modeloController;
  late final TextEditingController _anioEquipoController;
  late final TextEditingController _descripcionController;
  late final TextEditingController _capacidadController;
  late final TextEditingController _odometroController;
  late final TextEditingController _horometroController;

  /// LIST
  late List<BaseDataEntity> lstBases                  = <BaseDataEntity>[];
  late List<UnidadMarcaDataEntity> lstUnidadesMarcas  = <UnidadMarcaDataEntity>[];
  late List<UnidadTipoDataEntity> lstUnidadesTipos    = <UnidadTipoDataEntity>[];

  final List<UnidadPlacaTipoData> lstUnidadesPlacasTipos = [
    UnidadPlacaTipoData(idUnidadPlacaTipo: 'ea52bdfd-8af6-4f5a-b182-2b99e554eb31', name: 'Estatal'),
    UnidadPlacaTipoData(idUnidadPlacaTipo: 'ea52bdfd-8af6-4f5a-b182-2b99e554eb32', name: 'Federal'),
    UnidadPlacaTipoData(idUnidadPlacaTipo: 'ea52bdfd-8af6-4f5a-b182-2b99e554eb33', name: 'No aplica'),
  ];

  // PROPERTIES
  UnidadTipoDataEntity? _selectedValue;

  String? _selectedIdBase;
  String? _selectedBaseName;
  String? _selectedIdUnidadTipo;
  String? _selectedUnidadTipoName;
  String? _selectedIdUnidadMarca;
  String? _selectedUnidadMarcaName;
  String? _selectedIdUnidadPlacaTipo;
  String? _selectedUnidadPlacaTipoName;


  @override
  void initState() {
    super.initState();
    context.read<RemoteUnidadBloc>().add(CreateUnidad());

    _searchUnidadTipoController   = TextEditingController();
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
    _searchUnidadTipoController.dispose();
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
  Future<void> _showFailureDialog(BuildContext context, RemoteUnidadFailure state) {
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
                state.failure?.errorMessage ?? 'Se produjo un error inesperado. Intenta crear la unidad de nuevo.',
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

  Future<void> _showFailedMessageDialog(BuildContext context, RemoteUnidadFailedMessage state) {
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

  void _handleStoreUnidad() {
    final double? capacidad = double.tryParse(_capacidadController.text);
    final int? odometro     = int.tryParse(_odometroController.text);
    final int? horometro    = int.tryParse(_horometroController.text);

    final UnidadReqEntity objData = UnidadReqEntity(
      numeroEconomico     : _numeroEconomicoController.text,
      idBase              : _selectedIdBase ?? '',
      baseName            : _selectedBaseName ?? '',
      idUnidadTipo        : _selectedIdUnidadTipo ?? '',
      unidadTipoName      : _selectedUnidadTipoName ?? '',
      idUnidadMarca       : _selectedIdUnidadMarca ?? '',
      unidadMarcaName     : _selectedUnidadMarcaName ?? '',
      idUnidadPlacaTipo   : _selectedIdUnidadPlacaTipo ?? '',
      unidadPlacaTipoName : _selectedUnidadPlacaTipoName ?? '',
      placa               : _placaController.text,
      numeroSerie         : _numeroSerieController.text,
      modelo              : _modeloController.text,
      anioEquipo          : _anioEquipoController.text,
      descripcion         : _descripcionController.text,
      capacidad           : capacidad,
      odometro            : odometro,
      horometro           : horometro,
    );

    final bool isValidForm = _formKey.currentState!.validate();

    if (isValidForm) {
      _formKey.currentState!.save();
      BlocProvider.of<RemoteUnidadBloc>(context).add(StoreUnidad(objData));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          // NÚMERO ECONÓMICO:
          LabeledTextFormField(
            autoFocus: true,
            controller: _numeroEconomicoController,
            label: '* Número económico:',
            hintText: 'Ingrese número económico...',
            validator: FormValidators.textValidator,
          ),

          Gap($styles.insets.sm),

          // SELECCIONAR BASE DE UNIDAD:
          BlocBuilder<RemoteUnidadBloc, RemoteUnidadState>(
            builder: (BuildContext context, RemoteUnidadState state) {
              if (state is RemoteUnidadLoading) {
                return const Center(
                  child: AppLoadingIndicator(width: 20, height: 20),
                );
              }

              if (state is RemoteUnidadFailedMessage) {
                return ErrorBoxContainer(
                  errorMessage: state.errorMessage ??
                      'Se produjo un error al cargar el listado de bases. Inténtalo de nuevo.',
                  onPressed: () => BlocProvider.of<RemoteUnidadBloc>(context).add(CreateUnidad()),
                );
              }

              if (state is RemoteUnidadFailure) {
                return ErrorBoxContainer(
                  errorMessage: state.failure?.errorMessage ??
                      'Se produjo un error al cargar el listado de bases. Inténtalo de nuevo.',
                  onPressed: () => BlocProvider.of<RemoteUnidadBloc>(context).add(CreateUnidad()),
                );
              }

              if (state is RemoteUnidadCreateSuccess) {
                lstBases = state.unidadData?.bases ?? [];

                return LabeledDropdownFormField(
                  label: '* Base:',
                  hintText: 'Seleccionar',
                  items: lstBases,
                  itemBuilder: (base) => Text(base.name ?? ''),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedIdBase    = newValue?.idBase;
                      _selectedBaseName  = newValue?.name;
                    });
                  },
                  validator: FormValidators.dropdownValidator,
                );
              }
              return const SizedBox.shrink();
            },
          ),

          Gap($styles.insets.sm),

          // SELECCIONAR EL TIPO DE UNIDAD:
          BlocBuilder<RemoteUnidadBloc, RemoteUnidadState>(
            builder: (BuildContext context, RemoteUnidadState state) {
              if (state is RemoteUnidadLoading) {
                return const Center(
                  child: AppLoadingIndicator(width: 20, height: 20),
                );
              }

              if (state is RemoteUnidadFailedMessage) {
                return ErrorBoxContainer(
                  errorMessage: state.errorMessage ??
                      'Se produjo un error al cargar el listado de tipos de unidades. Inténtalo de nuevo.',
                  onPressed: () => BlocProvider.of<RemoteUnidadBloc>(context).add(CreateUnidad()),
                );
              }

              if (state is RemoteUnidadFailure) {
                return ErrorBoxContainer(
                  errorMessage: state.failure?.errorMessage ??
                      'Se produjo un error al cargar el listado de tipos de unidades. Inténtalo de nuevo.',
                  onPressed: () => BlocProvider.of<RemoteUnidadBloc>(context).add(CreateUnidad()),
                );
              }

              if (state is RemoteUnidadCreateSuccess) {
                lstUnidadesTipos = state.unidadData?.unidadesTipos ?? [];

                return LabeledDropdownFormSearchField<UnidadTipoDataEntity>(
                  label: '* Tipo de unidad:',
                  hintSearchText: 'Buscar tipo de unidad',
                  searchController: _searchUnidadTipoController,
                  items: lstUnidadesTipos,
                  itemBuilder: (unidadTipo) => Text(unidadTipo.name ?? ''),
                  value: _selectedValue,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedValue          = newValue;
                      _selectedIdUnidadTipo   = newValue?.idUnidadTipo;
                      _selectedUnidadTipoName = newValue?.name;
                    });
                  },
                  searchMatchFn: (DropdownMenuItem<UnidadTipoDataEntity> item, String searchValue) {
                    return item.value!.name!.toLowerCase().contains(searchValue.toLowerCase());
                  },
                  onMenuStateChange: (isOpen) {
                    if (!isOpen) {
                      _searchUnidadTipoController.clear();
                    }
                  },
                  validator: FormValidators.dropdownValidator,
                );
              }
              return const SizedBox.shrink();
            },
          ),

          Gap($styles.insets.sm),

          // MARCA / MODELO DE LA UNIDAD:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: BlocBuilder<RemoteUnidadBloc, RemoteUnidadState>(
                  builder: (BuildContext context, RemoteUnidadState state) {
                    if (state is RemoteUnidadLoading) {
                      return const Center(
                        child: AppLoadingIndicator(width: 20, height: 20),
                      );
                    }

                    if (state is RemoteUnidadFailedMessage) {
                      return ErrorBoxContainer(
                        errorMessage: state.errorMessage ??
                            'Se produjo un error al cargar el listado de unidades marcas. Inténtalo de nuevo.',
                        onPressed: () => BlocProvider.of<RemoteUnidadBloc>(context).add(CreateUnidad()),
                      );
                    }

                    if (state is RemoteUnidadFailure) {
                      return ErrorBoxContainer(
                        errorMessage: state.failure?.errorMessage ??
                            'Se produjo un error al cargar el listado de unidades marcas. Inténtalo de nuevo.',
                        onPressed: () => BlocProvider.of<RemoteUnidadBloc>(context).add(CreateUnidad()),
                      );
                    }

                    if (state is RemoteUnidadCreateSuccess) {
                      lstUnidadesMarcas = state.unidadData?.unidadesMarcas ?? [];

                      return LabeledDropdownFormField(
                        label: 'Marca:',
                        hintText: 'Seleccionar',
                        items: lstUnidadesMarcas,
                        itemBuilder: (unidadMarca) => Text(unidadMarca.name ?? ''),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedIdUnidadMarca    = newValue?.idUnidadMarca;
                            _selectedUnidadMarcaName  = newValue?.name;
                          });
                        },
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),

              SizedBox(width: $styles.insets.sm),
              Expanded(
                child: LabeledTextFormField(
                  controller: _modeloController,
                  label: 'Modelo:',
                  hintText: 'Ingrese el modelo...',
                ),
              ),
            ],
          ),

          Gap($styles.insets.sm),

          // TIPO DE PLACA:
          LabeledDropdownFormField<UnidadPlacaTipoData>(
            label: 'Tipo de placa:',
            hintText: 'Seleccionar',
            items: lstUnidadesPlacasTipos,
            itemBuilder: (unidadPlacaTipo) => Text(unidadPlacaTipo.name ?? ''),
            onChanged: (newValue) {
              setState(() {
                _selectedIdUnidadPlacaTipo    = newValue?.idUnidadPlacaTipo ?? '';
                _selectedUnidadPlacaTipoName  = newValue?.name ?? '';
              });
            },
          ),

          Gap($styles.insets.sm),

          // PLACA / NO. DE SERIE:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: LabeledTextFormField(
                  controller: _placaController,
                  label: 'Placa:',
                  hintText: 'Ingrese placa...',
                ),
              ),
              SizedBox(width: $styles.insets.sm),
              Expanded(
                child: LabeledTextFormField(
                  controller: _numeroSerieController,
                  label: 'Número de serie:',
                  hintText: 'Ingrese número serie...',
                ),
              ),
            ],
          ),

          Gap($styles.insets.sm),

          // CAPACIDAD / AÑO DEL EQUIPO
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: LabeledTextFormField(
                  controller: _capacidadController,
                  label: 'Capacidad:',
                  hintText: 'Ingrese cantidad',
                  keyboardType: TextInputType.number,
                  validator: FormValidators.decimalValidator,
                ),
              ),
              SizedBox(width: $styles.insets.sm),
              Expanded(
                child: LabeledTextFormField(
                  controller: _anioEquipoController,
                  label: 'Año del equipo:',
                  hintText: 'Ingrese año de equipo...',
                ),
              ),
            ],
          ),

          Gap($styles.insets.sm),

          // ODOMETRO / HOROMETRO:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: LabeledTextFormField(
                  controller: _odometroController,
                  label: 'Odómetro:',
                  hintText: 'Ingrese cantidad',
                  keyboardType: TextInputType.number,
                  validator: FormValidators.integerValidator,
                ),
              ),
              SizedBox(width: $styles.insets.sm),
              Expanded(
                child: LabeledTextFormField(
                  controller: _horometroController,
                  label: 'Horómetro:',
                  hintText: 'Ingrese cantidad',
                  keyboardType: TextInputType.number,
                  validator: FormValidators.integerValidator,
                ),
              ),
            ],
          ),

          Gap($styles.insets.sm),

          // DESCRIPCIÓN:
          LabeledTextAreaField(
            controller: _descripcionController,
            labelText: 'Descripción de la unidad (opcional):',
            hintText: 'Ingrese descripción...',
            textInputAction: TextInputAction.done,
            maxLines: 2,
            maxCharacters: 300,
          ),

          Gap($styles.insets.md),

          BlocConsumer<RemoteUnidadBloc, RemoteUnidadState>(
            listener: (BuildContext context, RemoteUnidadState state) {
              if (state is RemoteUnidadFailure) {
                _showFailureDialog(context, state);
              }

              if (state is RemoteUnidadFailedMessage) {
                _showFailedMessageDialog(context, state);
              }

              if (state is RemoteUnidadResponseSuccess) {
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

                const predictiveSearch = PredictiveSearchReqEntity(search: '');
                context.read<RemoteUnidadBloc>().add(const PredictiveUnidad(predictiveSearch));
              }
            },
            builder: (BuildContext context, RemoteUnidadState state) {
              if (state is RemoteUnidadLoading) {
                return FilledButton(
                  onPressed: null,
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all<Size?>(
                      const Size(double.infinity, 48),
                    ),
                  ),
                  child: const AppLoadingIndicator(width: 20, height: 20),
                );
              }

              return FilledButton(
                onPressed: _handleStoreUnidad,
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
}
