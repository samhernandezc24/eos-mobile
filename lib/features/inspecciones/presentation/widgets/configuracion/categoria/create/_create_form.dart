part of '../../../../pages/configuracion/categoria/categoria_page.dart';

class _CreateCategoriaForm extends StatefulWidget {
  const _CreateCategoriaForm({
    required this.objInspeccionTipo,
    required this.orden,
    Key? key,
    this.onComplete,
  }) : super(key: key);

  final InspeccionTipoEntity objInspeccionTipo;
  final VoidCallback? onComplete;
  final int orden;

  @override
  State<_CreateCategoriaForm> createState() => _CreateCategoriaFormState();
}

class _CreateCategoriaFormState extends State<_CreateCategoriaForm> {
  // GLOBAL KEY
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // CONTROLLERS
  late TextEditingController _nameController;

  // STATE
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
    final CategoriaStoreReqEntity objPost = CategoriaStoreReqEntity(
      name                  : _nameController.text,
      idInspeccionTipo      : widget.objInspeccionTipo.idInspeccionTipo,
      inspeccionTipoCodigo  : widget.objInspeccionTipo.codigo,
      inspeccionTipoName    : widget.objInspeccionTipo.name,
      orden                 : widget.orden,
    );

    context.read<RemoteCategoriaBloc>().add(StoreCategoria(objPost));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.categoriaCreateAppBarTitle, style: $styles.textStyles.h3)),
      body: Container(
        padding: EdgeInsets.all($styles.insets.sm),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // NOMBRE
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
                  // ERROR
                  if (state is RemoteCategoriaServerFailedMessageStore) {
                    _showServerErrorDialog(context, state.error);

                    // Ejecutar callback.
                    widget.onComplete!();
                  }

                  if (state is RemoteCategoriaServerExceptionMessageStore) {
                    _showServerErrorDialog(context, state.error?.message);

                    // Ejecutar callback.
                    widget.onComplete!();
                  }

                  // SUCCESS
                  if (state is RemoteCategoriaStore) {
                    Navigator.of(context).pop(); // Cerramos el modal

                    ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: Text(
                          state.objResponse?.message ?? 'Nueva categoría',
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
                builder: (BuildContext context, RemoteCategoriaState state) {
                  // LOADING
                  if (state is RemoteCategoriaStoreLoading) {
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
