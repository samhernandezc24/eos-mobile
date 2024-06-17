part of '../../../pages/list/list_page.dart';

class _CreateInspeccionFicheroForm extends StatefulWidget {
  const _CreateInspeccionFicheroForm({required this.objInspeccion, Key? key, this.buildFicheroDataCallback}) : super(key: key);

  final VoidCallback? buildFicheroDataCallback;
  final InspeccionDataSourceEntity objInspeccion;

  @override
  State<_CreateInspeccionFicheroForm> createState() => _CreateInspeccionFicheroFormState();
}

class _CreateInspeccionFicheroFormState extends State<_CreateInspeccionFicheroForm> {
  // REGISTROS ITEMS
  // final UploadResponse uploadResponse = const UploadResponse(status: '', uploadProgress: '', message: '', boolFinalize: false, boolInitial: true, boolSuccess: true);
  List<_InspeccionFicheroItemTile> items = [];

  List<dynamic> lstQueueUpload  = [];
  int _indexUpload              = 0;
  int _countQueueUpload         = 0;
  int _countQueueTotal          = 0;

  final List<File> _files = <File>[];

  bool _isSave = false;

  // EVENTS
  void _handleDidPopPressed(BuildContext context) {
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
              Navigator.of(context).pop();             // Cerrar dialog
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

  Future<void> _handleTakePhotoPressed() async {
    final XFile? file = await imageHelper.takePhoto();
    if (file != null) {
      setState(() {
        _files.add(File(file.path));
      });
    }
  }

  Future<void> _handleSelectPhotosPressed() async {
    final List<XFile> lstFiles = await imageHelper.pickImagesFromGallery();
    if (lstFiles.isNotEmpty) {
      setState(() {
        _files.addAll(lstFiles.map((file) => File(file.path)));
      });
    }
  }

  void _handlePhotoPressed(File file) {
    Navigator.push<void>(
      context,
      PageRouteBuilder<void>(
        transitionDuration: $styles.times.pageTransition,
        pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
          return FadeTransition(
            opacity   : animation,
            child     : Scaffold(
              appBar: AppBar(title: Text('Fotografía', style: $styles.textStyles.h3)),
              body: Center(
                child: Image.file(file),
              ),
            ),
          );
        },
        fullscreenDialog: true,
      ),
    );
  }

  void _handleDeletePhotoPressed(int index) {
    if (!_isSave) {
      setState(() {
        _files.removeAt(index);
      });
    }
  }

  Future<void> _showServerFailedDialog(BuildContext context, String? errorMessage) async {
    return showDialog<void>(
      context : context,
      builder: (BuildContext context)  => ServerFailedDialog(
        errorMessage: errorMessage ?? 'Se produjo un error inesperado. Intenta de nuevo cargas las fotografías.',
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
      setState(() {
        _indexUpload    = 0;
        lstQueueUpload  = [];
      });

      for (int index = 0; index < _files.length; index++) {
        final objUpload = _files[index];
        lstQueueUpload.add(objUpload);
        _countQueueTotal++;
      }
    }

    if (_countQueueUpload < _countQueueTotal) {
      final objUpload = lstQueueUpload[_indexUpload];

      final InspeccionFicheroStoreReqEntity objPost = InspeccionFicheroStoreReqEntity(
        fileBase64      : objUpload.toString(),
        fileExtension   : objUpload.toString(),
        idInspeccion    : widget.objInspeccion.idInspeccion,
        inspeccionFolio : widget.objInspeccion.folio,
      );

      BlocProvider.of<RemoteInspeccionFicheroBloc>(context).add(StoreInspeccionFichero(objPost));
    } else {
      if (lstQueueUpload.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text($strings.alertWarningAttentionTitle, style: $styles.textStyles.bodyBold),
                const Text('Foto(s) guardadas exitosamente', softWrap: true),
              ],
            ),
            backgroundColor : const Color(0xfff89406),
            elevation       : 0,
            behavior        : SnackBarBehavior.fixed,
            showCloseIcon   : true,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text($strings.alertWarningAttentionTitle, style: $styles.textStyles.bodyBold),
                const Text('Algunas fotos no pudieron ser guardadas', softWrap: true),
              ],
            ),
            backgroundColor : const Color(0xfff89406),
            elevation       : 0,
            behavior        : SnackBarBehavior.fixed,
            showCloseIcon   : true,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (!didPop) {
          _handleDidPopPressed(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text($strings.checklistPhotoAddAppBarTitle, style: $styles.textStyles.h3)),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: _files.isNotEmpty
                  ? RepaintBoundary(
                      child: CustomScrollView(
                        scrollBehavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                        slivers: [
                          SliverPadding(
                            padding: EdgeInsets.all($styles.insets.sm),
                            sliver: SliverMasonryGrid.count(
                              crossAxisCount    : (context.widthPx / 300).ceil(),
                              crossAxisSpacing  : $styles.insets.sm,
                              mainAxisSpacing   : $styles.insets.sm,
                              childCount        : _files.length,
                              itemBuilder       : (BuildContext context, int index) {
                                return _InspeccionFicheroItemTile(
                                  objFile         : _files[index],
                                  index           : index,
                                  onPhotoPressed  : _handlePhotoPressed,
                                  onDeletePressed : _handleDeletePhotoPressed,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  : RequestDataUnavailable(title: $strings.checklistPhotoAddEmptyListTitle, message: $strings.checklistPhotoAddEmptyListMessage, isRefreshData: false),
            ),
          ],
        ),
        bottomNavigationBar: _buildBottomAppBar(context),
      ),
    );
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
            onPressed : _handleSelectPhotosPressed,
            icon      : const Icon(Icons.photo_library),
            tooltip   : 'Cargar fotografías',
          ),
          const Spacer(),
          BlocConsumer<RemoteInspeccionFicheroBloc, RemoteInspeccionFicheroState>(
            listener: (BuildContext context, RemoteInspeccionFicheroState state) {
              // ERROR:
              if (state is RemoteInspeccionFicheroServerFailedMessageStore) {
                _showServerFailedDialog(context, state.errorMessage);
              }

              if (state is RemoteInspeccionFicheroServerFailureStore) {
                _showServerFailedDialog(context, state.failure?.errorMessage);
              }

              // SUCCESS:
              if (state is RemoteInspeccionFicheroStoreSuccess) {
                Navigator.of(context).pop();

                ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content         : Text(state.objResponse?.message ?? 'Nuevas fotografías', softWrap: true),
                    backgroundColor : Colors.green,
                    elevation       : 0,
                    behavior        : SnackBarBehavior.fixed,
                  ),
                );

                // Ejecutar callback.
                widget.buildFicheroDataCallback!();
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
                onPressed: _files.isNotEmpty ? _handleStorePressed : null,
                child: Text($strings.saveButtonText, style: $styles.textStyles.button),
              );
            },
          ),
        ],
      ),
    );
  }
}
