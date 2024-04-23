import 'package:eos_mobile/core/common/data/catalogos/predictive_search_req.dart';
import 'package:eos_mobile/core/common/widgets/controls/error_box_container.dart';
import 'package:eos_mobile/core/common/widgets/controls/labeled_dropdown_form_field.dart';
import 'package:eos_mobile/core/common/widgets/controls/labeled_dropdown_form_search_field.dart';
import 'package:eos_mobile/core/common/widgets/controls/loading_indicator.dart';
import 'package:eos_mobile/core/enums/unidad_inspeccion_tipo.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad_inventario/unidad_inventario_entity.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/inspeccion/remote/remote_inspeccion_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/unidad_inventario/remote/remote_unidad_inventario_bloc.dart';
import 'package:eos_mobile/features/inspecciones/presentation/widgets/unidad/create_unidad_page.dart';
import 'package:eos_mobile/shared/shared.dart';
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
  late final TextEditingController _searchUnidadInventarioController;
  late final TextEditingController _fechaInspeccionController;
  late final TextEditingController _locacionController;

  /// LIST
  late List<InspeccionTipoEntity> lstInspeccionesTipos  = <InspeccionTipoEntity>[];
  late List<UnidadInventarioEntity> lstRows             = <UnidadInventarioEntity>[];

  /// PROPERTIES
  UnidadInspeccionTipo? _selectedUnidad;
  UnidadInventarioEntity? _selectedValue;

  @override
  void initState() {
    super.initState();
    context.read<RemoteInspeccionBloc>().add(CreateInspeccionData());

    _loadPredictiveSearch('');

    _selectedUnidad = UnidadInspeccionTipo.inventario;

    _searchUnidadInventarioController   = TextEditingController();
    _fechaInspeccionController          = TextEditingController(text: DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now()));
    _locacionController                 = TextEditingController();
  }

  @override
  void dispose() {
    _searchUnidadInventarioController.dispose();
    _fechaInspeccionController.dispose();
    _locacionController.dispose();
    super.dispose();
  }

  /// METHODS
  void _loadPredictiveSearch(String search) {
    final predictiveSearch = PredictiveSearchReqEntity(search: search);
    context.read<RemoteUnidadInventarioBloc>().add(PredictiveUnidadInventario(predictiveSearch));
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
                      'Se produjo un error al cargar el listado de tipos de inspecciones. Inténtalo de nuevo.',
                  onPressed: () => _loadPredictiveSearch(''),
                );
              }

              if (state is RemoteUnidadInventarioSuccess) {
                lstRows = state.unidades?.rows ?? [];

                return LabeledDropdownFormSearchField<UnidadInventarioEntity>(
                  label: '* Unidad:',
                  hintSearchText: 'Buscar unidad',
                  searchController: _searchUnidadInventarioController,
                  items: lstRows,
                  itemBuilder: (unidad) => Text(unidad.numeroEconomico ?? ''),
                  value: _selectedValue,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedValue = value;
                      });
                    }
                  },
                  searchMatchFn: (DropdownMenuItem<UnidadInventarioEntity> item, String searchValue) {
                    return item.value!.numeroEconomico!.toLowerCase().contains(searchValue.toLowerCase());
                  },
                  onMenuStateChange: (isOpen) {
                    if (!isOpen) {
                      _searchUnidadInventarioController.clear();
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
                  onChanged: (_) {},
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
        ],
      ),
    );
  }

  Widget _buildUnidadCheckbox(UnidadInspeccionTipo unidad, String label) {
    if (unidad == UnidadInspeccionTipo.temporal) {
      return GestureDetector(
        onTap: () {
          setState(() {
            _selectedUnidad = _selectedUnidad == unidad ? null : unidad;
          });
        },
        child: Row(
          children: <Widget>[
            Checkbox(
              value: _selectedUnidad == unidad,
              onChanged: (value) {
                setState(() {
                  _selectedUnidad = value! ? unidad : null;
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
