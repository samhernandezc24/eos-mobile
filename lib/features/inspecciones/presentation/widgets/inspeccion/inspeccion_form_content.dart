import 'package:eos_mobile/core/enums/unidad_inspeccion_tipo.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';
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
  late final TextEditingController _locacionController;
  late final TextEditingController _tipoPlataformaController;

  /// PROPERTIES
  UnidadInspeccionTipo? _selectedUnidad;

  @override
  void initState() {
    super.initState();
    _selectedUnidad = UnidadInspeccionTipo.inventario;

    _fechaInspeccionController  = TextEditingController(text: DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now()));
    _locacionController         = TextEditingController();
    _tipoPlataformaController   = TextEditingController();
  }

  @override
  void dispose() {
    _fechaInspeccionController.dispose();
    _locacionController.dispose();
    _tipoPlataformaController.dispose();
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
            label: '* Unidad:',
            hintText: 'Seleccionar',
            items: widget.inspeccionesTipos!,
            itemBuilder: (inspeccionTipo) => Text(inspeccionTipo.name),
            onChanged: (_) {},
            validator: FormValidators.dropdownValidator,
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
            label: '* Tipo de inspección:',
            hintText: 'Seleccionar',
            items: widget.inspeccionesTipos!,
            itemBuilder: (inspeccionTipo) => Text(inspeccionTipo.name),
            onChanged: (_) {},
            validator: FormValidators.dropdownValidator,
          ),

          Gap($styles.insets.sm),

          // FECHA DE LA INSPECCIÓN:
          LabeledTextFormField(
            controller  : _fechaInspeccionController,
            isReadOnly  : true,
            label       : '* Fecha de la inspección:',
            textAlign   : TextAlign.end,
          ),

          Gap($styles.insets.sm),

          // LOCACIÓN:
          LabeledTextFormField(controller: _locacionController, label: '* Locación:', hintText: 'Ingresa locación...'),

          Gap($styles.insets.sm),

          // TIPO DE PLATAFORMA:
          LabeledTextFormField(controller: _tipoPlataformaController, label: 'Tipo de plataforma:', hintText: 'Ingresa tipo plataforma...'),
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
