import 'package:eos_mobile/core/common/widgets/controls/loading_indicator.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/inspecciones_tipos/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/inspecciones_tipos/inspeccion_tipo_req_entity.dart';
import 'package:eos_mobile/features/configuraciones/presentation/bloc/inspeccion_tipo/remote/remote_inspeccion_tipo_bloc.dart';
import 'package:eos_mobile/shared/shared.dart';

class UpdateInspeccionTipoForm extends StatefulWidget {
  const UpdateInspeccionTipoForm({Key? key, this.inspeccionTipo}) : super(key: key);

  final InspeccionTipoEntity? inspeccionTipo;

  @override
  State<UpdateInspeccionTipoForm> createState() => _UpdateInspeccionTipoFormState();
}

class _UpdateInspeccionTipoFormState extends State<UpdateInspeccionTipoForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _folioController;
  late final TextEditingController _nameController;
  late final TextEditingController _correoController;

  final int currentYear = DateTime.now().year;

  @override
  void initState() {
    _folioController  = TextEditingController(text: widget.inspeccionTipo?.folio ?? '');
    _nameController   = TextEditingController(text: widget.inspeccionTipo?.name.toProperCase() ?? '');
    _correoController = TextEditingController(text: widget.inspeccionTipo?.correo ?? '');
    super.initState();
  }

  @override
  void dispose() {
    _folioController.dispose();
    _nameController.dispose();
    _correoController.dispose();
    super.dispose();
  }

  void _handleSubmitInspeccionTipo() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Formulario incompleto'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    } else {
      final objInspeccionData = InspeccionTipoReqEntity(
        idInspeccionTipo  : widget.inspeccionTipo!.idInspeccionTipo,
        folio             : _folioController.text,
        name              : _nameController.text,
        correo            : _correoController.text,
      );
      // EVENTO DE GUARDADO
      context.read<RemoteInspeccionTipoBloc>().add(UpdateInspeccionTipo(objInspeccionData));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RemoteInspeccionTipoBloc, RemoteInspeccionTipoState>(
      listener: (BuildContext context, state) {
        if (state is RemoteInspeccionTipoFailure) {
          ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(state.failure?.response?.data.toString() ?? 'Error inesperado'),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );

          context.read<RemoteInspeccionTipoBloc>().add(FetcInspeccionesTipos());
        }

        if (state is RemoteInspeccionTipoFailedMessage) {
          ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(state.errorMessage.toString()),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );

          context.read<RemoteInspeccionTipoBloc>().add(FetcInspeccionesTipos());
        }

        if (state is RemoteInspeccionResponseSuccess) {
          ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text('¡El tipo de inspección ha sido actualizado exitosamente!', style: $styles.textStyles.bodySmall),
              backgroundColor: Colors.green,
            ),
          );

          context.read<RemoteInspeccionTipoBloc>().add(FetcInspeccionesTipos());
        }

      },
      builder: (BuildContext context, RemoteInspeccionTipoState state) {
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // FOLIO:
              LabeledTextField(
                controller: _folioController,
                autoFocus: true,
                labelText: 'Folio *',
                hintText: 'INST-$currentYear-xxxx',
                validator: FormValidators.textValidator,
              ),
              Gap($styles.insets.sm),
              // NOMBRE:
              LabeledTextField(
                controller: _nameController,
                labelText: 'Nombre *',
                validator: FormValidators.textValidator,
              ),
              Gap($styles.insets.sm),
              // CORREO:
              LabeledTextField(
                controller: _correoController,
                labelText: 'Correo (opcional)',
                hintText: 'ejem@plo.com',
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
              ),
              Gap($styles.insets.lg),
              // BOTON:
              BlocBuilder<RemoteInspeccionTipoBloc, RemoteInspeccionTipoState>(
                builder: (BuildContext context, RemoteInspeccionTipoState state) {
                  return state is RemoteInspeccionTipoLoading
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
                          onPressed: _handleSubmitInspeccionTipo,
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
