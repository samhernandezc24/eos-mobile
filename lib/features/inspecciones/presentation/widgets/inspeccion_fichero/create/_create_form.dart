part of '../../../pages/list/list_page.dart';

class _CreateInspeccionFicheroForm extends StatefulWidget {
  const _CreateInspeccionFicheroForm({
    required this.objInspeccion,
    Key? key,
    this.buildFicheroDataCallback,
  }) : super(key: key);

  final InspeccionDataSourceEntity objInspeccion;
  final VoidCallback? buildFicheroDataCallback;

  @override
  State<_CreateInspeccionFicheroForm> createState() => _CreateInspeccionFicheroFormState();
}

class _CreateInspeccionFicheroFormState extends State<_CreateInspeccionFicheroForm> {
  // REGISTROS ITEMS
  List<File> _lstQueueUpload    = [];
  int _indexUpload               = 0;
  int _countQueueUpload          = 0;
  int _countQueueTotal           = 0;

  // LIST
  final List<File> _files = [];

  // PROPERTIES
  bool _isPhotoUploading  = false;
  bool _isSave            = false;

  // EVENTS
  void _showDidPopDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const SizedBox.shrink(),
        content: Text('¿Estás seguro que deseas salir?', style: $styles.textStyles.bodySmall.copyWith(fontSize: 16)),
        actions: <Widget>[
          TextButton(
            onPressed : () => Navigator.pop(context, $strings.cancelButtonText),
            child     : Text($strings.cancelButtonText, style: $styles.textStyles.button),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();            // Cerrar dialog
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pop();          // Cerrar página
                widget.buildFicheroDataCallback!();   // Ejecutar callback
              });
            },
            child: Text($strings.acceptButtonText, style: $styles.textStyles.button),
          ),
        ],
      ),
    );
  }

  Future<void> _handleTakePhotoPressed() async {
    if (_isPhotoUploading) return;

    setState(() {
      _isPhotoUploading = true;
    });

    try {
      final XFile? photo = await imageHelper.takePhoto();
      if (photo != null) {
        if (mounted) {
          setState(() {
            _files.add(File(photo.path));
          });
        }
      }
    } finally {
      if (mounted) {
        setState(() {
          _isPhotoUploading = false;
        });
      }
    }
  }

  Future<void> _handlePickPhotosPressed() async {
    if (_isPhotoUploading) return;

    if (mounted) {
      setState(() {
        _isPhotoUploading = true;
      });
    }

    try {
      final List<XFile> photos = await imageHelper.pickPhotos(multiple: true);
      if (mounted) {
        setState(() {
          _files.addAll(photos.map((photo) => File(photo.path)));
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isPhotoUploading = false;
        });
      }
    }
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
              Text($strings.alertWarningAttentionTitle, style: $styles.textStyles.bodyBold),
              const Text('No se ha cargado ninguna foto', softWrap: true),
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

    _loading();
    _store(boolBegin: true);
  }

  Future<void> _showServerFailedDialog(BuildContext context, String? errorMessage) async {
    return showDialog<void>(
      context : context,
      builder: (BuildContext context)  => ServerFailedDialog(
        errorMessage: errorMessage ?? 'Se produjo un error inesperado. Intenta de nuevo cargar las fotografías.',
      ),
    );
  }

  // METHODS
  void _loading({bool value = true}) {
    if (value) {
      setState(() {
        _isSave = true;
      });
    } else {
      setState(() {
        _isSave = false;
      });
    }
  }

  Future<void> _store({bool boolBegin = false}) async {
    if (boolBegin) {
      _indexUpload                  = 0;
      final List<File> arrUploads   = List<File>.from(_files);

      _lstQueueUpload = [];

      for (int index = 0; index < arrUploads.length; index++) {
        final objUpload = arrUploads[index];

        _lstQueueUpload.add(objUpload);

        _countQueueTotal++;
      }
    }

    if (_countQueueUpload < _countQueueTotal) {
      final File objUpload        = _lstQueueUpload[_indexUpload];
      final String fileBase64     = await Globals.fileToBase64(objUpload);
      final String fileExtension  = Globals.extensionFile(objUpload.path);

      final InspeccionFicheroStoreReqEntity objPost = InspeccionFicheroStoreReqEntity(
        fileBase64      : fileBase64,
        fileExtension   : fileExtension,
        idInspeccion    : widget.objInspeccion.idInspeccion,
        inspeccionFolio : widget.objInspeccion.folio,
      );

      BlocProvider.of<RemoteInspeccionFicheroBloc>(context).add(StoreInspeccionFichero(objPost));
    } else {
      if (_lstQueueUpload.isEmpty) {
        Navigator.of(context).pop();

        ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content         : Text('Fotos guardadas exitosamente', softWrap: true),
            backgroundColor : Colors.green,
            elevation       : 0,
            behavior        : SnackBarBehavior.fixed,
          ),
        );

        // Ejecutar callback.
        WidgetsBinding.instance.addPostFrameCallback((_) {
          widget.buildFicheroDataCallback!();
        });
      } else {
        ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content         : const Text('Algunas fotos no pudieron ser guardadas', softWrap: true),
            backgroundColor : Theme.of(context).colorScheme.error,
            elevation       : 0,
            behavior        : SnackBarBehavior.fixed,
          ),
        );

        _loading(value: false);
      }
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
          Expanded(
            child: RepaintBoundary(
              child: _files.isNotEmpty
                  ? _InspeccionFicheroItemGrid(
                      files           : _files,
                      onImagePressed  : _handleImagePressed,
                      onDeletePressed : _handleDeletePressed,
                    )
                  : RequestDataUnavailable(
                      title         : $strings.checklistPhotoAddEmptyListTitle,
                      message       : $strings.checklistPhotoAddEmptyListMessage,
                      isRefreshData : false,
                    ),
            ),
          ),
        ],
      ),
    );

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) { if (!didPop) { _showDidPopDialog(context); } },
      child: Scaffold(
        appBar: AppBar(title: Text($strings.checklistPhotoAddAppBarTitle, style: $styles.textStyles.h3)),
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
    final TextStyle statusStyle = $styles.textStyles.body.copyWith(color: Theme.of(context).colorScheme.onBackground, height: 1.3);
    if (_files.isNotEmpty) {
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

    return const SizedBox.shrink();
  }

  Widget _buildBottomAppBar(BuildContext context) {
    return BottomAppBar(
      height: 70,
      child: Row(
        children: <Widget>[
          IconButton(
            onPressed : _handleTakePhotoPressed,
            icon      : const Icon(Icons.camera_alt),
            tooltip   : 'Tomar fotografía',
          ),
          IconButton(
            onPressed : _handlePickPhotosPressed,
            icon      : const Icon(Icons.photo_library),
            tooltip   : 'Galería',
          ),
          const Spacer(),
          BlocConsumer<RemoteInspeccionFicheroBloc, RemoteInspeccionFicheroState>(
            listener: (BuildContext context, RemoteInspeccionFicheroState state) {
              if (state is RemoteInspeccionFicheroServerFailedMessageStore) {
                _showServerFailedDialog(context, state.errorMessage);
              }

              if (state is RemoteInspeccionFicheroServerFailureStore) {
                _showServerFailedDialog(context, state.failure?.errorMessage);
              }
            },
            builder: (BuildContext context, RemoteInspeccionFicheroState state) {
              if (state is RemoteInspeccionFicheroStoreLoading) {
                return const FilledButton(
                  onPressed : null,
                  child     : AppLoadingIndicator(width: 20, height: 20),
                );
              }
              return FilledButton(
                onPressed : _files.isNotEmpty && !_isPhotoUploading ? _handleStorePressed : null,
                child     : Text($strings.saveButtonText, style: $styles.textStyles.button),
              );
            },
          ),
        ],
      ),
    );
  }
}
