import 'package:eos_mobile/core/common/widgets/controls/labeled_dropdown_form_field.dart';
import 'package:eos_mobile/core/enums/unidad_inspeccion_tipo.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/shared/shared.dart';
import 'package:intl/intl.dart';

class InspeccionFormContent extends StatefulWidget {
  const InspeccionFormContent({Key? key, this.inspeccionesTipos}) : super(key: key);

  final List<InspeccionTipoEntity>? inspeccionesTipos;

  @override
  State<InspeccionFormContent> createState() => _InspeccionFormContentState();
}

class _InspeccionFormContentState extends State<InspeccionFormContent> {
  /// INSTANCES
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// CONTROLLERS
  late final TextEditingController _fechaInspeccionController;
  late final TextEditingController _numeroEconomicoController;
  late final TextEditingController _modeloController;
  late final TextEditingController _marcaController;

  /// PROPERTIES
  UnidadInspeccionTipo? _selectedUnidad;

  @override
  void initState() {
    super.initState();
    _selectedUnidad = UnidadInspeccionTipo.inventario;

    _fechaInspeccionController  = TextEditingController(text: DateFormat('dd/MM/yyyy hh:mm:ss').format(DateTime.now()));
    _numeroEconomicoController  = TextEditingController();
    _modeloController           = TextEditingController();
    _marcaController            = TextEditingController();
  }

  @override
  void dispose() {
    _fechaInspeccionController.dispose();
    _numeroEconomicoController.dispose();
    _modeloController.dispose();
    super.dispose();
  }

  /// METHODS

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // CHECKBOX PARA CAMBIAR ENTRE UNIDAD INVENTARIO / UNIDAD TEMPORAL:
          _buildUnidadCheckbox(UnidadInspeccionTipo.temporal, 'Unidad temporal'),

          // SELECCIONAR Y BUSCAR UNIDAD A INSPECCIONAR:
          LabeledDropdownFormField<InspeccionTipoEntity>(
            label: '* Seleccione la unidad a inspeccionar:',
            hintText: 'Seleccionar',
            items: widget.inspeccionesTipos,
            itemBuilder: (inspeccionTipo) => Text(inspeccionTipo.name),
            onChanged: (_) {},
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
                    padding: EdgeInsets.only(top: $styles.insets.xs),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FilledButton.icon(
                          onPressed: (){},
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
          LabeledDropdownFormField<InspeccionTipoEntity>(
            label: '* Seleccione el tipo de inspección:',
            hintText: 'Seleccionar',
            items: widget.inspeccionesTipos,
            itemBuilder: (inspeccionTipo) => Text(inspeccionTipo.name),
            onChanged: (_) {},
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

          // NÚMERO ECONÓMICO:
          LabeledTextField(
            controller: _numeroEconomicoController,
            labelText: '* Número económico:',
          ),

          Gap($styles.insets.sm),

          // MARCA / MODELO DE LA UNIDAD A INSPECCIONAR:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: LabeledTextField(
                  controller: _marcaController,
                  labelText: '* Marca:',
                  hintText: 'Ingresa marca...',
                ),
              ),
              SizedBox(width: $styles.insets.sm),
              Expanded(
                child: LabeledTextField(
                  controller: _modeloController,
                  labelText: '* Modelo:',
                  hintText: 'Ingresa modelo...',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUnidadCheckbox(UnidadInspeccionTipo unidad, String label) {
    if (unidad == UnidadInspeccionTipo.temporal) {
       return Row(
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
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
