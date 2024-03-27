import 'package:eos_mobile/core/common/widgets/controls/labeled_dropdown_field.dart';
import 'package:eos_mobile/core/common/widgets/controls/labeled_textarea_field.dart';
import 'package:eos_mobile/shared/shared.dart';

class CreateUnidadForm extends StatefulWidget {
  const CreateUnidadForm({super.key});

  @override
  State<CreateUnidadForm> createState() => _CreateUnidadFormState();
}

class _CreateUnidadFormState extends State<CreateUnidadForm> {
  // LISTENERS
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _numeroEconomicoController =
      TextEditingController();
  final TextEditingController _numeroSerieController = TextEditingController();
  final TextEditingController _modeloController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();

  @override
  void dispose() {
    // Limpia el controlador cuando se elimina el widget.
    _numeroEconomicoController.dispose();
    _numeroSerieController.dispose();
    _modeloController.dispose();
    _descripcionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // NÚMERO ECONÓMICO
            LabeledTextField(
              autoFocus: true,
              controller: _numeroEconomicoController,
              labelText: 'Número Económico *',
              validator: FormValidators.textValidator,
            ),

            Gap($styles.insets.sm),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // TIPO UNIDAD
                Expanded(
                  child: LabeledDropdownFormField(
                    labelText: 'Tipo de Unidad *',
                    hintText: 'Seleccione',
                    items: const <String>[
                      '3MA',
                      'AFFER',
                      'All Pressure',
                      'AMC',
                      'Amida',
                      'ASM',
                      'Audi',
                      'Autocar',
                      'Braden',
                      'Mercedes Benz',
                      'Mitsubishi',
                    ],
                    onChanged: (newValue) {
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: $styles.insets.sm),
                // MARCA
                Expanded(
                  child: LabeledDropdownFormField(
                    labelText: 'Marca de Unidad',
                    hintText: 'Seleccione',
                    items: const <String>[
                      '3MA',
                      'AFFER',
                      'All Pressure',
                      'AMC',
                      'Amida',
                      'ASM',
                      'Audi',
                      'Autocar',
                      'Braden',
                      'Mercedes Benz',
                      'Mitsubishi',
                    ],
                    onChanged: (newValue) {
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            Gap($styles.insets.sm),

            Row(
              children: [
                // NÚMERO DE SERIE
                Expanded(
                  child: LabeledTextField(
                    controller: _numeroSerieController,
                    labelText: 'Número de Serie',
                    validator: FormValidators.textValidator,
                  ),
                ),
                SizedBox(width: $styles.insets.sm),
                // NÚMERO DE SERIE
                Expanded(
                  child: LabeledTextField(
                    controller: _modeloController,
                    labelText: 'Modelo',
                    validator: FormValidators.textValidator,
                  ),
                ),
              ],
            ),

            Gap($styles.insets.sm),

            // DESCRIPCIÓN
            LabeledTextAreaField(
              controller: _descripcionController,
              labelText: 'Descripción de Unidad',
              validator: FormValidators.textValidator,
              hintText: 'Ingresar descripción...',
              maxLines: 2,
              maxCharacters: 300,
            ),

            Gap($styles.insets.lg),

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
      ),
    );
  }
}
