import 'package:eos_mobile/core/common/widgets/controls/loading_indicator.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/inspeccion_tipo/remote/remote_inspeccion_tipo_bloc.dart';
import 'package:eos_mobile/shared/shared.dart';

class UpdateInspeccionTipoForm extends StatefulWidget {
  const UpdateInspeccionTipoForm({Key? key, this.inspeccionTipo}) : super(key: key);

  final InspeccionTipoEntity? inspeccionTipo;

  @override
  State<UpdateInspeccionTipoForm> createState() => _UpdateInspeccionTipoFormState();
}

class _UpdateInspeccionTipoFormState extends State<UpdateInspeccionTipoForm> {
  // GENERAL INSTANCES
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // CONTROLLERS
  late final TextEditingController _folioController;
  late final TextEditingController _nameController;
  late final TextEditingController _correoController;

  // PROPERTIES
  final int currentYear = DateTime.now().year;

  @override
  void initState() {
    _folioController    = TextEditingController(text: widget.inspeccionTipo?.folio ?? '');
    _nameController     = TextEditingController(text: widget.inspeccionTipo?.name.toProperCase() ?? '');
    _correoController   = TextEditingController(text: widget.inspeccionTipo?.correo ?? '');
    super.initState();
  }

  @override
  void dispose() {
    _folioController.dispose();
    _nameController.dispose();
    _correoController.dispose();
    super.dispose();
  }

  // METHODS
  Future<void> _showFailureDialog(BuildContext context, RemoteInspeccionTipoFailure state) {
    return showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: const SizedBox.shrink(),
        content: Row(
          children: <Widget>[
            Icon(Icons.error, color: Theme.of(context).colorScheme.error),
            SizedBox(width: $styles.insets.xs + 2),
            Flexible(
              child: Text(
                state.failure?.response?.data.toString() ?? 'Se produjo un error inesperado. Intenta actualizar el tipo de inspección de nuevo.',
                style: $styles.textStyles.title2.copyWith(
                  height: 1.5,
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => context.pop(),
            child: Text($strings.acceptButtonText, style: $styles.textStyles.button),
          ),
        ],
      ),
    );
  }

  Future<void> _showFailedMessageDialog(BuildContext context, RemoteInspeccionTipoFailedMessage state) {
    return showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: const SizedBox.shrink(),
        content: Row(
          children: <Widget>[
            Icon(Icons.error, color: Theme.of(context).colorScheme.error),
            SizedBox(width: $styles.insets.xs + 2),
            Flexible(
              child: Text(
                state.errorMessage.toString(),
                style: $styles.textStyles.title2.copyWith(
                  height: 1.5,
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => context.pop(),
            child: Text($strings.acceptButtonText, style: $styles.textStyles.button),
          ),
        ],
      ),
    );
  }

  void _handleUpdateInspeccionTipo() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Formulario incompleto'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    } else {
      _formKey.currentState!.save();
      final InspeccionTipoEntity objData = InspeccionTipoEntity(
        idInspeccionTipo  : widget.inspeccionTipo!.idInspeccionTipo,
        folio             : _folioController.text,
        name              : _nameController.text,
        correo            : _correoController.text,
      );
      BlocProvider.of<RemoteInspeccionTipoBloc>(context).add(UpdateInspeccionTipo(objData));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          // FOLIO:
          LabeledTextField(
            autoFocus: true,
            controller: _folioController,
            hintText: 'INST-$currentYear-xxxx',
            labelText: 'Folio:',
            validator: FormValidators.textValidator,
          ),

          Gap($styles.insets.md),

          // NOMBRE:
          LabeledTextField(
            controller: _nameController,
            labelText: 'Nombre:',
            validator: FormValidators.textValidator,
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

          BlocConsumer<RemoteInspeccionTipoBloc, RemoteInspeccionTipoState>(
            listener: (BuildContext context, RemoteInspeccionTipoState state) {
              if (state is RemoteInspeccionTipoFailure) {
                _showFailureDialog(context, state);
              }

              if (state is RemoteInspeccionTipoFailedMessage) {
                _showFailedMessageDialog(context, state);
              }

              if (state is RemoteInspeccionTipoResponseSuccess) {
                Navigator.pop(context);

                ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(
                      'Tipo de inspección actualizado exitosamente',
                      style: $styles.textStyles.bodySmall,
                    ),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
            builder: (BuildContext context, RemoteInspeccionTipoState state) {
              if (state is RemoteInspeccionTipoLoading) {
                return FilledButton(
                  onPressed: null,
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all<Size?>(
                      const Size(double.infinity, 48),
                    ),
                  ),
                  child: LoadingIndicator(
                    color: Theme.of(context).primaryColor,
                    width: 20,
                    height: 20,
                    strokeWidth: 2,
                  ),
                );
              }

              return FilledButton(
                onPressed: _handleUpdateInspeccionTipo,
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size?>(
                    const Size(double.infinity, 48),
                  ),
                ),
                child: Text($strings.saveButtonText, style: $styles.textStyles.button),
              );
            },
          ),
        ],
      ),
    );
  }
}
