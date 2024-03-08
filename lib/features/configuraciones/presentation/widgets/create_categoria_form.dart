import 'package:eos_mobile/core/common/widgets/controls/loading_indicator.dart';
import 'package:eos_mobile/core/validators/form_validators.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/inspeccion_entity.dart';
import 'package:eos_mobile/features/configuraciones/presentation/bloc/inspecciones/remote/remote_inspecciones_bloc.dart';
import 'package:eos_mobile/features/configuraciones/presentation/bloc/inspecciones/remote/remote_inspecciones_event.dart';
import 'package:eos_mobile/features/configuraciones/presentation/bloc/inspecciones/remote/remote_inspecciones_state.dart';
import 'package:eos_mobile/shared/shared.dart';

class CreateCategoriaForm extends StatefulWidget {
  const CreateCategoriaForm({super.key});

  @override
  State<CreateCategoriaForm> createState() => _CreateCategoriaFormState();
}

class _CreateCategoriaFormState extends State<CreateCategoriaForm> {
  // LISTENERS
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    // Limpia el controlador cuando se elimina el widget.
    _nameController.dispose();
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
            // Form Control: Nombre de la Inspeccion
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
            const Gap(32),
            BlocConsumer<RemoteInspeccionesBloc,
                RemoteInspeccionesState>(
              listener: (context, state) {
                if (state is RemoteInspeccionesFailure) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    final jsonResponse = state.failure?.response?.data as Map<String, dynamic>?;
                    final errorMessage = jsonResponse != null ? jsonResponse['title'] : 'Error';
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '$errorMessage: Lo siento, no se ha podido crear la categoría. Por favor, inténtalo de nuevo más tarde.',
                        ),
                        backgroundColor: Theme.of(context).colorScheme.error,
                      ),
                    );
                  });
                }

                if (state is RemoteInspeccionesCreateDone) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Inspección creada exitosamente',
                      ),
                      backgroundColor: Colors.green,
                    ),
                  );

                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                if (state is RemoteInspeccionesLoading) {
                  return FilledButton(
                    onPressed: null,
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                        const Size(double.infinity, 48),
                      ),
                    ),
                    child: LoadingIndicator(
                      color: Theme.of(context).disabledColor,
                      width: 20,
                      height: 20,
                      strokeWidth: 2,
                    ),
                  );
                }

                return FilledButton(
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Formulario incompleto'),
                          backgroundColor: Theme.of(context).colorScheme.error,
                        ),
                      );
                      return;
                    }
                    final inspeccionData = InspeccionEntity(
                      name: _nameController.text,
                    );
                    context.read<RemoteInspeccionesBloc>().add(
                          CreateInspeccion(inspeccionData),
                        );
                  },
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(
                      const Size(double.infinity, 48),
                    ),
                  ),
                  child: Text(
                    'Guardar',
                    style: $styles.textStyles.button,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}