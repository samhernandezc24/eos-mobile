part of '../../../pages/list/list_page.dart';

class _FilterDataInspeccion extends StatefulWidget {
  const _FilterDataInspeccion({
    required this.lstUnidadesTipos,
    required this.lstInspeccionesEstatus,
    required this.lstUsuarios,
    required this.hasRequerimiento,
    Key? key,
  }) : super(key: key);

  final List<UnidadTipo> lstUnidadesTipos;
  final List<InspeccionEstatus> lstInspeccionesEstatus;
  final List<Usuario> lstUsuarios;
  final List<Requerimiento> hasRequerimiento;

  @override
  State<_FilterDataInspeccion> createState() => _FilterDataInspeccionState();
}

class _FilterDataInspeccionState extends State<_FilterDataInspeccion> {
  // GLOBAL KEYS
  final GlobalKey<FormFieldState<UnidadTipo>> _unidadTipoKey        = GlobalKey<FormFieldState<UnidadTipo>>();
  final GlobalKey<FormFieldState<InspeccionEstatus>> _estatusKey    = GlobalKey<FormFieldState<InspeccionEstatus>>();
  final GlobalKey<FormFieldState<Requerimiento>> _requerimientoKey  = GlobalKey<FormFieldState<Requerimiento>>();
  final GlobalKey<FormFieldState<Usuario>> _createdUserKey          = GlobalKey<FormFieldState<Usuario>>();
  final GlobalKey<FormFieldState<Usuario>> _updatedUserKey          = GlobalKey<FormFieldState<Usuario>>();

  // LIST
  late List<UnidadTipo> lstUnidadesTipos;
  late List<InspeccionEstatus> lstInspeccionesEstatus;
  late List<Requerimiento> lstHasRequerimiento;
  late List<Usuario> lstUsuarios;

  // SELECTION
  UnidadTipo? _selectedUnidadTipo;
  InspeccionEstatus? _selectedEstatus;
  Requerimiento? _selectedRequerimiento;
  Usuario? _selectedCreatedUsuario;
  Usuario? _selectedUpdatedUsuario;

  // STATE
  @override
  void initState() {
    super.initState();
    lstUnidadesTipos = List.from(widget.lstUnidadesTipos);
    lstUnidadesTipos.insert(0, const UnidadTipo(idUnidadTipo: '', name: 'Seleccionar', seccion: ''));

    lstInspeccionesEstatus = List.from(widget.lstInspeccionesEstatus);
    lstInspeccionesEstatus.insert(0, const InspeccionEstatus(idInspeccionEstatus: '', name: 'Seleccionar'));

    lstHasRequerimiento = List.from(widget.hasRequerimiento);
    lstHasRequerimiento.insert(0, const Requerimiento(name: 'Seleccionar'));

    lstUsuarios = List.from(widget.lstUsuarios);
    lstUsuarios.insert(0, const Usuario(id: '', nombreCompleto: 'Seleccionar'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Buscar por filtros', style: $styles.textStyles.h3)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all($styles.insets.sm).copyWith(bottom: $styles.insets.lg),
          child: Column(
            children: <Widget>[
              // FILTROS
              LabeledDropdownFormField<InspeccionEstatus>(
                key         : _estatusKey,
                label       : 'Estatus:',
                items       : lstInspeccionesEstatus,
                itemBuilder : (item) => Text(item.name ?? ''),
                value       : _selectedEstatus,
                onChanged   : (value) {
                  setState(() {
                    _selectedEstatus = value;
                  });
                },
              ),

              Gap($styles.insets.sm),

              LabeledDropdownFormField<UnidadTipo>(
                key         : _unidadTipoKey,
                label       : 'Tipo de unidad:',
                items       : lstUnidadesTipos,
                itemBuilder : (item) => Text(item.name ?? ''),
                value       : _selectedUnidadTipo,
                onChanged   : (value) {
                  setState(() {
                    _selectedUnidadTipo = value;
                  });
                },
              ),

              Gap($styles.insets.sm),

              LabeledDropdownFormField<Requerimiento>(
                key         : _requerimientoKey,
                label       : 'Requerimiento:',
                items       : lstHasRequerimiento,
                itemBuilder : (item) => Text(item.name ?? ''),
                value       : _selectedRequerimiento,
                onChanged   : (value) {
                  setState(() {
                    _selectedRequerimiento = value;
                  });
                },
              ),

              Gap($styles.insets.sm),

              LabeledDropdownFormField<Usuario>(
                key         : _createdUserKey,
                label       : 'Creado por:',
                items       : lstUsuarios,
                itemBuilder : (item) => Text(item.nombreCompleto ?? ''),
                value       : _selectedCreatedUsuario,
                onChanged   : (value) {
                  setState(() {
                    _selectedCreatedUsuario = value;
                  });
                },
              ),

              Gap($styles.insets.sm),

              LabeledDropdownFormField<Usuario>(
                key         : _updatedUserKey,
                label       : 'Actualizado por:',
                items       : lstUsuarios,
                itemBuilder : (item) => Text(item.nombreCompleto ?? ''),
                value       : _selectedUpdatedUsuario,
                onChanged   : (value) {
                  setState(() {
                    _selectedUpdatedUsuario = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
