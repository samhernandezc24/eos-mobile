part of '../../../pages/configuracion/inspecciones_tipos/inspecciones_tipos_page.dart';

class _CreateInspeccionTipoForm extends StatefulWidget {
  const _CreateInspeccionTipoForm({Key? key}) : super(key: key);

  @override
  State<_CreateInspeccionTipoForm> createState() => _CreateInspeccionTipoFormState();
}

class _CreateInspeccionTipoFormState extends State<_CreateInspeccionTipoForm> {
  // GLOBAL KEY
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // CONTROLLERS
  late final TextEditingController _codigoController;
  late final TextEditingController _nameController;

  // STATE
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

  // EVENTS
  void _handleStorePressed() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _store();
    }
  }

  Future<void> _showServerFailedDialog(BuildContext context, String? errorMessage) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context)  => ServerFailedDialog(
        errorMessage: errorMessage ?? 'Se produjo un error inesperado. Intenta crear de nuevo el tipo de inspección.',
      ),
    );
  }

  // METHODS
  void _store() {
    final InspeccionTipoStoreReqEntity objPost = InspeccionTipoStoreReqEntity(
      codigo  : _codigoController.text,
      name    : _nameController.text,
    );

    BlocProvider.of<RemoteInspeccionTipoBloc>(context).add(StoreInspeccionTipo(objPost));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key   : _formKey,
      child : Column(
        crossAxisAlignment  : CrossAxisAlignment.stretch,
        children            : <Widget>[
          // CÓDIGO:
          LabeledTextFormField(
            controller  : _codigoController,
            label       : '* Código:',
            isReadOnly  : true,
            isEnabled   : false,
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
            hintText        : 'Ingresa el nombre',
          ),

          Gap($styles.insets.lg),

          BlocConsumer<RemoteInspeccionTipoBloc, RemoteInspeccionTipoState>(
            listener: (BuildContext context, RemoteInspeccionTipoState state) {
              if (state is RemoteInspeccionTipoServerFailedMessage) {
                _showServerFailedDialog(context, state.errorMessage);
              }

              if (state is RemoteInspeccionTipoServerFailure) {
                _showServerFailedDialog(context, state.failure?.errorMessage);
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
                    elevation       : 0,
                    behavior        : SnackBarBehavior.fixed,
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
                onPressed : _handleStorePressed,
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
