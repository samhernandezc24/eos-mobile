part of '../../../pages/list/list_page.dart';

class _FilterDataInspeccion extends StatefulWidget {
  const _FilterDataInspeccion({
    required this.lstUnidadesTipos,
    required this.lstInspeccionesEstatus,
    required this.lstUsuarios,
    required this.hasRequerimiento,
    Key? key,
    this.onApplyFilters,
    this.onClearFilters,
  }) : super(key: key);

  final List<UnidadTipo> lstUnidadesTipos;
  final List<InspeccionEstatus> lstInspeccionesEstatus;
  final List<Usuario> lstUsuarios;
  final List<Requerimiento> hasRequerimiento;
  final void Function()? onApplyFilters;
  final void Function()? onClearFilters;

  @override
  State<_FilterDataInspeccion> createState() => _FilterDataInspeccionState();
}

class _FilterDataInspeccionState extends State<_FilterDataInspeccion> {
  // LIST
  List<Filter> sltFilter = [];

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

  // EVENTS
  void _handleApplyFiltersPressed() {
    sltFilter.clear();

    if (_selectedUnidadTipo != null) {
      sltFilter.add(Filter(field: 'IdUnidadTipo', value: _selectedUnidadTipo!.idUnidadTipo));
    }

    if (widget.onApplyFilters != null) {
      return widget.onApplyFilters!();
    }

    print(sltFilter);
  }

  void _handleClearFiltersPressed() {
    if (widget.onClearFilters != null) { return widget.onClearFilters!(); }
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
                key         : const Key('IdInspeccionEstatus'),
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
                key         : const Key('IdUnidadTipo'),
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
                key         : const Key('HasRequerimiento'),
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
                key         : const Key('IdCreatedUser'),
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
                key         : const Key('IdUpdatedUser'),
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
      bottomNavigationBar: _buildBottomAppBar(),
    );
  }

  Widget _buildBottomAppBar() {
    return BottomAppBar(
      height: 70,
      child : Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FilledButton(
            onPressed : _handleClearFiltersPressed,
            style     : ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFF4FAFF)),
              foregroundColor: MaterialStateProperty.all<Color>(const Color(0xFF233876)),
            ),
            child     : Text('Borrar filtros', style: $styles.textStyles.button),
          ),
          FilledButton(
            onPressed : _handleApplyFiltersPressed,
            child     : Text('Aplicar filtros', style: $styles.textStyles.button),
          ),
        ],
      ),
    );
  }
}
