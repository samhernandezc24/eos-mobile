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

  // PROPERTIES

  @override
  void initState() {
    super.initState();

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
    final DateTime fechaProgramada = DateFormat('dd/MM/yyyy HH:mm').parse(_fechaProgramadaController.text);

    final InspeccionStoreReqEntity objData = InspeccionStoreReqEntity(
      fechaProgramada             : fechaProgramada,
      idInspeccionTipo            : 'idInspeccionTipo',
      inspeccionTipoCodigo        : 'inspeccionTipoCodigo',
      inspeccionTipoName          : 'inspeccionTipoName',
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
      capacidad                   : 0,
      idUnidadCapacidadMedida     : 'idUnidadCapacidadMedida',
      unidadCapacidadMedidaName   : 'unidadCapacidadMedidaName',
      locacion                    : 'locacion',
      tipoPlataforma              : 'tipoPlataforma',
      odometro                    : 0,
      horometro                   : 0,
    );

    final bool isValidForm = _formKey.currentState!.validate();

    if (isValidForm) {
      _formKey.currentState!.save();
      BlocProvider.of<RemoteInspeccionBloc>(context).add(StoreInspeccion(objData));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // CAMBIAR DINAMICAMENTE ENTRE UNIDAD INVENTARIO / UNIDAD TEMPORAL:
          _buildUnidadCheckbox('Unidad'),

          // FECHA PROGRAMADA:
          LabeledTextFormField(
            controller  : _fechaProgramadaController,
            isReadOnly  : true,
            label       : '* Fecha programada:',
            onTap       : (){},
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

          // UNIDAD CAPACIDAD:
          Row(
            children: <Widget>[
              Expanded(
                child: LabeledTextFormField(
                  controller    : _capacidadController,
                  hintText      : 'Ingresa cantidad',
                  label         : '* Capacidad:',
                  keyboardType  : const TextInputType.numberWithOptions(signed: true, decimal: true),
                ),
              ),
              Gap($styles.insets.sm),
              DropdownButton(items: [], onChanged: (_){}),
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
        ],
      ),
    );
  }

  Widget _buildUnidadCheckbox(String value) {
    return Container();
  }
}
