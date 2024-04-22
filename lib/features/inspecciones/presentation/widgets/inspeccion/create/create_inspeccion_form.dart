import 'package:eos_mobile/core/common/widgets/controls/labeled_dropdown_form_field.dart';
import 'package:eos_mobile/core/enums/unidad_inspeccion_tipo.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad_inventario/unidad_inventario_entity.dart';
import 'package:eos_mobile/features/inspecciones/presentation/widgets/unidad/create_unidad_page.dart';
import 'package:eos_mobile/shared/shared.dart';
import 'package:intl/intl.dart';

class CreateInspeccionForm extends StatefulWidget {
  const CreateInspeccionForm({Key? key, this.inspeccionesTipos, this.unidadesInventarios}) : super(key: key);

  final List<InspeccionTipoEntity>? inspeccionesTipos;
  final List<UnidadInventarioEntity>? unidadesInventarios;

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

  /// PROPERTIES
  UnidadInspeccionTipo? _selectedUnidad;

  @override
  void initState() {
    super.initState();
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
          LabeledDropdownFormField<UnidadInventarioEntity>(
            label: '* Unidad:',
            hintText: 'Seleccionar',
            items: widget.unidadesInventarios,
            itemBuilder: (unidad) => Text(unidad.numeroEconomico ?? ''),
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
          LabeledDropdownFormField<InspeccionTipoEntity>(
            label: '* Tipo de inspección:',
            hintText: 'Seleccionar',
            items: widget.inspeccionesTipos,
            itemBuilder: (inspeccionTipo) => Text(inspeccionTipo.name),
            onChanged: (_) {},
            validator: FormValidators.dropdownValidator,
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
