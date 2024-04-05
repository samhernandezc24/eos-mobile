import 'package:eos_mobile/shared/shared.dart';

class CreateInspeccionTipoForm extends StatefulWidget {
  const CreateInspeccionTipoForm({Key? key}) : super(key: key);

  @override
  State<CreateInspeccionTipoForm> createState() => _CreateInspeccionTipoFormState();
}

class _CreateInspeccionTipoFormState extends State<CreateInspeccionTipoForm> {
  // GENERAL INSTANCES
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // CONTROLLERS
  late final TextEditingController _folioController;
  late final TextEditingController _nameController;
  late final TextEditingController _correoController;

  /// PROPERTIES
  final int currentYear   = DateTime.now().year;
  // int _currentOrder       = 0;

  @override
  void initState() {
    _folioController    = TextEditingController();
    _nameController     = TextEditingController();
    _correoController   = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _folioController.dispose();
    _nameController.dispose();
    _correoController.dispose();
    super.dispose();
  }

  /// METHODS

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          // FOLIO:
          LabeledTextField(
            controller: _folioController,
            hintText: 'INST-$currentYear-xxxx',
            labelText: 'Folio:',
          ),

          Gap($styles.insets.md),

          // NOMBRE:
          LabeledTextField(
            controller: _nameController,
            labelText: 'Nombre:',
          ),

          Gap($styles.insets.md),

          // CORREO (OPCIONAL):
          LabeledTextField(
            controller: _correoController,
            hintText: 'ejem@plo.com',
            labelText: 'Correo (opcional):',
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
          ),

          Gap($styles.insets.lg),

          FilledButton(
            onPressed: (){},
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all<Size?>(
                const Size(double.infinity, 48),
              ),
            ),
            child: Text($strings.saveButtonText, style: $styles.textStyles.button),
          ),
        ],
      ),
    );
  }
}
