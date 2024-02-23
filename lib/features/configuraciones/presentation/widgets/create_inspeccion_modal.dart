import 'package:eos_mobile/core/validators/form_validators.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/inspeccion_entity.dart';
import 'package:eos_mobile/features/configuraciones/presentation/bloc/inspecciones/create/remote/remote_create_inspeccion_bloc.dart';
import 'package:eos_mobile/features/configuraciones/presentation/bloc/inspecciones/create/remote/remote_create_inspeccion_event.dart';
import 'package:eos_mobile/features/configuraciones/presentation/bloc/inspecciones/create/remote/remote_create_inspeccion_state.dart';
import 'package:eos_mobile/shared/shared.dart';

class CreateInspeccionModal extends StatefulWidget {
  const CreateInspeccionModal({Key? key}) : super(key: key);

  @override
  State<CreateInspeccionModal> createState() => _CreateInspeccionState();
}

class _CreateInspeccionState extends State<CreateInspeccionModal> {
  // LISTENERS
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _folioController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    // Limpia el controlador cuando se elimina el widget.
    _folioController.dispose();
    _nameController.dispose();
    super.dispose();
  }

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
      body:
          BlocListener<RemoteCreateInspeccionBloc, RemoteCreateInspeccionState>(
        listener: (context, state) {
          if (state is RemoteCreateInspeccionFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Error al crear la inspección')),
            );
          }

          if (state is RemoteCreateInspeccionDone) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Inspección creada exitosamente.'),
                backgroundColor: Colors.green,
              ),
            );

            // Cerramos la ventana
            Navigator.pop(context);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Form(
                key: _formKey,
                child: Container(
                  padding: EdgeInsets.zero,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text('Nombre *'),
                      const Gap(6),
                      TextFormField(
                        autofocus: true,
                        controller: _nameController,
                        decoration: const InputDecoration(
                          isDense: true,
                        ),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        validator: FormValidators.textValidator,
                      ),
                      const Gap(24),
                      const Text('Folio (opcional)'),
                      const Gap(6),
                      TextFormField(
                        controller: _folioController,
                        decoration: const InputDecoration(
                          isDense: true,
                        ),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                      ),
                      const Gap(32),
                      FilledButton(
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Formulario incompleto'),
                                backgroundColor:
                                    Theme.of(context).colorScheme.error,
                              ),
                            );
                            return;
                          }
                          final bloc =
                              context.read<RemoteCreateInspeccionBloc>();
                          final inspeccion = InspeccionEntity(
                            folio: _folioController.text,
                            name: _nameController.text,
                          );
                          bloc.add(CreateInspeccion(inspeccion));
                        },
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(
                            const Size(double.infinity, 48),
                          ),
                        ),
                        child: const Text(
                          'Guardar',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
