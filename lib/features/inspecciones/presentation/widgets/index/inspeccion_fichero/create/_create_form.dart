part of '../../../../pages/index/index_page.dart';

class _CreateInspeccionFicheroForm extends StatefulWidget {
  const _CreateInspeccionFicheroForm({
    required this.objInspeccion,
    Key? key,
    this.onComplete,
  }) : super(key: key);

  final InspeccionEntity objInspeccion;
  final VoidCallback? onComplete;

  @override
  State<_CreateInspeccionFicheroForm> createState() => _CreateInspeccionFicheroFormState();
}

class _CreateInspeccionFicheroFormState extends State<_CreateInspeccionFicheroForm> {
  // REGISTROS ITEMS
  List<File> lstQueueUpload   = [];
  int indexUpload             = 0;
  int countQueueUpload        = 0;
  int countQueueTotal         = 0;

  // LIST
  final List<File> _files = [];

  // PROPERTIES
  bool _isUploading   = false;
  // bool _isSave        = false;

  // EVENTS
  void _handleDidPopPressed(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppStrings.exitConfirmationDialogTitle, style: $styles.textStyles.title1.copyWith(fontWeight: FontWeight.w600)),
          content: Text(AppStrings.exitConfirmationDialogMessage, style: $styles.textStyles.body.copyWith(height: 1.3)),
          actions: <Widget>[
            TextButton(
              onPressed : () => Navigator.pop(context, AppStrings.btnCancelText),
              child     : Text(AppStrings.btnCancelText, style: $styles.textStyles.button),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();    // Cerrar dialog
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.of(context).pop();  // Cerrar ventana
                  widget.onComplete!();         // Ejecutar callback de actualización
                });
              },
              child: Text(AppStrings.btnAcceptText, style: $styles.textStyles.button),
            ),
          ],
        );
      },
    );
  }

  Future<void> _handleTakePhotoPressed() async {
    final XFile? photo = await imageHelper.takePhoto();
    if (photo != null) {
      setState(() {
        _files.add(File(photo.path));
      });
    }
  }

  Future<void> _handlePickPhotosPressed() async {
    final List<XFile> photos = await imageHelper.pickPhotos(multiple: true);
     setState(() {
      _files.addAll(photos.map((photo) => File(photo.path)));
    });
  }

  void _handleImagePressed(List<File> files, int index) {
    Navigator.push<void>(context, MaterialPageRoute<void>(builder: (_) => FullScreenImagePreview(imageFiles: files, initialIndex: index)));
  }

  void _handleDeletePressed(int index) {
    setState(() {
      _files.removeAt(index);
    });
  }

  void _handleStorePressed() {
    if (_files.isEmpty) {
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
                'No se ha cargado ninguna foto',
                style     : $styles.textStyles.bodySmall.copyWith(color: $styles.colors.white),
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

    _loading();
    _store(boolBegin: true);
  }

  Future<void> _showServerErrorDialog(BuildContext context, String? message) async {
    return showDialog<void>(context: context, builder: (BuildContext context) => ServerFailedDialog(message: message ?? AppStrings.errorGenericMessage));
  }

  // METHODS
  void _loading({bool value = true}) {
    setState(() {
      // _isSave       = value;
      _isUploading  = value;
    });
  }

  Future<void> _store({bool boolBegin = false}) async {
    if (boolBegin) {
      indexUpload = 0;
      final List<File> arrUploads = List<File>.from(_files);

      lstQueueUpload = [];

      for (int index = 0; index < arrUploads.length; index++) {
        final objUpload = arrUploads[index];
        lstQueueUpload.add(objUpload);

        countQueueTotal++;
      }
    }

    if (countQueueUpload < countQueueTotal) {
      final File objUpload = lstQueueUpload[indexUpload];
      final String fileBase64 = await Globals.fileToBase64(objUpload);
      final String fileExtension = Globals.extensionFile(objUpload.path);

      final InspeccionFicheroStoreReqEntity objPost = InspeccionFicheroStoreReqEntity(
        fileBase64        : fileBase64,
        fileExtension     : fileExtension,
        idInspeccion      : widget.objInspeccion.idInspeccion,
        inspeccionFolio   : widget.objInspeccion.folio,
      );

      // Agregar un delay antes de disparar el evento del bloc
      await Future<void>.delayed(const Duration(seconds: 1));

      context.read<RemoteInspeccionFicheroBloc>().add(StoreInspeccionFichero(objPost));

      setState(() {
        lstQueueUpload.removeAt(indexUpload);
        _files.removeAt(indexUpload);
        countQueueUpload++;
      });

      await _store();
    } else {
      if (lstQueueUpload.isEmpty) {
        // Navigator.of(context).pop();  // Cerrar ventana

        ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              'Fotos guardadas exitosamente',
              style     : $styles.textStyles.bodySmall.copyWith(color: $styles.colors.white),
              softWrap  : true,
            ),
            backgroundColor : $styles.colors.success,
            elevation       : 0,
            behavior        : SnackBarBehavior.fixed,
          ),
        );

        // WidgetsBinding.instance.addPostFrameCallback((_) {
        //   widget.onComplete!();         // Ejecutar callback de actualización
        // });
      } else {
        ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              'Algunas fotos no pudieron ser guardadas',
              style     : $styles.textStyles.bodySmall.copyWith(color: $styles.colors.white),
              softWrap  : true,
            ),
            backgroundColor : $styles.colors.warning,
            elevation       : 0,
            behavior        : SnackBarBehavior.fixed,
          ),
        );
        _loading(value: false);
      }
      setState(() {
        _isUploading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    final Widget content = GestureDetector(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all($styles.insets.xs * 1.5),
            child: _buildStatusText(context),
          ),

          // FICHEROS
          Expanded(
            child: RepaintBoundary(
              child: _files.isEmpty
                  ? const EmptyListMessage(
                      title         : AppStrings.inspeccionPhotoEmptyListTitle,
                      message       : AppStrings.inspeccionPhotoAddEmptyListMessage,
                      isRefreshData : false,
                    )
                  : _ItemInspeccionFicheroGrid(
                      files           : _files,
                      onImagePressed  : _handleImagePressed,
                      onDeletePressed : _handleDeletePressed,
                      isUploading     : _isUploading,
                    ),
            ),
          ),
        ],
      ),
    );

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) => !didPop ? _handleDidPopPressed(context) : null,
      child: Scaffold(
        appBar: AppBar(title: Text(AppStrings.inspeccionChecklistPhotoAddAppBarTitle, style: $styles.textStyles.h3)),
        body: Stack(
          children: <Widget>[
            Positioned.fill(child: ColoredBox(color: Theme.of(context).colorScheme.background, child: content)),
          ],
        ),
        bottomNavigationBar: _buildBottomAppBar(context),
      ),
    );
  }

  Widget _buildStatusText(BuildContext context) {
    if (_files.isEmpty) {
      return const SizedBox.shrink();
    }

    final TextStyle statusStyle = $styles.textStyles.bodySmall.copyWith(
      color: Theme.of(context).colorScheme.onBackground,
      height: 1.3,
    );

    final int totalSizeBytes  = _files.fold(0, (sum, file) => sum + Globals.getFileSize(file));
    final String readableSize = Globals.getReadableFileSizeFromBytes(totalSizeBytes);

    return MergeSemantics(
      child: StaticTextScale(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Text(
                'Fotografías: ${_files.length}; Tamaño total: $readableSize;',
                style               : statusStyle,
                textAlign           : TextAlign.center,
                textHeightBehavior  : const TextHeightBehavior(applyHeightToFirstAscent: false),
              ),
            ),
            Gap($styles.insets.sm),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomAppBar(BuildContext context) {
    return BottomAppBar(
      height: 70,
      child: Row(
        children: <Widget>[
          IconButton(
            onPressed : _isUploading ? null : _handleTakePhotoPressed,
            icon      : const Icon(Icons.camera_alt),
            tooltip   : 'Tomar fotografía',
          ),
          IconButton(
            onPressed : _isUploading ? null : _handlePickPhotosPressed,
            icon      : const Icon(Icons.photo_library),
            tooltip   : 'Galería',
          ),
          const Spacer(),
          BlocConsumer<RemoteInspeccionFicheroBloc, RemoteInspeccionFicheroState>(
            listener: (BuildContext context, RemoteInspeccionFicheroState state) {
               if (state is RemoteInspeccionFicheroServerFailedMessageStore) {
                _showServerErrorDialog(context, state.error);
              }

              if (state is RemoteInspeccionFicheroServerExceptionMessageStore) {
                _showServerErrorDialog(context, state.error?.message);
              }
            },
            builder: (BuildContext context, RemoteInspeccionFicheroState state) {
              // if (state is RemoteInspeccionFicheroStoreLoading) {
              //   return const FilledButton(
              //     onPressed : null,
              //     child     : AppLoadingIndicator(width: 20, height: 20),
              //   );
              // }
              return FilledButton(
                onPressed: _isUploading ? null : _handleStorePressed,
                child     : Text(AppStrings.btnSaveText, style: $styles.textStyles.button),
              );
            },
          ),
        ],
      ),
    );
  }
}
