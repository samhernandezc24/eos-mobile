import 'package:eos_mobile/core/common/widgets/controls/loading_indicator.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/inspecciones/presentation/bloc/categoria/remote/remote_categoria_bloc.dart';
import 'package:eos_mobile/shared/shared.dart';

class UpdateCategoriaForm extends StatefulWidget {
  const UpdateCategoriaForm({Key? key, this.categoria, this.inspeccionTipo}) : super(key: key);

  final CategoriaEntity? categoria;
  final InspeccionTipoEntity? inspeccionTipo;

  @override
  State<UpdateCategoriaForm> createState() => _UpdateCategoriaFormState();
}

class _UpdateCategoriaFormState extends State<UpdateCategoriaForm> {
  // GENERAL INSTANCES
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // CONTROLLERS
  late final TextEditingController _nameController;

  @override
  void initState() {
    _nameController     = TextEditingController(text: widget.categoria?.name.toProperCase() ?? '');
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  // METHODS
  Future<void> _showFailureDialog(BuildContext context, RemoteCategoriaFailure state) {
    return showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: const SizedBox.shrink(),
        content: Row(
          children: <Widget>[
            Icon(Icons.error, color: Theme.of(context).colorScheme.error),
            SizedBox(width: $styles.insets.xs + 2),
            Flexible(
              child: Text(
                state.failure?.response?.data.toString() ?? 'Se produjo un error inesperado. Intenta actualizar la categoría de nuevo.',
                style: $styles.textStyles.title2.copyWith(
                  height: 1.5,
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => context.pop(),
            child: Text($strings.acceptButtonText, style: $styles.textStyles.button),
          ),
        ],
      ),
    );
  }

  Future<void> _showFailedMessageDialog(BuildContext context, RemoteCategoriaFailedMessage state) {
    return showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: const SizedBox.shrink(),
        content: Row(
          children: <Widget>[
            Icon(Icons.error, color: Theme.of(context).colorScheme.error),
            SizedBox(width: $styles.insets.xs + 2),
            Flexible(
              child: Text(
                state.errorMessage.toString(),
                style: $styles.textStyles.title2.copyWith(
                  height: 1.5,
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => context.pop(),
            child: Text($strings.acceptButtonText, style: $styles.textStyles.button),
          ),
        ],
      ),
    );
  }

  void _handleUpdateCategoria() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Formulario incompleto'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    } else {
      _formKey.currentState!.save();
      final CategoriaEntity objData = CategoriaEntity(
        idCategoria           : widget.categoria?.idCategoria ?? '',
        name                  : _nameController.text,
        idInspeccionTipo      : widget.categoria?.idInspeccionTipo ?? '',
        inspeccionTipoCodigo  : widget.categoria?.inspeccionTipoCodigo ?? '',
        inspeccionTipoName    : widget.categoria?.inspeccionTipoName ?? '',
      );
      BlocProvider.of<RemoteCategoriaBloc>(context).add(UpdateCategoria(objData));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          // NOMBRE:
          LabeledTextField(
            controller: _nameController,
            autoFocus: true,
            labelText: 'Nombre:',
            validator: FormValidators.textValidator,
          ),

          Gap($styles.insets.lg),

          BlocConsumer<RemoteCategoriaBloc, RemoteCategoriaState>(
            listener: (BuildContext context, RemoteCategoriaState state) {
              if (state is RemoteCategoriaFailure) {
                _showFailureDialog(context, state);
                context.read<RemoteCategoriaBloc>().add(ListCategorias(widget.inspeccionTipo!));
              }

              if (state is RemoteCategoriaFailedMessage) {
                _showFailedMessageDialog(context, state);
                context.read<RemoteCategoriaBloc>().add(ListCategorias(widget.inspeccionTipo!));
              }

              if (state is RemoteCategoriaResponseSuccess) {
                Navigator.pop(context);

                ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(state.apiResponse.message, softWrap: true),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                    elevation: 0,
                  ),
                );

                context.read<RemoteCategoriaBloc>().add(ListCategorias(widget.inspeccionTipo!));
              }
            },
            builder: (BuildContext context, RemoteCategoriaState state) {
              if (state is RemoteCategoriaLoading) {
                return FilledButton(
                  onPressed: null,
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all<Size?>(
                      const Size(double.infinity, 48),
                    ),
                  ),
                  child: LoadingIndicator(
                    color: Theme.of(context).primaryColor,
                    width: 20,
                    height: 20,
                    strokeWidth: 2,
                  ),
                );
              }

              return FilledButton(
                onPressed: _handleUpdateCategoria,
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size?>(
                    const Size(double.infinity, 48),
                  ),
                ),
                child: Text($strings.saveButtonText, style: $styles.textStyles.button),
              );
            },
          ),
        ],
      ),
    );
  }
}
