import 'package:eos_mobile/shared/shared.dart';

class CreateInspeccionTipoForm extends StatefulWidget {
  const CreateInspeccionTipoForm({super.key});

  @override
  State<CreateInspeccionTipoForm> createState() => _CreateInspeccionTipoFormState();
}

class _CreateInspeccionTipoFormState extends State<CreateInspeccionTipoForm> {
  // LISTENERS
  final GlobalKey<FormState> _formKey           = GlobalKey<FormState>();
  final TextEditingController _folioController  = TextEditingController();
  final TextEditingController _nameController   = TextEditingController();
  final TextEditingController _correoController = TextEditingController();

  @override
  void dispose() {
    // Limpia el controlador cuando se elimina el widget.
    _folioController.dispose();
    _nameController.dispose();
    _correoController.dispose();
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
            // FOLIO
            LabeledTextField(
              autoFocus: true,
              controller: _folioController,
              labelText: 'Folio *',
              hintText: 'INST-24-xxxxxx',
              validator: FormValidators.textValidator,
            ),

            Gap($styles.insets.sm),

            // NOMBRE
            LabeledTextField(
              autoFocus: true,
              controller: _nameController,
              labelText: 'Nombre *',
              validator: FormValidators.textValidator,
            ),

            Gap($styles.insets.sm),

            // CORREO
            LabeledTextField(
              autoFocus: true,
              controller: _correoController,
              labelText: 'Correo (opcional)',
              hintText: 'ejem@plo.com',
              textInputAction: TextInputAction.done,
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
