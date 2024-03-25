import 'package:eos_mobile/features/configuraciones/domain/entities/categorias/categoria_entity.dart';
import 'package:eos_mobile/shared/shared.dart';

class CreateCategoriaItemForm extends StatefulWidget {
  const CreateCategoriaItemForm({Key? key, this.categoria}) : super(key: key);

  final CategoriaEntity? categoria;

  @override
  State<CreateCategoriaItemForm> createState() => _CreateCategoriaItemFormState();
}

class _CreateCategoriaItemFormState extends State<CreateCategoriaItemForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _handleSubmitCategoriaItem() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Formulario incompleto'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    } else {
      // EVENTO DE GUARDADO
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(),
    );
  }
}
