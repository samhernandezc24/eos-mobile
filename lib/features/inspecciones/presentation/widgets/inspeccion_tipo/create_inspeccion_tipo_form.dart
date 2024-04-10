import 'package:eos_mobile/core/common/widgets/controls/loading_indicator.dart';
import 'package:eos_mobile/core/utils/string_utils.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/inspeccion_tipo/remote/remote_inspeccion_tipo_bloc.dart';
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
  late final TextEditingController _codigoController;
  late final TextEditingController _nameController;

  // PROPERTIES
  final String codigo   = StringUtils.generateRandomNumericCode();

  @override
  void initState() {
    _codigoController   = TextEditingController(text: codigo);
    _nameController     = TextEditingController();
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
                state.failure?.response?.data.toString() ?? 'Se produjo un error inesperado. Intenta crear el tipo de inspección de nuevo.',
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

  void _handleStoreInspeccionTipo() {
    final InspeccionTipoReqEntity objData = InspeccionTipoReqEntity(codigo: _codigoController.text, name: _nameController.text);
    final bool isValidForm = _formKey.currentState!.validate();

    if (isValidForm) {
      _formKey.currentState!.save();
      BlocProvider.of<RemoteInspeccionTipoBloc>(context).add(StoreInspeccionTipo(objData));
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

          Gap($styles.insets.md) ,

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
                    behavior: SnackBarBehavior.floating,
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
                  child: LoadingIndicator(
                    color: Theme.of(context).primaryColor,
                    width: 20,
                    height: 20,
                    strokeWidth: 2,
                  ),
                );
              }

              return FilledButton(
                onPressed: _handleStoreInspeccionTipo,
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
