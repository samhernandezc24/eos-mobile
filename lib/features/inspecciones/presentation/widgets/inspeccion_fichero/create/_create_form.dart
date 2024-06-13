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
  final UploadResponse uploadResponse = const UploadResponse(status: '', uploadProgress: '', message: '', boolFinalize: false, boolInitial: true, boolSuccess: true);

  final List<File> _files = [];

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

  void _handleOpenPhotoTap(File file) {
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
                                  onOpenTap       : _handleOpenPhotoTap,
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
          FilledButton(
            onPressed: _files.isEmpty ? null : () {},
            child: Text($strings.saveButtonText, style: $styles.textStyles.button),
          ),
        ],
      ),
    );
  }
}
