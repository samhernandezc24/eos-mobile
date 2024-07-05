part of '../../../../pages/configuracion/inspeccion_tipo/inspeccion_tipo_page.dart';

class _EditInspeccionTipoForm extends StatefulWidget {
  const _EditInspeccionTipoForm({Key? key, this.objInspeccionTipo, this.onComplete}) : super(key: key);

  final InspeccionTipoEntity? objInspeccionTipo;
  final VoidCallback? onComplete;

  @override
  State<_EditInspeccionTipoForm> createState() => _EditInspeccionTipoFormState();
}

class _EditInspeccionTipoFormState extends State<_EditInspeccionTipoForm> {
  // GLOBAL KEY
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // CONTROLLERS
  late TextEditingController _codigoController;
  late TextEditingController _nameController;

  // STATE
  @override
  void initState() {
    super.initState();
    _codigoController = TextEditingController(text: widget.objInspeccionTipo?.codigo ?? '');
    _nameController   = TextEditingController(text: widget.objInspeccionTipo?.name ?? '');
  }

  @override
  void dispose() {
    _codigoController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  // EVENTS
  void _handleUpdatePressed() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _update();
    }
  }

  Future<void> _showServerErrorDialog(BuildContext context, String? message) async {
    return showDialog<void>(context: context, builder: (BuildContext context) => ServerFailedDialog(message: message ?? AppStrings.errorGenericMessage));
  }

  // METHODS
  Future<void> _update() async {
    final InspeccionTipoEntity objPost = InspeccionTipoEntity(
      idInspeccionTipo  : widget.objInspeccionTipo?.idInspeccionTipo ?? '',
      codigo            : _codigoController.text,
      name              : _nameController.text,
    );

    context.read<RemoteInspeccionTipoBloc>().add(UpdateInspeccionTipo(objPost));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.inspeccionTipoEditAppBarTitle.replaceFirst('{inspeccionTipo}', widget.objInspeccionTipo?.name ?? ''),
          style: $styles.textStyles.h3,
        ),
      ),
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
                  if (state is RemoteInspeccionTipoServerFailedMessageUpdate) {
                    _showServerErrorDialog(context, state.error);

                    // Ejecutar callback.
                    widget.onComplete!();
                  }

                  if (state is RemoteInspeccionTipoServerExceptionMessageUpdate) {
                    _showServerErrorDialog(context, state.error?.message);

                    // Ejecutar callback.
                    widget.onComplete!();
                  }

                  // SUCCESS
                  if (state is RemoteInspeccionTipoUpdate) {
                    Navigator.of(context).pop(); // Cerramos el modal

                    ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content         : Text(
                          state.objResponse?.message ?? 'Actualizado',
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
                  if (state is RemoteInspeccionTipoUpdateLoading) {
                    return FilledButton(
                      onPressed : null,
                      style     : ButtonStyle(minimumSize: MaterialStateProperty.all<Size?>(const Size(double.infinity, 48))),
                      child     : const AppLoadingIndicator(width: 20, height: 20),
                    );
                  }

                  return FilledButton(
                    onPressed : _handleUpdatePressed,
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
