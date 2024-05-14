part of '../../pages/configuracion/categorias/categorias_page.dart';

class _EditForm extends StatefulWidget {
  const _EditForm({Key? key, this.categoria, this.inspeccionTipo}) : super(key: key);

  final CategoriaEntity? categoria;
  final InspeccionTipoEntity? inspeccionTipo;

  @override
  State<_EditForm> createState() => _EditFormState();
}

class _EditFormState extends State<_EditForm> {
  // GLOBAL KEY
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // CONTROLLERS
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();

    _nameController   = TextEditingController(text: widget.categoria?.name.toProperCase() ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  // METHODS
  void _handleUpdateCategoria() {
    final CategoriaEntity objData = CategoriaEntity(
      idCategoria           : widget.categoria?.idCategoria           ?? '',
      name                  : _nameController.text,
      idInspeccionTipo      : widget.categoria?.idInspeccionTipo      ?? '',
      inspeccionTipoCodigo  : widget.categoria?.inspeccionTipoCodigo  ?? '',
      inspeccionTipoName    : widget.categoria?.inspeccionTipoName    ?? '',
    );

    final bool isValidForm = _formKey.currentState!.validate();

    // Verificar la validacion en el formulario.
    if (isValidForm) {
      _formKey.currentState!.save();
      BlocProvider.of<RemoteCategoriaBloc>(context).add(UpdateCategoria(objData));
    }
  }

  Future<void> _showServerFailedMessageOnUpdate(BuildContext context, RemoteCategoriaServerFailedMessage state) async {
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
            state.errorMessage ?? 'Se produjo un error inesperado. Intenta actualizar de nuevo la categoría.',
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

  Future<void> _showServerFailureOnUpdate(BuildContext context, RemoteCategoriaServerFailure state) async {
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
            state.failure?.errorMessage ?? 'Se produjo un error inesperado. Intenta actualizar de nuevo la categoría.',
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
          // NOMBRE:
          LabeledTextFormField(
            autoFocus       : true,
            controller      : _nameController,
            label           : '* Nombre:',
            validator       : FormValidators.textValidator,
            textInputAction : TextInputAction.done,
          ),

          Gap($styles.insets.lg),

          BlocConsumer<RemoteCategoriaBloc, RemoteCategoriaState>(
            listener: (BuildContext context, RemoteCategoriaState state) {
              if (state is RemoteCategoriaServerFailedMessage) {
                _showServerFailedMessageOnUpdate(context, state);

                // Actualizar listado de categorías.
                context.read<RemoteCategoriaBloc>().add(ListCategorias(widget.inspeccionTipo!));
              }

              if (state is RemoteCategoriaServerFailure) {
                _showServerFailureOnUpdate(context, state);

                // Actualizar listado de categorías.
                context.read<RemoteCategoriaBloc>().add(ListCategorias(widget.inspeccionTipo!));
              }

              if (state is RemoteCategoriaUpdated) {
                // Cerrar el diálogo antes de mostrar el SnackBar.
                Navigator.of(context).pop();

                // Mostramos el SnackBar.
                ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content         : Text(state.objResponse?.message ?? 'Actualizado', softWrap: true),
                    backgroundColor : Colors.green,
                    behavior        : SnackBarBehavior.fixed,
                    elevation       : 0,
                  ),
                );

                // Actualizar listado de categorías.
                context.read<RemoteCategoriaBloc>().add(ListCategorias(widget.inspeccionTipo!));
              }
            },
            builder: (BuildContext context, RemoteCategoriaState state) {
              if (state is RemoteCategoriaUpdating) {
                return FilledButton(
                  onPressed : null,
                  style     : ButtonStyle(minimumSize: MaterialStateProperty.all<Size?>(const Size(double.infinity, 48))),
                  child     : const AppLoadingIndicator(width: 20, height: 20),
                );
              }

              return FilledButton(
                onPressed : _handleUpdateCategoria,
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
