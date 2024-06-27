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

  // PROPERTIES
  late bool _hasOperadorFirma;
  late bool _hasVerificadorFirma;

  // STATE
  @override
  void initState() {
    super.initState();
    _fechaInspeccionFinalController = TextEditingController();
    _observacionesController        = TextEditingController();

    _hasOperadorFirma = false;
    _hasVerificadorFirma = false;

    _checkSignatureExist();
  }

  @override
  void dispose() {
    _fechaInspeccionFinalController.dispose();
    _observacionesController.dispose();
    super.dispose();
  }

  // EVENTS
  void _handleCreatePressed(BuildContext context, String role) {
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
            child     : _ChecklistFirmaModal(
              onFirmaSaved: (File firmaFile) {
                _saveSignature(role, firmaFile);
              },
              role: role,
            ),
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

  void _saveSignature(String type, File firmaFile) {
    setState(() {
      if (type == 'operador') {
        _hasOperadorFirma = true;
      } else if (type == 'verificador') {
        _hasVerificadorFirma = true;
      }
    });
  }

  Future<void> _handleClearFirma(String role) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/firma_$role.png');
    // ignore: avoid_slow_async_io
    if (await file.exists()) {
      await file.delete();
      setState(() {
        if (role == 'operador') {
          _hasOperadorFirma = false;
        } else if (role == 'verificador') {
          _hasVerificadorFirma = false;
        }
      });
    }
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
    final File verificadorFile  = await _getFirmaFile('verificador');
    final File operadorFile     = await _getFirmaFile('operador');

    final String verificadorFileBase64    = await Globals.fileToBase64(verificadorFile);
    final String verificadorFileExtension = Globals.extensionFile(verificadorFile.path);

    final String operadorFileBase64       = await Globals.fileToBase64(operadorFile);
    final String operadorFileExtension    = Globals.extensionFile(operadorFile.path);

    final InspeccionFinishReqEntity objPost = InspeccionFinishReqEntity(
      idInspeccion              : widget.objInspeccion.idInspeccion,
      fechaInspeccionFinal      : DateFormat('dd/MM/yyyy HH:mm').parse(_fechaInspeccionFinalController.text),
      firmaVerificador          : verificadorFileBase64,
      firmaOperador             : operadorFileBase64,
      fileExtensionVerificador  : verificadorFileExtension,
      fileExtensionOperador     : operadorFileExtension,
      observaciones             : _observacionesController.text,
    );

    BlocProvider.of<RemoteInspeccionBloc>(context).add(FinishInspeccion(objPost));
  }

  Future<void> _checkSignatureExist() async {
    final dir = await getApplicationDocumentsDirectory();
    final operadorFile = File('${dir.path}/firma_operador.png');
    final verificadorFile = File('${dir.path}/firma_verificador.png');

    setState(() {
      _hasOperadorFirma = operadorFile.existsSync();
      _hasVerificadorFirma = verificadorFile.existsSync();
    });
  }

  Future<File> _getFirmaFile(String role) async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/firma_$role.png');
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
              _buildFirmaFieldArea(context, 'operador', '* Firma del operador:'),
              Gap($styles.insets.sm),
              _buildFirmaFieldArea(context, 'verificador', '* Firma del verificador:'),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomAppBar(),
    );
  }

  Widget _buildFirmaFieldArea(BuildContext context, String role, String label) {
    final bool hasFirma = role == 'operador' ? _hasOperadorFirma : _hasVerificadorFirma;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label, style: $styles.textStyles.label),
        Gap($styles.insets.sm),
        Container(
          padding : EdgeInsets.all($styles.insets.sm),
          color   : Theme.of(context).colorScheme.background,
          child   : Center(
            child: hasFirma
                ? GestureDetector(
                    onTap: () => _handleClearFirma(role),
                    child: FutureBuilder<File>(
                      future: _getFirmaFile(role),
                      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                          return Image.file(snapshot.data!);
                        } else {
                          return const AppLoadingIndicator();
                        }
                      },
                    ),
                  )
                : FilledButton(
                    onPressed: () => _handleCreatePressed(context, role),
                    child: Text($strings.checklistFinishSignatureButtonText, style: $styles.textStyles.button),
                  ),
          ),
        ),
      ],
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
