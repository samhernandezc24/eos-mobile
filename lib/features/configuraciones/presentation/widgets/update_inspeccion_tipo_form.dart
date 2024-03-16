import 'package:eos_mobile/core/common/widgets/controls/loading_indicator.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/inspeccion_tipo_req_entity.dart';
import 'package:eos_mobile/features/configuraciones/presentation/bloc/inspeccion_tipo/remote/remote_inspeccion_tipo_bloc.dart';
import 'package:eos_mobile/shared/shared.dart';

class UpdateInspeccionTipoForm extends StatefulWidget {
  const UpdateInspeccionTipoForm({Key? key, this.inspeccionTipo}) : super(key: key);

  final InspeccionTipoEntity? inspeccionTipo;

  @override
  State<UpdateInspeccionTipoForm> createState() => _UpdateInspeccionTipoFormState();
}

class _UpdateInspeccionTipoFormState extends State<UpdateInspeccionTipoForm> {
  // LISTENERS
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _folioController;
  late TextEditingController _nameController;
  late TextEditingController _correoController;

  @override
  void initState() {
    _folioController = TextEditingController(text: widget.inspeccionTipo?.folio ?? '');
    _nameController = TextEditingController(text: widget.inspeccionTipo?.name ?? '');
    _correoController = TextEditingController(text: widget.inspeccionTipo?.correo ?? '');
    super.initState();
  }

  @override
  void dispose() {
    // Limpia el controlador cuando se elimina el widget.
    _folioController.dispose();
    _nameController.dispose();
    _correoController.dispose();
    super.dispose();
  }

  void _handleUpdateInspeccionTipoSubmitted() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Formulario incompleto'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    } else {
      final inspeccionTipoData = InspeccionTipoReqEntity(
        idInspeccionTipo: widget.inspeccionTipo?.idInspeccionTipo,
        folio: _folioController.text,
        name: _nameController.text,
        correo: _correoController.text,
      );
      context
          .read<RemoteInspeccionTipoBloc>()
          .add(UpdateInspeccionTipo(inspeccionTipoData));
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
                  state.failure?.response?.data.toString() ?? 'Ha ocurrido un error al actualizar el tipo de inspección.',
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

                // ACTUALIZAR TIPO DE INSPECCIÓN BOTON:
                _UpdateInspeccionTipoButton(
                  handleUpdateInspeccionTipoSubmitted:
                      _handleUpdateInspeccionTipoSubmitted,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _UpdateInspeccionTipoButton extends StatelessWidget {
  const _UpdateInspeccionTipoButton({
    required this.handleUpdateInspeccionTipoSubmitted,
    Key? key,
  }) : super(key: key);

  final VoidCallback handleUpdateInspeccionTipoSubmitted;

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
                onPressed: handleUpdateInspeccionTipoSubmitted,
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
