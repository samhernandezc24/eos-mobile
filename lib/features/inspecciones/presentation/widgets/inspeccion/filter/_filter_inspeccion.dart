part of '../../../pages/list/list_page.dart';

class _FilterInspeccion extends StatefulWidget {
  const _FilterInspeccion({
    required this.dateOptions,
    required this.unidadesTipos,
    required this.inspeccionesEstatus,
    required this.usuarios,
    required this.hasRequerimiento,
    Key? key,
  }) : super(key: key);

  final List<DateOption> dateOptions;
  final List<UnidadTipo> unidadesTipos;
  final List<InspeccionEstatus> inspeccionesEstatus;
  final List<Usuario> usuarios;
  final List<Map<String, dynamic>> hasRequerimiento;

  @override
  State<_FilterInspeccion> createState() => _FilterInspeccionState();
}

class _FilterInspeccionState extends State<_FilterInspeccion> {
  // GLOBAL KEY
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // CONTROLLERS
  late final TextEditingController _txtDateDesdeController;

  // String? _selectedDateOption;

  // SELECTED ELEMENTS
  InspeccionEstatus? _selectedEstatus;
  UnidadTipo? _selectedUnidadTipo;
  Usuario? _selectedUsuario;
  String? _selectedRequerimiento;

  @override
  void initState() {
    super.initState();

    _txtDateDesdeController = TextEditingController();

    _selectedEstatus        = const InspeccionEstatus(idInspeccionEstatus: '', name: 'Seleccionar');
    _selectedUnidadTipo     = const UnidadTipo(idUnidadTipo: '', name: 'Seleccionar', seccion: '');
    _selectedUsuario        = const Usuario(id: '', nombreCompleto: 'Seleccionar');
    _selectedRequerimiento  = 'Seleccionar';
  }

  @override
  void dispose() {
    _txtDateDesdeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<InspeccionEstatus> optEstatus          = [const InspeccionEstatus(idInspeccionEstatus: '', name: 'Seleccionar'), ...widget.inspeccionesEstatus];
    final List<UnidadTipo> optUnidadTipo              = [const UnidadTipo(idUnidadTipo: '', name: 'Seleccionar', seccion: ''), ...widget.unidadesTipos];
    final List<Usuario> optUsuario                    = [const Usuario(id: '', nombreCompleto: 'Seleccionar'), ...widget.usuarios];

    final List<String> requerimientoItems = [
      'Seleccionar',
      ...widget.hasRequerimiento.map((item) => item['name'] as String),
    ];

    return Scaffold(
      appBar  : AppBar(title: Text('Buscar por filtros', style: $styles.textStyles.h3)),
      body    : ListView(
        padding  : EdgeInsets.all($styles.insets.sm).copyWith(bottom: $styles.insets.offset),
        children : <Widget>[
          // FILTROS
          Form(
            key   : _formKey,
            child : Column(
              crossAxisAlignment  : CrossAxisAlignment.start,
              children            : <Widget>[
                // FILTROS
                // INSPECCION ESTATUS:
                LabeledDropdownFormField<InspeccionEstatus>(
                  label       : 'Estatus:',
                  items       : optEstatus,
                  itemBuilder : (item) => Text(item.name ?? ''),
                  onChanged   : (selectedType) {
                    setState(() {
                      _selectedEstatus = selectedType ?? const InspeccionEstatus(idInspeccionEstatus: '', name: 'Seleccionar');
                    });
                  },
                  value       : _selectedEstatus,
                ),

                Gap($styles.insets.sm),

                // TIPO DE UNIDAD:
                LabeledDropdownFormField<UnidadTipo>(
                  label       : 'Tipo de unidad:',
                  items       : optUnidadTipo,
                  itemBuilder : (item) => Text(item.name ?? ''),
                  onChanged   : (selectedType) {
                    setState(() {
                      _selectedUnidadTipo = selectedType ?? const UnidadTipo(idUnidadTipo: '', name: 'Seleccionar', seccion: '');
                    });
                  },
                  value       : _selectedUnidadTipo,
                ),

                Gap($styles.insets.sm),

                // CON REQUERIMIENTO / SIN REQUERIMIENTO:
                LabeledDropdownFormField<String>(
                  label       : 'Requerimiento:',
                  items       : requerimientoItems,
                  onChanged   : (selectedType) {
                    setState(() {
                      _selectedRequerimiento = selectedType;
                    });
                  },
                  value       : _selectedRequerimiento,
                ),

                Gap($styles.insets.sm),

                // CREATED USER:
                LabeledDropdownFormField<Usuario>(
                  label       : 'Creado por:',
                  items       : optUsuario,
                  itemBuilder : (item) => Text(item.nombreCompleto ?? ''),
                  onChanged   : (selectedType) {
                    setState(() {
                      _selectedUsuario = selectedType ?? const Usuario(id: '', nombreCompleto: 'Seleccionar');
                    });
                  },
                  value       : _selectedUsuario,
                ),

                Gap($styles.insets.sm),

                // UPDATED USER:
                LabeledDropdownFormField<Usuario>(
                  label       : 'Actualizado por:',
                  items       : optUsuario,
                  itemBuilder : (item) => Text(item.nombreCompleto ?? ''),
                  onChanged   : (selectedType) {
                    setState(() {
                      _selectedUsuario = selectedType ?? const Usuario(id: '', nombreCompleto: 'Seleccionar');
                    });
                  },
                  value       : _selectedUsuario,
                ),

                Gap($styles.insets.sm),

                // FECHA DESDE:
                LabeledDateTextFormField(
                  controller  : _txtDateDesdeController,
                  hintText    : 'Ingresar fecha',
                  label       : 'Desde:',
                ),

                Gap($styles.insets.sm),

                // FECHA HASTA:
                LabeledDateTextFormField(
                  controller  : _txtDateDesdeController,
                  hintText    : 'Ingresar fecha',
                  label       : 'Hasta:',
                ),

                // Expanded(
                //   child: ListView.builder(
                //     itemCount: widget.dateOptions.length,
                //     itemBuilder: (BuildContext context, int index) {
                //       final opt = widget.dateOptions[index];
                //       return RadioListTile<String>(
                //         value: opt['field'] as String,
                //         groupValue: _selectedDateOption,
                //           onChanged: (String? value) {
                //           setState(() {
                //             _selectedDateOption = value;
                //           });
                //         },
                //         title: Text(opt['label'] as String),
                //       );
                //     },
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
