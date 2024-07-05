part of '../../../../pages/configuracion/inspeccion_tipo/inspeccion_tipo_page.dart';

class _CreateInspeccionTipoForm extends StatefulWidget {
  const _CreateInspeccionTipoForm({Key? key, this.onComplete}) : super(key: key);

  final VoidCallback? onComplete;

  @override
  State<_CreateInspeccionTipoForm> createState() => _CreateInspeccionTipoFormState();
}

class _CreateInspeccionTipoFormState extends State<_CreateInspeccionTipoForm> {
  // GLOBAL KEY
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // CONTROLLERS
  late TextEditingController _codigoController;
  late TextEditingController _nameController;

  // STATE
  @override
  void initState() {
    super.initState();
    _codigoController = TextEditingController(text: Globals.generateRandomNumericCode());
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

  Future<void> _showServerErrorDialog(BuildContext context, String? message) async {
    return showDialog<void>(context: context, builder: (BuildContext context) => ServerFailedDialog(message: message ?? AppStrings.errorGenericMessage));
  }

  // METHODS
  Future<void> _store() async {
    final InspeccionTipoStoreReqEntity objPost = InspeccionTipoStoreReqEntity(
      codigo  : _codigoController.text,
      name    : _nameController.text
    );

    context.read<RemoteInspeccionTipoBloc>().add(StoreInspeccionTipo(objPost));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.inspeccionTipoCreateAppBarTitle, style: $styles.textStyles.h3)),
      body: Container(
        padding: EdgeInsets.all($styles.insets.sm),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // CODIGO
              LabeledTextFormField(
                controller  : _codigoController,
                label       : 'Código:',
                readOnly    : true,
                isEnabled   : false,
                validator   : FormValidators.textValidator,
              ),

              Gap($styles.insets.sm),

              // NOMBRE
              LabeledTextFormField(
                controller      : _nameController,
                hintText        : 'Ingresa el nombre',
                label           : '* Nombre:',
                validator       : FormValidators.textValidator,
                textInputAction : TextInputAction.done,
              ),

              Gap($styles.insets.lg),

              BlocConsumer<RemoteInspeccionTipoBloc, RemoteInspeccionTipoState>(
                listener: (BuildContext context, RemoteInspeccionTipoState state) {
                  // ERROR
                  if (state is RemoteInspeccionTipoServerFailedMessageStore) {
                    _showServerErrorDialog(context, state.error);

                    // Ejecutar callback.
                    widget.onComplete!();
                  }

                  if (state is RemoteInspeccionTipoServerExceptionMessageStore) {
                    _showServerErrorDialog(context, state.error?.message);

                    // Ejecutar callback.
                    widget.onComplete!();
                  }

                  // SUCCESS
                  if (state is RemoteInspeccionTipoStore) {
                    Navigator.of(context).pop(); // Cerramos el modal

                    ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content         : Text(
                          state.objResponse?.message ?? 'Nuevo tipo de inspección',
                          style     : $styles.textStyles.bodySmall.copyWith(color: $styles.colors.white),
                          softWrap  : true,
                        ),
                        backgroundColor : $styles.colors.success,
                        elevation       : 0,
                        behavior        : SnackBarBehavior.fixed,
                      ),
                    );

                    // Ejecutar callback.
                    widget.onComplete!();
                  }
                },
                builder: (BuildContext context, RemoteInspeccionTipoState state) {
                  // LOADING
                  if (state is RemoteInspeccionTipoStoreLoading) {
                    return FilledButton(
                      onPressed : null,
                      style     : ButtonStyle(minimumSize: MaterialStateProperty.all<Size?>(const Size(double.infinity, 48))),
                      child     : const AppLoadingIndicator(width: 20, height: 20),
                    );
                  }

                  return FilledButton(
                    onPressed : _handleStorePressed,
                    style     : ButtonStyle(minimumSize: MaterialStateProperty.all<Size?>(const Size(double.infinity, 48))),
                    child     : Text(AppStrings.btnSaveText, style: $styles.textStyles.button),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
