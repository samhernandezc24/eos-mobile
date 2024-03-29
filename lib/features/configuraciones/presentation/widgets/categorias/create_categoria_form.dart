import 'package:eos_mobile/core/common/widgets/controls/loading_indicator.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/categorias/categoria_req_entity.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/inspecciones_tipos/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/configuraciones/presentation/bloc/categoria/remote/remote_categoria_bloc.dart';
import 'package:eos_mobile/shared/shared.dart';

class CreateCategoriaForm extends StatefulWidget {
  const CreateCategoriaForm({Key? key, this.inspeccionTipo}) : super(key: key);

  final InspeccionTipoEntity? inspeccionTipo;

  @override
  State<CreateCategoriaForm> createState() => _CreateCategoriaFormState();
}

class _CreateCategoriaFormState extends State<CreateCategoriaForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();

  int _currentOrder = 0;

  @override
  void initState() {
    super.initState();
    _loadCurrentOrder();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _loadCurrentOrder() async {
    final currentOrder = await context.read<RemoteCategoriaBloc>().getCurrentOrder(widget.inspeccionTipo!);
    setState(() {
      _currentOrder = currentOrder;
    });
  }

  void _handleSubmitCategoria() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Formulario incompleto'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    } else {
      final objInspeccionData = CategoriaReqEntity(
        name                  : _nameController.text,
        idInspeccionTipo      : widget.inspeccionTipo!.idInspeccionTipo,
        inspeccionTipoFolio   : widget.inspeccionTipo!.folio,
        inspeccionTipoName    : widget.inspeccionTipo!.name,
        orden                 : _currentOrder,
      );
      // EVENTO DE GUARDADO
      context.read<RemoteCategoriaBloc>().add(CreateCategoria(objInspeccionData));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RemoteCategoriaBloc, RemoteCategoriaState>(
      listener: (BuildContext context, state) {
        if (state is RemoteCategoriaFailure) {
          ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(state.failure?.response?.data.toString() ?? 'Error inesperado'),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );

          context.read<RemoteCategoriaBloc>().add(FetchCategoriasByIdInspeccionTipo(widget.inspeccionTipo!));
        }

        if (state is RemoteCategoriaFailedMessage) {
          ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(state.errorMessage.toString()),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );

          context.read<RemoteCategoriaBloc>().add(FetchCategoriasByIdInspeccionTipo(widget.inspeccionTipo!));
        }

        if (state is RemoteCategoriaResponseSuccess) {
          ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text('¡La categoria ha sido creada exitosamente!', style: $styles.textStyles.bodySmall),
              backgroundColor: Colors.green,
            ),
          );

          context.read<RemoteCategoriaBloc>().add(FetchCategoriasByIdInspeccionTipo(widget.inspeccionTipo!));

          Future.delayed($styles.times.fast, () {
            Navigator.pop(context);
          });
        }

      },
      builder: (BuildContext context, RemoteCategoriaState state) {
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // NOMBRE:
              LabeledTextField(
                autoFocus: true,
                controller: _nameController,
                labelText: 'Nombre *',
                validator: FormValidators.textValidator,
                textInputAction: TextInputAction.done,
              ),
              Gap($styles.insets.lg),
              // BOTON:
              BlocBuilder<RemoteCategoriaBloc, RemoteCategoriaState>(
                builder: (BuildContext context, RemoteCategoriaState state) {
                  return state is RemoteCategoriaLoading
                      ? FilledButton(
                          onPressed: null,
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all<Size?>(
                              const Size(double.infinity, 48),
                            ),
                          ),
                          child: LoadingIndicator(
                            color: Theme.of(context).disabledColor,
                            width: 20,
                            height: 20,
                            strokeWidth: 2,
                          ),
                        )
                      : FilledButton(
                          onPressed: _handleSubmitCategoria,
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
      },
    );
  }
}
