import 'dart:io';

import 'package:eos_mobile/features/inspecciones/presentation/pages/fotos/fotos_grid.dart';
import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:image_picker/image_picker.dart';

class FotosPage extends StatefulWidget {
  const FotosPage({Key? key}) : super(key: key);

  @override
  State<FotosPage> createState() => _FotosPageState();
}

class _FotosPageState extends State<FotosPage> {
  // REGISTROS ITEMS
  List<File> lstQueueUpload     = [];
  int indexUpload               = 0;
  int countQueueUpload          = 0;
  int countQueueTotal           = 0;

  // LIST
  final List<File> _files = [];
  bool _isUploading = false;
  bool _isSave = false;

  // EVENT
  Future<void> _handleTakePhotoPressed() async {
    final XFile? file = await imageHelper.takePhoto();
    if (file != null) {
      setState(() {
        _files.add(File(file.path));
      });
    }
  }

  Future<void> _handlePickPhotosPressed() async {
    final List<XFile> images = await imageHelper.pickPhotos(multiple: true);
     setState(() {
      _files.addAll(images.map((file) => File(file.path)));
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

  // METHODS
  void _loading({bool value = true}) {
    setState(() {
      _isSave       = value;
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
      final objUpload = lstQueueUpload[indexUpload];

      // IMPLEMENTAR LA SUBIDA
      await _uploadFile(objUpload);

      setState(() {
        lstQueueUpload.removeAt(indexUpload);
        _files.removeAt(indexUpload);

        countQueueUpload++;
      });

      await _store();

    } else {
      if (lstQueueUpload.isEmpty) {
         ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Fotos guardadas exitosamente')),
        );
      } else {
         ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Algunas fotos no pudieron ser guardadas')),
        );
        _loading(value: false);
      }
      setState(() {
        _isUploading = false;
      });
    }
  }

  Future<void> _uploadFile(File file) async {
    // Simular tiempo de subida
    await Future<void>.delayed(const Duration(seconds: 2));

    // Aquí puedes implementar la lógica real de subida del archivo
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // INFORMACION DE LA SUBIDA DE FICHEROS
          Container(
            padding : EdgeInsets.all($styles.insets.xs * 1.5),
            child   : _buildStatusText(context),
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
                  : FotosInspeccionFicheroGrid(
                      files       : _files,
                      isUploading : _isUploading,
                    ),
            ),
          ),

          // Expanded(
          //   child: ListView.separated(
          //     itemCount: _files.length,
          //     separatorBuilder: (context, index) => const Divider(height: 1, color: Colors.grey),
          //     itemBuilder: (context, index) {
          //       return ListTile(
          //         leading: Image.file(_files[index]),
          //         title: Text('Foto ${index + 1}'),
          //         subtitle: _isUploading && index == 0 ? const AppLinearIndicator() : null,
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
      bottomNavigationBar: _buildBottomAppBar(context),
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
          FilledButton(
            onPressed: _isUploading ? null : _handleStorePressed,
            child     : Text(AppStrings.btnSaveText, style: $styles.textStyles.button),
          ),
        ],
      ),
    );
  }
}
