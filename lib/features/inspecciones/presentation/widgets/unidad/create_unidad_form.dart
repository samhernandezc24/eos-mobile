import 'package:eos_mobile/core/common/data/catalogos/base_data.dart';
import 'package:eos_mobile/core/common/data/catalogos/unidad_marca_data.dart';
import 'package:eos_mobile/core/common/data/catalogos/unidad_tipo_data.dart';
import 'package:eos_mobile/core/common/widgets/controls/labeled_dropdown_form_field.dart';
import 'package:eos_mobile/core/common/widgets/controls/labeled_textarea_field.dart';
import 'package:eos_mobile/core/common/widgets/controls/loading_indicator.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/unidad/remote/remote_unidad_bloc.dart';
import 'package:eos_mobile/shared/shared.dart';

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

  final List<dynamic> lstUnidadesPlacasTipos  = <dynamic>[
    {'ea52bdfd-8af6-4f5a-b182-2b99e554eb31': 'Estatal'},
    {'ea52bdfd-8af6-4f5a-b182-2b99e554eb32': 'Federal'},
    {'ea52bdfd-8af6-4f5a-b182-2b99e554eb33': 'No aplica'},
  ];

  // PROPERTIES
  String? selectedTipoUnidadId;
  String? selectedTipoUnidadName;
  String? selectedBaseId;
  String? selectedBaseName;
  String? selectedUnidadMarcaId;
  String? selectedUnidadMarcaName;

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
      // numeroEconomico     : _numeroEconomicoController.text,
      // idBase              : selectedIdBase ?? '',
      // baseName            : selectedBaseName ?? '',
      // idUnidadTipo        : selectedIdUnidadTipo ?? '',
      // unidadTipoName      : unidadTipoName,
      // idUnidadMarca       : idUnidadMarca,
      // unidadMarcaName     : unidadMarcaName,
      // idUnidadPlacaTipo   : idUnidadPlacaTipo,
      // unidadPlacaTipoName : unidadPlacaTipoName,
      // placa               : placa,
      // numeroSerie         : numeroSerie,
      // modelo              : modelo,
      // anioEquipo          : anioEquipo,
      // descripcion         : descripcion,
      // capacidad           : capacidad,
      // odometro            : odometro,
      // horometro           : horometro,
      // numeroEconomico   : _numeroEconomicoController.text,
      // numeroSerie       : _numeroSerieController.text,
      // descripcion       : _descripcionController.text,
      // modelo            : _modeloController.text,
      // anioEquipo        : _anioEquipoController.text,
      // idBase            : selectedBaseId ?? '',
      // baseName          : selectedBaseName ?? '',
      // idUnidadMarca     : selectedUnidadMarcaId ?? '',
      // unidadMarcaName   : selectedUnidadMarcaName ?? '',
      // idUnidadTipo      : selectedTipoUnidadId ?? '',
      // unidadTipoName    : selectedTipoUnidadName ?? '',
      // capacidad         : capacidad ?? 0.0,
      // horometro         : horometro ?? 0,
      // odometro          : odometro ?? 0,
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
          LabeledTextField(
            autoFocus: true,
            controller: _numeroEconomicoController,
            labelText: '* Número económico:',
            hintText: 'Ingrese número económico...',
            validator: FormValidators.textValidator,
          ),

          Gap($styles.insets.sm),

          // SELECCIONAR EL TIPO DE UNIDAD:
          LabeledDropdownFormField(
            label: '* Tipo de unidad:',
            hintText: 'Seleccione',
            items: widget.unidadesTipos,
            itemBuilder: (unidadTipo) => Text(unidadTipo.name ?? ''),
            onChanged: (_){},
            validator: FormValidators.dropdownValidator,
            // onChanged: (newValue) {
            //   final selectedTipoUnidad = widget.unidadesTipos?.firstWhere((element) => element.idUnidadTipo == newValue);

            //   if (selectedTipoUnidad != null) {
            //     setState(() {
            //       selectedTipoUnidadId    = selectedTipoUnidad.idUnidadTipo;
            //       selectedTipoUnidadName  = selectedTipoUnidad.name;
            //     });
            //   }
            // },
          ),

          Gap($styles.insets.sm),

          // MARCA / MODELO DE LA UNIDAD:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: LabeledDropdownFormField(
                  label: '* Marca',
                  hintText: 'Seleccionar',
                  items: widget.unidadesMarcas,
                  itemBuilder: (unidadMarca) => Text(unidadMarca.name ?? ''),
                  onChanged: (_){},
                  validator: FormValidators.dropdownValidator,
                ),
              ),
              // Expanded(
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.stretch,
              //     children: <Widget>[
              //       Text('* Selecciona la marca:', style: $styles.textStyles.label),
              //       Gap($styles.insets.xs),
              //       DropdownButtonFormField<dynamic>(
              //         menuMaxHeight: 280,
              //         decoration: InputDecoration(
              //           contentPadding: EdgeInsets.symmetric(
              //             vertical: $styles.insets.sm - 3,
              //             horizontal: $styles.insets.xs + 2,
              //           ),
              //           hintText: 'Seleccione',
              //         ),
              //         items: state.unidadData?.unidadesMarcas
              //           .map<DropdownMenuItem<dynamic>>((unidadMarca) {
              //             return DropdownMenuItem<dynamic>(
              //               value: unidadMarca.idUnidadMarca,
              //               child: Text(unidadMarca.name ?? ''),
              //             );
              //           }).toList() ?? [],
              //         onChanged: (newValue) {
              //           final selectedUnidadMarca = state.unidadData?.unidadesMarcas.firstWhere((unidadMarca) => unidadMarca.idUnidadMarca == newValue);
              //           if (selectedUnidadMarca != null) {
              //             setState(() {
              //               selectedUnidadMarcaId    = selectedUnidadMarca.idUnidadMarca;
              //               selectedUnidadMarcaName  = selectedUnidadMarca.name;
              //               // print('ID: ${selectedUnidadMarca.idUnidadMarca}, Nombre: ${selectedUnidadMarca.name}');
              //             });
              //           }
              //         },
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox(width: $styles.insets.sm),
              Expanded(
                child: LabeledTextField(
                  controller: _modeloController,
                  labelText: '* Modelo:',
                  hintText: 'Ingrese el modelo...',
                  validator: FormValidators.textValidator,
                ),
              ),
            ],
          ),

          Gap($styles.insets.sm),

          // NO. DE SERIE:
          LabeledTextField(
            controller: _numeroSerieController,
            labelText: 'Número de serie:',
            hintText: 'Ingrese número serie...',
          ),

          Gap($styles.insets.sm),

          // CAPACIDAD / AÑO DEL EQUIPO
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: LabeledTextField(
                  controller: _capacidadController,
                  labelText: 'Capacidad:',
                  hintText: 'Ingrese cantidad',
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(width: $styles.insets.sm),
              Expanded(
                child: LabeledTextField(
                  controller: _anioEquipoController,
                  labelText: 'Año del equipo:',
                  hintText: 'Ingrese año de equipo...',
                ),
              ),
            ],
          ),

          Gap($styles.insets.sm),

          // SELECCIONAR BASE DE UNIDAD:
          LabeledDropdownFormField(
            label: '* Base',
            hintText: 'Seleccionar',
            items: widget.bases,
            itemBuilder: (base) => Text(base.name ?? ''),
            onChanged: (_) {},
            validator: FormValidators.dropdownValidator,
          ),
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.stretch,
          //   children: <Widget>[
          //     Text('* Selecciona la base:', style: $styles.textStyles.label),
          //     Gap($styles.insets.xs),
          //     DropdownButtonFormField<dynamic>(
          //       menuMaxHeight: 280,
          //       decoration: InputDecoration(
          //         contentPadding: EdgeInsets.symmetric(
          //           vertical: $styles.insets.sm - 3,
          //           horizontal: $styles.insets.xs + 2,
          //         ),
          //         hintText: 'Seleccione',
          //       ),
          //       items: state.unidadData?.bases
          //         .map<DropdownMenuItem<dynamic>>((base) {
          //           return DropdownMenuItem<dynamic>(
          //             value: base.idBase,
          //             child: Text(base.name ?? ''),
          //           );
          //         }).toList() ?? [],
          //       onChanged: (newValue) {
          //         final selectedBase = state.unidadData?.bases.firstWhere((base) => base.idBase == newValue);
          //         if (selectedBase != null) {
          //           setState(() {
          //             selectedBaseId    = selectedBase.idBase;
          //             selectedBaseName  = selectedBase.name;
          //             // print('ID: ${selectedBase.idBase}, Nombre: ${selectedBase.name}');
          //           });
          //         }
          //       },
          //     ),
          //   ],
          // ),

          Gap($styles.insets.sm),

          // HOROMETRO / ODOMETRO:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: LabeledTextField(
                  controller: _horometroController,
                  labelText: 'Horómetro:',
                  hintText: 'Ingrese cantidad',
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(width: $styles.insets.sm),
              Expanded(
                child: LabeledTextField(
                  controller: _odometroController,
                  labelText: 'Odómetro:',
                  hintText: 'Ingrese cantidad',
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),

          Gap($styles.insets.sm),

          // DESCRIPCIÓN
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
                    behavior: SnackBarBehavior.floating,
                    elevation: 0,
                  ),
                );
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
                  child: LoadingIndicator(
                    color: Theme.of(context).primaryColor,
                    width: 20,
                    height: 20,
                    strokeWidth: 2,
                  ),
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
