import 'package:eos_mobile/core/common/widgets/controls/loading_indicator.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/inspecciones_tipos/inspeccion_tipo_req_entity.dart';
import 'package:eos_mobile/features/configuraciones/presentation/bloc/inspeccion_tipo/remote/remote_inspeccion_tipo_bloc.dart';
import 'package:eos_mobile/shared/shared.dart';

class CreateInspeccionTipoForm extends StatefulWidget {
  const CreateInspeccionTipoForm({Key? key}) : super(key: key);

  @override
  State<CreateInspeccionTipoForm> createState() => _CreateInspeccionTipoFormState();
}

class _CreateInspeccionTipoFormState extends State<CreateInspeccionTipoForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _folioController  = TextEditingController();
  final TextEditingController _nameController   = TextEditingController();
  final TextEditingController _correoController = TextEditingController();

  final int currentYear = DateTime.now().year;

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
        folio   : _folioController.text,
        name    : _nameController.text,
        correo  : _correoController.text,
      );
      // EVENTO DE GUARDADO
      context.read<RemoteInspeccionTipoBloc>().add(CreateInspeccionTipo(objInspeccionData));
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
              content: Text(state.apiResponse.message),
              backgroundColor: Colors.green,
            ),
          );

          context.read<RemoteInspeccionTipoBloc>().add(FetcInspeccionesTipos());

          Future.delayed($styles.times.fast, () {
            Navigator.pop(context);
          });
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
