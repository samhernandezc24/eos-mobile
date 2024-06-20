part of '../../../pages/list/list_page.dart';

class _ChecklistInspeccionFinal extends StatefulWidget {
  const _ChecklistInspeccionFinal({required this.objInspeccion, Key? key, this.buildDataSourceCallback}) : super(key: key);

  final InspeccionDataSourceEntity objInspeccion;
  final VoidCallback? buildDataSourceCallback;

  @override
  State<_ChecklistInspeccionFinal> createState() => _ChecklistInspeccionFinalState();
}

class _ChecklistInspeccionFinalState extends State<_ChecklistInspeccionFinal> {
  // CONTROLLERS
  late final TextEditingController _fechaInspeccionFinalController;
  late final TextEditingController _observacionesController;
  late final TextEditingController _nombreOperadorController;
  late final TextEditingController _nombreVerificadorController;

  // STATE
  @override
  void initState() {
    super.initState();
    _fechaInspeccionFinalController = TextEditingController();
    _observacionesController        = TextEditingController();
    _nombreOperadorController       = TextEditingController();
    _nombreVerificadorController    = TextEditingController();
  }

  @override
  void dispose() {
    _fechaInspeccionFinalController.dispose();
    _observacionesController.dispose();
    _nombreOperadorController.dispose();
    _nombreVerificadorController.dispose();
    super.dispose();
  }

  // EVENTS
  void _handleDrawSignaturePressed(BuildContext context) {
    Navigator.push<void>(
      context,
      PageRouteBuilder<void>(
        transitionDuration: $styles.times.pageTransition,
        pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
          const Offset begin    = Offset(0, 1);
          const Offset end      = Offset.zero;
          const Cubic curve     = Curves.ease;

          final Animatable<Offset> tween = Tween<Offset>(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position  : animation.drive<Offset>(tween),
            child     : const _ChecklistInspeccionSignature(),
          );
        },
        fullscreenDialog: true,
      ),
    );
  }

  void _handleFinishPressed() {
    if (widget.objInspeccion.evaluado == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text($strings.settingsAttentionText, style: $styles.textStyles.bodyBold),
              const Text('No se puede finalizar la inspección debido a que no se ha concluido la evaluación de la unidad', softWrap: true),
            ],
          ),
          backgroundColor : const Color(0xfff89406),
          elevation       : 0,
          behavior        : SnackBarBehavior.fixed,
          showCloseIcon   : true,
        ),
      );
      return;
    }

    if (_fechaInspeccionFinalController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text($strings.alertWarningInvalidFormTitle, style: $styles.textStyles.bodyBold),
              const Text('Ingresa la fecha de inspección final', softWrap: true),
            ],
          ),
          backgroundColor : const Color(0xfff89406),
          elevation       : 0,
          behavior        : SnackBarBehavior.fixed,
          showCloseIcon   : true,
        ),
      );
      return;
    }

    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title   : Text('Confirmar finalización', style: $styles.textStyles.h3.copyWith(fontSize: 18)),
          content : Text(
            'Soy testigo de la inspección realizada al equipo que tengo a mi cargo y se me informo específicamente de cada punto a considerar para su atención correctiva.',
            style: $styles.textStyles.body.copyWith(height: 1.4),
          ),
          actions : [
            TextButton(onPressed: () => Navigator.pop(context, $strings.cancelButtonText), child: Text($strings.cancelButtonText, style: $styles.textStyles.button)),
            TextButton(
              onPressed: () {
                Navigator.pop(context, $strings.acceptButtonText);  // Cerrar el dialógo
                _store();                                           // Finalizar inspección
              },
              child: Text($strings.acceptButtonText, style: $styles.textStyles.button),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showServerFailedDialog(BuildContext context, String? errorMessage) async {
    return showDialog<void>(
      context : context,
      builder: (BuildContext context)  => ServerFailedDialog(
        errorMessage: errorMessage ?? 'Se produjo un error inesperado. Intenta de nuevo finalizar la inspección.',
      ),
    );
  }

  // METHODS
  Future<void> _store() async {
    final InspeccionFinishReqEntity objPost = InspeccionFinishReqEntity(
      idInspeccion              : widget.objInspeccion.idInspeccion,
      fechaInspeccionFinal      : DateFormat('dd/MM/yyyy HH:mm').parse(_fechaInspeccionFinalController.text),
      firmaVerificador          : '',
      firmaOperador             : '',
      fileExtensionVerificador  : 'png',
      fileExtensionOperador     : 'png',
      observaciones             : _observacionesController.text,
    );

    BlocProvider.of<RemoteInspeccionBloc>(context).add(FinishInspeccion(objPost));
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text($strings.checklistFinishAppBarTitle, style: $styles.textStyles.h3)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all($styles.insets.sm).copyWith(bottom: $styles.insets.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // FECHA INSPECCION FINAL:
              LabeledDateTimeTextFormField(
                controller  : _fechaInspeccionFinalController,
                hintText    : 'dd/mm/aaaa hh:mm',
                label       : '* Fecha de inspección final:',
              ),

              Gap($styles.insets.sm),

              // OBSERVACIONES:
              LabeledTextareaFormField(
                controller    : _observacionesController,
                hintText      : 'Ingresa la observación presentada durante la inspección...',
                labelText     : 'Observaciones (opcional):',
                maxCharacters : 300,
              ),

              Gap($styles.insets.sm),

              // FIRMAS:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Firma del operador *:', style: $styles.textStyles.label),
                  Gap($styles.insets.sm),
                  Container(
                    padding : EdgeInsets.all($styles.insets.sm),
                    color   : Theme.of(context).colorScheme.background,
                    child   : Center(
                      child: FilledButton(
                        onPressed : () => _handleDrawSignaturePressed(context),
                        child     : Text($strings.checklistFinishSignatureButtonText, style: $styles.textStyles.button),
                      ),
                    ),
                  ),
                ],
              ),

              Gap($styles.insets.sm),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Firma del verificador *:', style: $styles.textStyles.label),
                  Gap($styles.insets.sm),
                  Container(
                    padding : EdgeInsets.all($styles.insets.sm),
                    color   : Theme.of(context).colorScheme.background,
                    child   : Center(
                      child: FilledButton(
                        onPressed : () => _handleDrawSignaturePressed(context),
                        child     : Text($strings.checklistFinishSignatureButtonText, style: $styles.textStyles.button),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomAppBar(),
    );
  }

  Widget _buildBottomAppBar() {
    return BottomAppBar(
      height  : 70,
      child   : Row(
        children  : <Widget>[
          CircleIconButton(
            icon          : AppIcons.next_large,
            onPressed     : () => Navigator.pop(context),
            semanticLabel : $strings.prevButtonText,
            flipIcon      : true,
          ),
          const Spacer(),
          BlocConsumer<RemoteInspeccionBloc, RemoteInspeccionState>(
            listener: (BuildContext context, RemoteInspeccionState state) {
              // ERROR:
              if (state is RemoteInspeccionServerFailedMessageFinish) {
                _showServerFailedDialog(context, state.errorMessage);
              }

              if (state is RemoteInspeccionServerFailureFinish) {
                _showServerFailedDialog(context, state.failure?.errorMessage);
              }

              // SUCCESS:
              if (state is RemoteInspeccionFinishSuccess) {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.of(context).pop();

                ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content         : Text(state.objResponse?.message ?? 'Inspección finalizada', softWrap: true),
                    backgroundColor : Colors.green,
                    elevation       : 0,
                    behavior        : SnackBarBehavior.fixed,
                  ),
                );

                // Ejecutar callback.
                widget.buildDataSourceCallback!();
              }
            },
            builder: (BuildContext context, RemoteInspeccionState state) {
              if (state is RemoteInspeccionFinishLoading) {
                return const FilledButton(
                  onPressed : null,
                  child     : AppLoadingIndicator(width: 20, height: 20),
                );
              }

              return FilledButton(
                onPressed : _handleFinishPressed,
                child     : Text($strings.finishButtonText, style: $styles.textStyles.button),
              );
            },
          ),
        ],
      ),
    );
  }
}
