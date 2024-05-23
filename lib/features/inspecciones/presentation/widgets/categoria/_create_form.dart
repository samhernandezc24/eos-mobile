part of '../../pages/configuracion/categorias/categorias_page.dart';

class _CreateForm extends StatefulWidget {
  const _CreateForm({Key? key, this.inspeccionTipo}) : super(key: key);

  final InspeccionTipoEntity? inspeccionTipo;

  @override
  State<_CreateForm> createState() => _CreateFormState();
}

class _CreateFormState extends State<_CreateForm> {
  // GLOBAL KEY
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // CONTROLLERS
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();

    _nameController   = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  // METHODS
  void _handleStoreCategoria() {
    final CategoriaStoreReqEntity objData = CategoriaStoreReqEntity(
      name                  : _nameController.text,
      idInspeccionTipo      : widget.inspeccionTipo?.idInspeccionTipo ?? '',
      inspeccionTipoCodigo  : widget.inspeccionTipo?.codigo           ?? '',
      inspeccionTipoName    : widget.inspeccionTipo?.name             ?? '',
    );

    final bool isValidForm = _formKey.currentState!.validate();

    // Verificar la validacion en el formulario.
    if (isValidForm) {
      _formKey.currentState!.save();
      BlocProvider.of<RemoteCategoriaBloc>(context).add(StoreCategoria(objData));
    }
  }

  Future<void> _showServerFailedMessageOnStore(BuildContext context, RemoteCategoriaServerFailedMessage state) async {
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
            state.errorMessage ?? 'Se produjo un error inesperado. Intenta crear de nuevo la categoría.',
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

  Future<void> _showServerFailureOnStore(BuildContext context, RemoteCategoriaServerFailure state) async {
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
            state.failure?.errorMessage ?? 'Se produjo un error inesperado. Intenta crear de nuevo la categoría.',
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
                _showServerFailedMessageOnStore(context, state);

                // Actualizar listado de categorías.
                context.read<RemoteCategoriaBloc>().add(ListCategorias(widget.inspeccionTipo!));
              }

              if (state is RemoteCategoriaServerFailure) {
                _showServerFailureOnStore(context, state);

                // Actualizar listado de categorías.
                context.read<RemoteCategoriaBloc>().add(ListCategorias(widget.inspeccionTipo!));
              }

              if (state is RemoteCategoriaStored) {
                // Cerrar el diálogo antes de mostrar el SnackBar.
                Navigator.of(context).pop();

                // Mostramos el SnackBar.
                ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content         : Text(state.objResponse?.message ?? 'Nueva categoría', softWrap: true),
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
              if (state is RemoteCategoriaStoring) {
                return FilledButton(
                  onPressed : null,
                  style     : ButtonStyle(minimumSize: MaterialStateProperty.all<Size?>(const Size(double.infinity, 48))),
                  child     : const AppLoadingIndicator(width: 20, height: 20),
                );
              }

              return FilledButton(
                onPressed : _handleStoreCategoria,
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