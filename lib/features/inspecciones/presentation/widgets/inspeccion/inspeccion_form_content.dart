import 'package:eos_mobile/core/common/widgets/controls/labeled_dropdown_form_field.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/shared/shared.dart';

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

  @override
  void initState() {
    super.initState();
    _fechaInspeccionController  = TextEditingController();
    _numeroEconomicoController  = TextEditingController();
    _modeloController           = TextEditingController();
  }

  @override
  void dispose() {
    _fechaInspeccionController.dispose();
    _numeroEconomicoController.dispose();
    _modeloController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
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
                    child: LabeledDropdownFormField<InspeccionTipoEntity>(
                      label: '* Seleccione marca:',
                      hintText: 'Seleccione',
                      items: widget.inspeccionesTipos,
                      itemBuilder: (inspeccionTipo) => Text(inspeccionTipo.name),
                      onChanged: (_) {},
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
        ),
      ],
    );
  }
}
