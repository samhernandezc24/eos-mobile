import 'package:eos_mobile/core/common/data/catalogos/base_data.dart';
import 'package:eos_mobile/core/common/data/catalogos/unidad_marca_data.dart';
import 'package:eos_mobile/core/common/data/catalogos/unidad_tipo_data.dart';
import 'package:eos_mobile/core/common/widgets/controls/labeled_textarea_field.dart';
import 'package:eos_mobile/core/common/widgets/controls/loading_indicator.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/unidad/remote/remote_unidad_bloc.dart';
import 'package:eos_mobile/shared/shared.dart';

class CreateUnidadForm extends StatefulWidget {
  const CreateUnidadForm({super.key});

  @override
  State<CreateUnidadForm> createState() => _CreateUnidadFormState();
}

class _CreateUnidadFormState extends State<CreateUnidadForm> {
  // GENERAL INSTANCES
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // CONTROLLERS
  late final TextEditingController _numeroEconomicoController;
  late final TextEditingController _numeroSerieController;
  late final TextEditingController _descripcionController;
  late final TextEditingController _modeloController;
  late final TextEditingController _anioEquipoController;
  late final TextEditingController _capacidadController;
  late final TextEditingController _horometroController;
  late final TextEditingController _odometroController;

  // LIST
  late final List<BaseDataEntity> lstBases                  = <BaseDataEntity>[];
  late final List<UnidadMarcaDataEntity> lstUnidadesMarcas  = <UnidadMarcaDataEntity>[];
  late final List<UnidadTipoDataEntity> lstUnidadesTipos    = <UnidadTipoDataEntity>[];

  @override
  void initState() {
    // Cargar el listado de los DropdownList.
    BlocProvider.of<RemoteUnidadBloc>(context).add(CreateUnidad());

    _numeroEconomicoController  = TextEditingController();
    _numeroSerieController      = TextEditingController();
    _descripcionController      = TextEditingController();
    _modeloController           = TextEditingController();
    _anioEquipoController       = TextEditingController();
    _capacidadController        = TextEditingController();
    _horometroController        = TextEditingController();
    _odometroController         = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _numeroEconomicoController.dispose();
    _numeroSerieController.dispose();
    _descripcionController.dispose();
    _modeloController.dispose();
    _anioEquipoController.dispose();
    _capacidadController.dispose();
    _horometroController.dispose();
    _odometroController.dispose();
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
                state.failure?.response?.data.toString() ?? 'Se produjo un error inesperado. Intenta crear la unidad de nuevo.',
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

  // void _handleStoreUnidad() {
  //   final UnidadReqEntity objData = UnidadReqEntity(
  //     numeroEconomico   : _numeroEconomicoController.text,
  //     numeroSerie       : _numeroSerieController.text,
  //     descripcion       : _descripcionController.text,
  //     modelo            : _modeloController.text,
  //     anioEquipo        : _anioEquipoController.text,
  //     idBase            : idBase,
  //     baseName          : baseName,
  //     idUnidadMarca     : idUnidadMarca,
  //     unidadMarcaName   : unidadMarcaName,
  //     idUnidadTipo      : idUnidadTipo,
  //     unidadTipoName    : unidadTipoName,
  //     capacidad         : _capacidadController.text,
  //     horometro         : _horometroController.text,
  //     odometro          : _odometroController.text,
  //   );

  //   final bool isValidForm = _formKey.currentState!.validate();

  //   if (isValidForm) {
  //     _formKey.currentState!.save();
  //     BlocProvider.of<RemoteUnidadBloc>(context).add(StoreUnidad(objData));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RemoteUnidadBloc, RemoteUnidadState>(
      builder: (BuildContext context, RemoteUnidadState state) {
        if (state is RemoteUnidadLoading) {
          return Center(child: LoadingIndicator(color: Theme.of(context).primaryColor, strokeWidth: 2));
        }

        if (state is RemoteUnidadFailure) {

        }

        if (state is RemoteUnidadCreateSuccess) {
          return Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // NÚMERO ECONÓMICO
                LabeledTextField(
                  autoFocus: true,
                  controller: _numeroEconomicoController,
                  labelText: '* Número económico:',
                  hintText: 'Ingrese número económico...',
                  validator: FormValidators.textValidator,
                ),

                Gap($styles.insets.sm),

                // TIPO DE UNIDAD
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text('* Tipo de unidad:', style: $styles.textStyles.label),

                    Gap($styles.insets.xs),

                    DropdownButtonFormField<dynamic>(
                      menuMaxHeight: 280,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: $styles.insets.sm - 3,
                          horizontal: $styles.insets.xs + 2,
                        ),
                        hintText: 'Seleccione',
                      ),
                      items: state.unidadData?.unidadesTipos.map<DropdownMenuItem<dynamic>>((unidadTipo) {
                        return DropdownMenuItem<dynamic>(
                          value: unidadTipo.idUnidadTipo,
                          child: Text(unidadTipo.name ?? ''),
                        );
                      }).toList() ?? [],
                      onChanged: (newValue) {
                        setState(() {});
                      },
                    ),
                  ],
                ),
                // LabeledDropdownFormField(
                //   labelText: '* Tipo de unidad:',
                //   hintText: 'Seleccione',
                //   items: lstUnidadesTipos,
                //   onChanged: (newValue) {
                //     setState(() {});
                //   },
                // ),

                Gap($styles.insets.sm),

                // MARCA / MODELO DE LA UNIDAD
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text('* Selecciona la marca:', style: $styles.textStyles.label),

                          Gap($styles.insets.xs),

                          DropdownButtonFormField<dynamic>(
                            menuMaxHeight: 280,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                vertical: $styles.insets.sm - 3,
                                horizontal: $styles.insets.xs + 2,
                              ),
                              hintText: 'Seleccione',
                            ),
                            items: state.unidadData?.unidadesMarcas.map<DropdownMenuItem<dynamic>>((unidadMarca) {
                              return DropdownMenuItem<dynamic>(
                                value: unidadMarca.idUnidadMarca,
                                child: Text(unidadMarca.name ?? ''),
                              );
                            }).toList() ?? [],
                            onChanged: (newValue) {
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                      // child: LabeledDropdownFormField(
                      //   labelText: '* Selecciona la marca:',
                      //   hintText: 'Seleccione',
                      //   onChanged: (_) {},
                      //   items: lstUnidadesMarcas,
                      // ),
                    ),
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

                // CAPACIDAD / NO. DE SERIE
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: LabeledTextField(
                        controller: _capacidadController,
                        labelText: '* Capacidad:',
                        hintText: 'Ingrese cantidad',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(width: $styles.insets.sm),
                    Expanded(
                      child: LabeledTextField(
                        controller: _numeroSerieController,
                        labelText: '* Número de serie:',
                        hintText: 'Ingrese número serie...',
                        validator: FormValidators.textValidator,
                      ),
                    ),
                  ],
                ),

                Gap($styles.insets.sm),

                // BASES
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text('* Selecciona la base:', style: $styles.textStyles.label),

                    Gap($styles.insets.xs),

                    DropdownButtonFormField<dynamic>(
                      menuMaxHeight: 280,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: $styles.insets.sm - 3,
                          horizontal: $styles.insets.xs + 2,
                        ),
                        hintText: 'Seleccione',
                      ),
                      items: state.unidadData?.bases.map<DropdownMenuItem<dynamic>>((base) {
                        return DropdownMenuItem<dynamic>(
                          value: base.idBase,
                          child: Text(base.name ?? ''),
                        );
                      }).toList() ?? [],
                      onChanged: (newValue) {
                        setState(() {});
                      },
                    ),
                  ],
                ),

                Gap($styles.insets.sm),

                // DESCRIPCIÓN
                LabeledTextAreaField(
                  controller: _descripcionController,
                  labelText: 'Descripción de la unidad (opcional):',
                  validator: FormValidators.textValidator,
                  hintText: 'Ingrese descripción...',
                  textInputAction: TextInputAction.done,
                  maxLines: 2,
                  maxCharacters: 300,
                ),

                Gap($styles.insets.md),

                FilledButton(
                  onPressed: () {},
                  style: const ButtonStyle(
                    minimumSize: MaterialStatePropertyAll(
                      Size(double.infinity, 48),
                    ),
                  ),
                  child: Text(
                    'Guardar',
                    style: $styles.textStyles.button,
                  ),
                ),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
