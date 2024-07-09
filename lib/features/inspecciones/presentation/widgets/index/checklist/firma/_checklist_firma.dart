part of '../../../../pages/index/index_page.dart';

class _ChecklistInspeccionFirma extends StatefulWidget {
  const _ChecklistInspeccionFirma({
    required this.objData,
    required this.role,
    Key? key,
  }) : super(key: key);

  final InspeccionIdParamEntity objData;
  final String role;

  @override
  State<_ChecklistInspeccionFirma> createState() => __ChecklistInspeccionFirmaState();
}

class __ChecklistInspeccionFirmaState extends State<_ChecklistInspeccionFirma> {
  // GLOBAL KEY
  final GlobalKey<SfSignaturePadState> _signaturePadKey = GlobalKey<SfSignaturePadState>();

  // PROPERTIES
  bool _isFirmaEmpty = true;

  // EVENTS
  void _handleStorePressed() {
    _store();
  }

  void _handleClearPressed() {
    _signaturePadKey.currentState!.clear();
    setState(() {
      _isFirmaEmpty = true;
    });
  }

  // METHODS
  Future<void> _store() async {
    try {
      final image       = await _signaturePadKey.currentState!.toImage(pixelRatio: 3);
      final objByteData = await image.toByteData(format: ImageByteFormat.png);
      final arrBytes    = objByteData?.buffer.asUint8List();

      if (arrBytes != null) {
        final directory   = await getApplicationDocumentsDirectory();
        // final pattern = '${widget.objData.idInspeccion}_'; // Patrón de búsqueda para identificar archivos de firmas
        // final files = await directory.list().where((entity) {
        //   return entity is File && entity.path.contains(pattern);
        // }).toList();

        // // Contar la cantidad de archivos encontrados
        // final numFiles = files.length;
        // print('Cantidad de archivos de firmas almacenados: $numFiles');
        final path        = '${directory.path}/${widget.objData.idInspeccion}_${widget.role}.png';
        final objFile     = File(path);

        // Verificamos si el archivo ya existe y lo eliminamos de la caché.
        if (objFile.existsSync()) {
          await objFile.delete();
        }

        await objFile.writeAsBytes(arrBytes);

        // Cerrar modal
        Navigator.of(context).pop();
      }
    } catch (e) {
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
                'No se pudo guardar la firma: $e',
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.inspeccionChecklistDrawSignatureAppBarTitle, style: $styles.textStyles.h3)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // SUGERENCIA
          Container(
            color   : Theme.of(context).colorScheme.background,
            width   : double.infinity,
            padding : EdgeInsets.all($styles.insets.sm),
            child   : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    style     : $styles.textStyles.label.copyWith(color: Theme.of(context).colorScheme.onBackground, height: 1.3),
                    children  : const <TextSpan>[
                      TextSpan(text: AppStrings.suggestionBoxTitle, style: TextStyle(fontWeight: FontWeight.w600)),
                      TextSpan(text: ': ${AppStrings.inspeccionChecklistDrawSignatureBoxSuggest}'),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Gap($styles.insets.sm),

          // FIRMAR
          Padding(
            padding: EdgeInsets.all($styles.insets.sm),
            child: SizedBox(
              width: context.widthPx,
              height: 300,
              child: DottedBorder(
                color: Theme.of(context).primaryColor,
                strokeWidth: 3,
                dashPattern: const [5, 4],
                borderType: BorderType.RRect,
                child: SfSignaturePad(
                  key                 : _signaturePadKey,
                  minimumStrokeWidth  : 1,
                  maximumStrokeWidth  : 3,
                  backgroundColor     : $styles.colors.white,
                  strokeColor         : Colors.blue,
                  onDraw: (_, __) {
                    setState(() {
                      _isFirmaEmpty = false;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomAppBar(context),
    );
  }

  Widget _buildBottomAppBar(BuildContext context) {
    return BottomAppBar(
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FilledButton(
            onPressed : _handleClearPressed,
            style     : ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFF4FAFF)),
              foregroundColor: MaterialStateProperty.all<Color>(const Color(0xFF233876)),
            ),
            child     : Text(AppStrings.btnClearText, style: $styles.textStyles.button),
          ),
          FilledButton(
            onPressed : _isFirmaEmpty ? null : _handleStorePressed,
            child     : Text(AppStrings.btnSaveText, style: $styles.textStyles.button),
          ),
        ],
      ),
    );
  }
}
