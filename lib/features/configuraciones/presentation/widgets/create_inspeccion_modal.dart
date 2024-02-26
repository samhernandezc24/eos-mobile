import 'package:eos_mobile/features/configuraciones/presentation/widgets/create_inspeccion_form.dart';
import 'package:eos_mobile/shared/shared.dart';

class CreateInspeccionModal extends StatefulWidget {
  const CreateInspeccionModal({Key? key}) : super(key: key);

  @override
  State<CreateInspeccionModal> createState() => _CreateInspeccionState();
}

class _CreateInspeccionState extends State<CreateInspeccionModal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Nueva inspección',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            CreateInspeccionForm(),
          ],
        ),
      ),
    );
  }
}
