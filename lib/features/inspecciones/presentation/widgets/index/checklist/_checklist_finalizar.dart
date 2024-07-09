part of '../../../pages/index/index_page.dart';

class _ChecklistInspeccionFinalizar extends StatefulWidget {
  const _ChecklistInspeccionFinalizar({
    required this.objInspeccion,
    required this.objData,
    Key? key,
    this.onComplete,
  }) : super(key: key);

  final InspeccionEntity objInspeccion;
  final InspeccionIdParamEntity objData;
  final VoidCallback? onComplete;

  @override
  State<_ChecklistInspeccionFinalizar> createState() => _ChecklistInspeccionFinalizarState();
}

class _ChecklistInspeccionFinalizarState extends State<_ChecklistInspeccionFinalizar> {
  // CONTROLLERS
  late TextEditingController _fechaInspeccionFinalController;
  late TextEditingController _observacionesController;

  // PROPERTIES
  String? _firmaOperador;
  String? _firmaVerificador;

  // STATE
  @override
  void initState() {
    super.initState();
    _fechaInspeccionFinalController = TextEditingController();
    _observacionesController        = TextEditingController();
    _loadFirmas();
  }

  @override
  void dispose() {
    _fechaInspeccionFinalController.dispose();
    _observacionesController.dispose();
    super.dispose();
  }

  // EVENTS
  Future<void> _handleFirmarPressed(BuildContext context, String role) async {
    await Navigator.push<void>(
      context,
      AppModalRoute(
        child: _ChecklistInspeccionFirma(
          objData: widget.objData,
          role: role,
        ),
      ),
    );

    await _loadFirmas();
  }

  void _handleDeleteFirma(BuildContext context, String role) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title   : Text('Confirmar eliminación', style: $styles.textStyles.h3.copyWith(fontSize: 18)),
          content : Text(
            'Se eliminará la firma actual. ¿Estás seguro de querer realizar esa acción?',
            style: $styles.textStyles.body.copyWith(height: 1.3),
          ),
          actions : [
            TextButton(onPressed: () => Navigator.pop(context, AppStrings.btnCancelText), child: Text(AppStrings.btnCancelText, style: $styles.textStyles.button)),
            TextButton(
              onPressed: () async {
                Navigator.pop(context, AppStrings.btnAcceptText);   // Cerrar el dialógo
                await _delete(role);

                await _loadFirmas();
              },
              child: Text(AppStrings.btnAcceptText, style: $styles.textStyles.button),
            ),
          ],
        );
      },
    );
  }

  void _handleFinishPressed(BuildContext context) {
    if (widget.objInspeccion.evaluado == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                AppStrings.errorAlertInvalidFormTitle,
                style: $styles.textStyles.bodyBold.copyWith(color: $styles.colors.white),
              ),
              Text(
                'No se puede finalizar la inspección debido a que no se ha concluido la evaluación de la unidad',
                style     : $styles.textStyles.bodySmall.copyWith(color: $styles.colors.white, height: 1.3),
                softWrap  : true,
              ),
            ],
          ),
          backgroundColor : $styles.colors.warning,
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
              Text(
                AppStrings.errorAlertInvalidFormTitle,
                style: $styles.textStyles.bodyBold.copyWith(color: $styles.colors.white),
              ),
              Text(
                'Ingresa la fecha de inspección final',
                style     : $styles.textStyles.bodySmall.copyWith(color: $styles.colors.white, height: 1.3),
                softWrap  : true,
              ),
            ],
          ),
          backgroundColor : $styles.colors.warning,
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
            style: $styles.textStyles.body.copyWith(height: 1.3),
          ),
          actions : [
            TextButton(onPressed: () => Navigator.pop(context, AppStrings.btnCancelText), child: Text(AppStrings.btnCancelText, style: $styles.textStyles.button)),
            TextButton(
              onPressed: () {
                Navigator.pop(context, AppStrings.btnAcceptText);   // Cerrar el dialógo
                _store();                                           // Finalizar inspección
              },
              child: Text(AppStrings.btnAcceptText, style: $styles.textStyles.button),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showServerErrorDialog(BuildContext context, String? message) async {
    return showDialog<void>(context: context, builder: (BuildContext context) => ServerFailedDialog(message: message ?? AppStrings.errorGenericMessage));
  }

  // METHODS
  Future<void> _store() async {
    final File objOperadorFile    = await _getFirmaFile('operador');
    final File objVerificadorFile = await _getFirmaFile('verificador');

    if (!objOperadorFile.existsSync() || !objVerificadorFile.existsSync()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                AppStrings.errorAlertWarningTitle,
                style: $styles.textStyles.bodyBold.copyWith(color: $styles.colors.white),
              ),
              Text(
                'Por favor, asegúrese de cargar ambas firmas antes de finalizar.',
                style     : $styles.textStyles.bodySmall.copyWith(color: $styles.colors.white, height: 1.3),
                softWrap  : true,
              ),
            ],
          ),
          backgroundColor : $styles.colors.warning,
          elevation       : 0,
          behavior        : SnackBarBehavior.fixed,
          showCloseIcon   : true,
        ),
      );
      return;
    }

    final String operadorFileBase64       = await Globals.fileToBase64(objOperadorFile);
    final String verificadorFileBase64    = await Globals.fileToBase64(objVerificadorFile);

    final String operadorFileExtension    = Globals.extensionFile(objOperadorFile.path);
    final String verificadorFileExtension = Globals.extensionFile(objVerificadorFile.path);

    final InspeccionFinishReqEntity objPost = InspeccionFinishReqEntity(
      idInspeccion              : widget.objInspeccion.idInspeccion,
      fechaInspeccionFinal      : DateFormat('dd/MM/yyyy HH:mm').parse(_fechaInspeccionFinalController.text),
      firmaVerificador          : verificadorFileBase64,
      firmaOperador             : operadorFileBase64,
      fileExtensionVerificador  : verificadorFileExtension,
      fileExtensionOperador     : operadorFileExtension,
      observaciones             : _observacionesController.text,
    );

    context.read<RemoteInspeccionBloc>().add(FinishInspeccion(objPost));
  }

  Future<File> _getFirmaFile(String role) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/${widget.objData.idInspeccion}_$role.png';
    return File(filePath);
  }

  Future<void> _loadFirmas() async {
    final directory = await getApplicationDocumentsDirectory();
    final operadorPath      = '${directory.path}/${widget.objData.idInspeccion}_operador.png';
    final verificadorPath   = '${directory.path}/${widget.objData.idInspeccion}_verificador.png';

    setState(() {
      _firmaOperador    = File(operadorPath).existsSync() ? operadorPath : null;
      _firmaVerificador = File(verificadorPath).existsSync() ? verificadorPath : null;
    });
  }

  Future<void> _delete(String role) async {
    final directory   = await getApplicationDocumentsDirectory();
    final filePath    = '${directory.path}/${widget.objData.idInspeccion}_$role.png';
    final objFile     = File(filePath);

    if (objFile.existsSync()) {
      await objFile.delete();

      setState(() {
        if (role == 'operador') {
          _firmaOperador = null;
        } else if (role == 'verificador') {
          _firmaVerificador = null;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.inspeccionChecklistFinishAppBarTitle, style: $styles.textStyles.h3)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all($styles.insets.sm).copyWith(bottom: $styles.insets.offset),
          child: Column(
            children: <Widget>[
              // CAMPO: FECHA INSPECCION FINAL
              LabeledDateTimeFormField(
                controller  : _fechaInspeccionFinalController,
                hintText    : 'dd/mm/aaaa hh:mm',
                label       : '* Fecha de inspección final:',
              ),

              Gap($styles.insets.sm),

              // CAMPO: OBSERVACIONES
              LabeledTextareaFormField(
                controller    : _observacionesController,
                hintText      : 'Ingrese las observaciones presentadas durante la inspección...',
                label         : 'Observaciones (opcional):',
                maxCharacters : 300,
              ),

              Gap($styles.insets.sm),

              // SECCION DE FIRMAS
              _buildFirmaFieldArea(
                context,
                _firmaOperador,
                '* Firma del operador:',
                () => _handleFirmarPressed(context, 'operador'),
                () => _handleDeleteFirma(context, 'operador'),
              ),

              Gap($styles.insets.sm),

              _buildFirmaFieldArea(
                context,
                _firmaVerificador,
                '* Firma del verificador:',
                () => _handleFirmarPressed(context, 'verificador'),
                () => _handleDeleteFirma(context, 'verificador'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomAppBar(context),
    );
  }

  Widget _buildFirmaFieldArea(BuildContext context, String? firmaPath, String label, VoidCallback onFirmarPressed, VoidCallback onDeletePressed) {
    final Key key = UniqueKey(); // Genera una Key única para este widget

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        // LABEL
        Text(label, style: $styles.textStyles.label),
        Gap($styles.insets.sm),
        Container(
            color   : Theme.of(context).colorScheme.background,
            padding : EdgeInsets.all($styles.insets.sm),
            child: firmaPath == null
                ? Center(
                    child: FilledButton.icon(
                      onPressed : onFirmarPressed,
                      icon      : const Icon(Icons.add),
                      label     : Text(AppStrings.btnFirmText, style: $styles.textStyles.button),
                    ),
                  )
                : Stack(
                    children: <Widget>[
                      Image.file(File(firmaPath), key: key),
                      Positioned(
                        top   : 10,
                        left  : 10,
                        child: CircleIconButton(
                          backgroundColor : $styles.colors.caption,
                          color           : $styles.colors.white,
                          icon            : AppIcons.close,
                          iconSize        : $styles.insets.lg,
                          size            : $styles.insets.md,
                          onPressed       : () {
                            onDeletePressed();
                            setState(() { });
                          },
                          semanticLabel   : AppStrings.btnDeleteText,
                        ),
                      ),
                    ],
                  ),
          ),
      ],
    );
  }

  Widget _buildBottomAppBar(BuildContext context) {
    return BottomAppBar(
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CircleIconButton(
            icon          : AppIcons.next_large,
            onPressed     : () =>  Navigator.of(context).pop(),
            semanticLabel : AppStrings.btnPreviousText,
            flipIcon      : true,
          ),
          BlocConsumer<RemoteInspeccionBloc, RemoteInspeccionState>(
            listener: (BuildContext context, RemoteInspeccionState state) {
              // ERROR
              if (state is RemoteInspeccionServerFailedMessageFinish) {
                _showServerErrorDialog(context, state.error);
              }

              if (state is RemoteInspeccionServerExceptionMessageFinish) {
                _showServerErrorDialog(context, state.error?.message);
              }

              // SUCCESS
              if (state is RemoteInspeccionFinish) {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.of(context).pop();

                ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(
                      state.objResponse?.message ?? 'Finalizado',
                      style     : $styles.textStyles.bodySmall.copyWith(color: $styles.colors.white, height: 1.3),
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
            builder: (BuildContext context, RemoteInspeccionState state) {
              // LOADING
              if (state is RemoteInspeccionFinishLoading) {
                return const FilledButton(
                  onPressed : null,
                  child     : AppLoadingIndicator(width: 20, height: 20),
                );
              }
              return FilledButton(
                onPressed : () => _handleFinishPressed(context),
                child     : Text(AppStrings.btnFinishText, style: $styles.textStyles.button),
              );
            },
          ),
        ],
      ),
    );
  }
}
