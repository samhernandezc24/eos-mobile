import 'package:eos_mobile/core/common/widgets/controls/labeled_dropdown_field.dart';
import 'package:eos_mobile/core/common/widgets/controls/labeled_textarea_field.dart';
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
  late final TextEditingController _modeloController;
  late final TextEditingController _numeroSerieController;
  late final TextEditingController _capacidadController;
  late final TextEditingController _anioEquipoController;
  late final TextEditingController _descripcionController;

  // LIST
  late List<dynamic> lstUnidadesTipos   = <dynamic>['A', 'B'];
  late List<dynamic> lstUnidadesMarcas  = <dynamic>['A', 'B'];

  @override
  void initState() {
    _numeroEconomicoController  = TextEditingController();
    _modeloController           = TextEditingController();
    _numeroSerieController      = TextEditingController();
    _capacidadController        = TextEditingController();
    _anioEquipoController       = TextEditingController();
    _descripcionController      = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _numeroEconomicoController.dispose();
    _modeloController.dispose();
    _numeroSerieController.dispose();
    _capacidadController.dispose();
    _anioEquipoController.dispose();
    _descripcionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            hintText: 'Ingrese el número económico...',
            validator: FormValidators.textValidator,
          ),

          Gap($styles.insets.sm),

          // TIPO DE UNIDAD
          LabeledDropdownFormField(
            labelText: '* Tipo de unidad:',
            hintText: 'Seleccione tipo',
            items: lstUnidadesTipos,
            onChanged: (newValue) {
              setState(() {});
            },
          ),

          Gap($styles.insets.sm),

          // MARCA / MODELO DE LA UNIDAD
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: LabeledDropdownFormField(
                  labelText: '* Selecciona la marca:',
                  hintText: 'Seleccione marca',
                  onChanged: (_){},
                  items: lstUnidadesMarcas,
                ),
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
                  hintText: 'Ingrese el número de serie...',
                  validator: FormValidators.textValidator,
                ),
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
    );
  }
}
