import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/inspeccion_tipo/remote/remote_inspeccion_tipo_bloc.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:eos_mobile/ui/common/controls/app_loading_indicator.dart';

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
  late final TextEditingController _codigoController;
  late final TextEditingController _nameController;

  @override
  void initState() {
    _codigoController   = TextEditingController(text: widget.inspeccionTipo?.codigo ?? '');
    _nameController     = TextEditingController(text: widget.inspeccionTipo?.name.toProperCase() ?? '');
    super.initState();
  }

  @override
  void dispose() {
    _codigoController.dispose();
    _nameController.dispose();
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
                state.failure?.errorMessage ?? 'Se produjo un error inesperado. Intenta actualizar el tipo de inspección de nuevo.',
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
    final InspeccionTipoEntity objData = InspeccionTipoEntity(
      idInspeccionTipo  : widget.inspeccionTipo!.idInspeccionTipo,
      codigo            : _codigoController.text,
      name              : _nameController.text,
    );
    final bool isValidForm = _formKey.currentState!.validate();

    if (isValidForm) {
      _formKey.currentState!.save();
      BlocProvider.of<RemoteInspeccionTipoBloc>(context).add(UpdateInspeccionTipo(objData));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          // CÓDIGO:
          LabeledTextField(
            controller: _codigoController,
            labelText: 'Código:',
            isReadOnly: true,
          ),

          Gap($styles.insets.md),

          // NOMBRE:
          LabeledTextField(
            autoFocus: true,
            controller: _nameController,
            labelText: 'Nombre:',
            validator: FormValidators.textValidator,
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
                    content: Text(state.apiResponse.message, softWrap: true),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.fixed,
                    elevation: 0,
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
                  child: const AppLoadingIndicator(width: 20, height: 20),
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
