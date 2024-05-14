part of '../../pages/configuracion/inspecciones_tipos/inspecciones_tipos_page.dart';

class _CreateForm extends StatefulWidget {
  const _CreateForm({Key? key}) : super(key: key);

  @override
  State<_CreateForm> createState() => _CreateFormState();
}

class _CreateFormState extends State<_CreateForm> {
  // GLOBAL KEY
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // CONTROLLERS
  late final TextEditingController _codigoController;
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();

    _codigoController = TextEditingController(text: StringUtils.generateRandomNumericCode());
    _nameController   = TextEditingController();
  }

  @override
  void dispose() {
    _codigoController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  // METHODS
  void _handleStoreInspeccionTipo() {
    final InspeccionTipoStoreReqEntity objData = InspeccionTipoStoreReqEntity(codigo: _codigoController.text, name: _nameController.text);
    final bool isValidForm = _formKey.currentState!.validate();

    // Verificar la validacion en el formulario.
    if (isValidForm) {
      _formKey.currentState!.save();
      BlocProvider.of<RemoteInspeccionTipoBloc>(context).add(StoreInspeccionTipo(objData));
    }
  }

  Future<void> _showServerFailedMessageOnStore(BuildContext context, RemoteInspeccionTipoServerFailedMessage state) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment : MainAxisAlignment.center,
            children          : <Widget>[
              Icon(Icons.error, color: Theme.of(context).colorScheme.error, size: 48),
            ],
          ),
          content: Text(
            state.errorMessage ?? 'Se produjo un error inesperado. Intenta crear de nuevo el tipo de inspección.',
            style: $styles.textStyles.title2.copyWith(height: 1.5),
          ),
          actions: <Widget>[
            TextButton(
              onPressed : () => Navigator.pop(context, 'Aceptar'),
              child     : Text($strings.acceptButtonText, style: $styles.textStyles.button),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showServerFailureOnStore(BuildContext context, RemoteInspeccionTipoServerFailure state) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment : MainAxisAlignment.center,
            children          : <Widget>[
              Icon(Icons.error, color: Theme.of(context).colorScheme.error, size: 48),
            ],
          ),
          content: Text(
            state.failure?.errorMessage ?? 'Se produjo un error inesperado. Intenta crear de nuevo el tipo de inspección.',
            style: $styles.textStyles.title2.copyWith(height: 1.5),
          ),
          actions: <Widget>[
            TextButton(
              onPressed : () => Navigator.pop(context, 'Aceptar'),
              child     : Text($strings.acceptButtonText, style: $styles.textStyles.button),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // CÓDIGO:
          LabeledTextFormField(
            controller  : _codigoController,
            label       : '* Código:',
            isReadOnly  : true,
            validator   : FormValidators.textValidator,
          ),

          Gap($styles.insets.sm),

          // NOMBRE:
          LabeledTextFormField(
            autoFocus       : true,
            controller      : _nameController,
            label           : '* Nombre:',
            validator       : FormValidators.textValidator,
            textInputAction : TextInputAction.done,
          ),

          Gap($styles.insets.lg),

          BlocConsumer<RemoteInspeccionTipoBloc, RemoteInspeccionTipoState>(
            listener: (BuildContext context, RemoteInspeccionTipoState state) {
              if (state is RemoteInspeccionTipoServerFailedMessage) {
                _showServerFailedMessageOnStore(context, state);
              }

              if (state is RemoteInspeccionTipoServerFailure) {
                _showServerFailureOnStore(context, state);
              }

              if (state is RemoteInspeccionTipoStored) {
                // Cerrar el diálogo antes de mostrar el SnackBar.
                Navigator.of(context).pop();

                // Mostramos el SnackBar.
                ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content         : Text(state.objResponse?.message ?? 'Nuevo tipo de inspección', softWrap: true),
                    backgroundColor : Colors.green,
                    behavior        : SnackBarBehavior.fixed,
                    elevation       : 0,
                  ),
                );
              }
            },
            builder: (BuildContext context, RemoteInspeccionTipoState state) {
              if (state is RemoteInspeccionTipoStoring) {
                return FilledButton(
                  onPressed : null,
                  style     : ButtonStyle(minimumSize: MaterialStateProperty.all<Size?>(const Size(double.infinity, 48))),
                  child     : const AppLoadingIndicator(width: 20, height: 20),
                );
              }

              return FilledButton(
                onPressed : _handleStoreInspeccionTipo,
                style     : ButtonStyle(minimumSize: MaterialStateProperty.all<Size?>(const Size(double.infinity, 48))),
                child     : Text($strings.saveButtonText, style: $styles.textStyles.button),
              );
            },
          ),
        ],
      ),
    );
  }
}
