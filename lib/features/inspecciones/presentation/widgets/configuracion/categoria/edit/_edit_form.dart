part of '../../../../pages/configuracion/categoria/categoria_page.dart';

class _EditCategoriaForm extends StatefulWidget {
  const _EditCategoriaForm({Key? key, this.objCategoria, this.onComplete}) : super(key: key);

  final CategoriaEntity? objCategoria;
  final VoidCallback? onComplete;

  @override
  State<_EditCategoriaForm> createState() => _EditCategoriaFormState();
}

class _EditCategoriaFormState extends State<_EditCategoriaForm> {
  // GLOBAL KEY
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // CONTROLLERS
  late TextEditingController _nameController;

  // STATE
  @override
  void initState() {
    super.initState();
    _nameController   = TextEditingController(text: widget.objCategoria?.name ?? '');
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

  Future<void> _showServerErrorDialog(BuildContext context, String? message) async {
    return showDialog<void>(context: context, builder: (BuildContext context) => ServerFailedDialog(message: message ?? AppStrings.errorGenericMessage));
  }

  // METHODS
  Future<void> _update() async {
    final CategoriaUpdateReqEntity objPost = CategoriaUpdateReqEntity(
      idInspeccionTipo      : widget.objCategoria?.idInspeccionTipo ?? '',
      idCategoria           : widget.objCategoria?.idCategoria      ?? '',
      name                  : _nameController.text,
    );

    context.read<RemoteCategoriaBloc>().add(UpdateCategoria(objPost));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.categoriaEditAppBarTitle.replaceFirst('{categoria}', widget.objCategoria?.name ?? ''),
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
                  if (state is RemoteCategoriaServerFailedMessageUpdate) {
                    _showServerErrorDialog(context, state.error);

                    // Ejecutar callback.
                    widget.onComplete!();
                  }

                  if (state is RemoteCategoriaServerExceptionMessageUpdate) {
                    _showServerErrorDialog(context, state.error?.message);

                    // Ejecutar callback.
                    widget.onComplete!();
                  }

                  // SUCCESS
                  if (state is RemoteCategoriaUpdate) {
                    Navigator.of(context).pop(); // Cerramos el modal

                    ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: Text(
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
                builder: (BuildContext context, RemoteCategoriaState state) {
                  // LOADING
                  if (state is RemoteCategoriaUpdateLoading) {
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
