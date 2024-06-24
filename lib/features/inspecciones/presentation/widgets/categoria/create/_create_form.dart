part of '../../../pages/configuracion/categorias/categorias_page.dart';

class _CreateCategoriaForm extends StatefulWidget {
  const _CreateCategoriaForm({Key? key, this.inspeccionTipo}) : super(key: key);

  final InspeccionTipoEntity? inspeccionTipo;

  @override
  State<_CreateCategoriaForm> createState() => _CreateCategoriaFormState();
}

class _CreateCategoriaFormState extends State<_CreateCategoriaForm> {
  // GLOBAL KEY
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // CONTROLLERS
  late final TextEditingController _nameController;

  // STATE
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
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
      builder: (BuildContext context) => ServerFailedDialog(
        errorMessage: errorMessage ?? 'Se produjo un error inesperado. Intenta crear de nuevo la categoría.',
      ),
    );
  }

  // METHODS
  void _store() {
    final CategoriaStoreReqEntity objPost = CategoriaStoreReqEntity(
      name                  : _nameController.text,
      idInspeccionTipo      : widget.inspeccionTipo?.idInspeccionTipo ?? '',
      inspeccionTipoCodigo  : widget.inspeccionTipo?.codigo           ?? '',
      inspeccionTipoName    : widget.inspeccionTipo?.name             ?? '',
    );

    BlocProvider.of<RemoteCategoriaBloc>(context).add(StoreCategoria(objPost));
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
            hintText        : 'Ingresa el nombre',
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
                    elevation       : 0,
                    behavior        : SnackBarBehavior.fixed,
                  ),
                );

                // Actualizamos la lista de categorías.
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
