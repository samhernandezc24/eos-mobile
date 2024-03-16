import 'package:eos_mobile/core/common/widgets/controls/loading_indicator.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/inspeccion_tipo_req_entity.dart';
import 'package:eos_mobile/features/configuraciones/presentation/bloc/inspeccion_tipo/remote/remote_inspeccion_tipo_bloc.dart';
import 'package:eos_mobile/shared/shared.dart';

class CreateInspeccionTipoForm extends StatefulWidget {
  const CreateInspeccionTipoForm({Key? key}) : super(key: key);

  @override
  State<CreateInspeccionTipoForm> createState() =>
      _CreateInspeccionTipoFormState();
}

class _CreateInspeccionTipoFormState extends State<CreateInspeccionTipoForm> {
  // LISTENERS
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _folioController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();

  @override
  void dispose() {
    // Limpia el controlador cuando se elimina el widget.
    _folioController.dispose();
    _nameController.dispose();
    _correoController.dispose();
    super.dispose();
  }

  void _handleCreateInspeccionTipoSubmitted() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Formulario incompleto'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    } else {
      final inspeccionTipoData = InspeccionTipoReqEntity(
        folio: _folioController.text,
        name: _nameController.text,
        correo: _correoController.text,
      );
      context.read<RemoteInspeccionTipoBloc>().add(CreateInspeccionTipo(inspeccionTipoData));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RemoteInspeccionTipoBloc, RemoteInspeccionTipoState>(
      listener: (context, state) {
        if (state is RemoteInspeccionTipoFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(
                  state.failure?.response?.data.toString() ?? 'Ha ocurrido un error al crear el tipo de inspección.',
                ),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );

          // Emitir un evento para actualizar el listado
          context.read<RemoteInspeccionTipoBloc>().add(const FetcInspeccionesTipos());
        }

        if (state is RemiteInspeccionTipoFailedMessage) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(
                  state.errorMessage.toString(),
                ),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );

          // Emitir un evento para actualizar el listado
          context.read<RemoteInspeccionTipoBloc>().add(const FetcInspeccionesTipos());
        }

        if (state is RemoteInspeccionResponseDone) {
          ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.apiResponse.message),
                  backgroundColor: Colors.green,
                ),
              );

          Navigator.pop(context);

          // Emitir un evento para actualizar el listado
          context.read<RemoteInspeccionTipoBloc>().add(const FetcInspeccionesTipos());
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // FOLIO:
                LabeledTextField(
                  autoFocus: true,
                  controller: _folioController,
                  labelText: 'Folio *',
                  hintText: 'INST-24-xxxxxx',
                  validator: FormValidators.textValidator,
                ),

                Gap($styles.insets.sm),

                // NOMBRE:
                LabeledTextField(
                  autoFocus: true,
                  controller: _nameController,
                  labelText: 'Nombre *',
                  validator: FormValidators.textValidator,
                ),

                Gap($styles.insets.sm),

                // CORREO:
                LabeledTextField(
                  autoFocus: true,
                  controller: _correoController,
                  labelText: 'Correo (opcional)',
                  hintText: 'ejem@plo.com',
                  textInputAction: TextInputAction.done,
                ),

                Gap($styles.insets.lg),

                // CREAR TIPO DE INSPECCIÓN BOTON:
                _CreateInspeccionTipoButton(
                  handleCreateInspeccionTipoSubmitted:
                      _handleCreateInspeccionTipoSubmitted,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CreateInspeccionTipoButton extends StatelessWidget {
  const _CreateInspeccionTipoButton({
    required this.handleCreateInspeccionTipoSubmitted,
    Key? key,
  }) : super(key: key);

  final VoidCallback handleCreateInspeccionTipoSubmitted;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RemoteInspeccionTipoBloc, RemoteInspeccionTipoState>(
      builder: (context, state) {
        return state is RemoteInspeccionTipoLoading
            ? FilledButton(
                onPressed: null,
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size?>(
                    const Size(double.infinity, 48),
                  ),
                ),
                child: LoadingIndicator(
                  color: Theme.of(context).disabledColor,
                  width: 20,
                  height: 20,
                  strokeWidth: 2,
                ),
              )
            : FilledButton(
                onPressed: handleCreateInspeccionTipoSubmitted,
                style: const ButtonStyle(
                  minimumSize: MaterialStatePropertyAll(
                    Size(double.infinity, 48),
                  ),
                ),
                child: Text(
                  'Guardar',
                  style: $styles.textStyles.button,
                ),
              );
      },
    );
  }
}
