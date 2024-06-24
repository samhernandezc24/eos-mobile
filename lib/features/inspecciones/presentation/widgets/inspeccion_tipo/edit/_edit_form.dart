part of '../../../pages/configuracion/inspecciones_tipos/inspecciones_tipos_page.dart';

class _EditInspeccionTipoForm extends StatefulWidget {
  const _EditInspeccionTipoForm({Key? key, this.inspeccionTipo}) : super(key: key);

  final InspeccionTipoEntity? inspeccionTipo;

  @override
  State<_EditInspeccionTipoForm> createState() => _EditInspeccionTipoFormState();
}

class _EditInspeccionTipoFormState extends State<_EditInspeccionTipoForm> {
  // GLOBAL KEY
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // CONTROLLERS
  late final TextEditingController _codigoController;
  late final TextEditingController _nameController;

  // STATE
  @override
  void initState() {
    super.initState();
    _codigoController = TextEditingController(text: widget.inspeccionTipo?.codigo ?? '');
    _nameController   = TextEditingController(text: widget.inspeccionTipo?.name ?? '');
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

  Future<void> _showServerFailedDialog(BuildContext context, String? errorMessage) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) => ServerFailedDialog(
        errorMessage: errorMessage ?? 'Se produjo un error inesperado. Intenta actualizar de nuevo el tipo de inspección.',
      ),
    );
  }

  // METHODS
  void _update() {
    final InspeccionTipoEntity objPost = InspeccionTipoEntity(
      idInspeccionTipo  : widget.inspeccionTipo?.idInspeccionTipo ?? '',
      codigo            : _codigoController.text,
      name              : _nameController.text,
    );

    BlocProvider.of<RemoteInspeccionTipoBloc>(context).add(UpdateInspeccionTipo(objPost));
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
            isEnabled   : false,
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
                _showServerFailedDialog(context, state.errorMessage);
              }

              if (state is RemoteInspeccionTipoServerFailure) {
                _showServerFailedDialog(context, state.failure?.errorMessage);
              }

              if (state is RemoteInspeccionTipoUpdated) {
                // Cerrar el diálogo antes de mostrar el SnackBar.
                Navigator.of(context).pop();

                // Mostramos el SnackBar.
                ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content         : Text(state.objResponse?.message ?? 'Actualizado', softWrap: true),
                    backgroundColor : Colors.green,
                    elevation       : 0,
                    behavior        : SnackBarBehavior.fixed,
                  ),
                );
              }
            },
            builder: (BuildContext context, RemoteInspeccionTipoState state) {
              if (state is RemoteInspeccionTipoUpdating) {
                return FilledButton(
                  onPressed : null,
                  style     : ButtonStyle(minimumSize: MaterialStateProperty.all<Size?>(const Size(double.infinity, 48))),
                  child     : const AppLoadingIndicator(width: 20, height: 20),
                );
              }

              return FilledButton(
                onPressed : _handleUpdatePressed,
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
