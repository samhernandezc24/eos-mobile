part of '../../../pages/configuracion/categorias/categorias_page.dart';

class _EditCategoriaForm extends StatefulWidget {
  const _EditCategoriaForm({Key? key, this.categoria, this.inspeccionTipo}) : super(key: key);

  final CategoriaEntity? categoria;
  final InspeccionTipoEntity? inspeccionTipo;

  @override
  State<_EditCategoriaForm> createState() => _EditCategoriaFormState();
}

class _EditCategoriaFormState extends State<_EditCategoriaForm> {
  // GLOBAL KEY
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // CONTROLLERS
  late final TextEditingController _nameController;

  // STATE
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.categoria?.name ?? '');
  }

  @override
  void dispose() {
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
        errorMessage: errorMessage ?? 'Se produjo un error inesperado. Intenta actualizar de nuevo la categoría.',
      ),
    );
  }

  // METHODS
  void _update() {
    final CategoriaEntity objPost = CategoriaEntity(
      idCategoria           : widget.categoria?.idCategoria           ?? '',
      name                  : _nameController.text,
      idInspeccionTipo      : widget.categoria?.idInspeccionTipo      ?? '',
      inspeccionTipoCodigo  : widget.categoria?.inspeccionTipoCodigo  ?? '',
      inspeccionTipoName    : widget.categoria?.inspeccionTipoName    ?? '',
    );

    BlocProvider.of<RemoteCategoriaBloc>(context).add(UpdateCategoria(objPost));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key   : _formKey,
      child : Column(
        crossAxisAlignment  : CrossAxisAlignment.stretch,
        children            : <Widget>[
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
                _showServerFailedDialog(context, state.errorMessage);
                context.read<RemoteCategoriaBloc>().add(ListCategorias(widget.inspeccionTipo!));
              }

              if (state is RemoteCategoriaServerFailure) {
                _showServerFailedDialog(context, state.failure?.errorMessage);
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
                    elevation       : 0,
                    behavior        : SnackBarBehavior.fixed,
                  ),
                );

                // Actualizamos el listado de categorías.
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
