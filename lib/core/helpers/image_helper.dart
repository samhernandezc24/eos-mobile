import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ImageHelper {
  ImageHelper({
    ImagePicker? imagePicker,
    ImageCropper? imageCropper,
  }) : _imagePicker   = imagePicker ?? ImagePicker(),
       _imageCropper  = imageCropper ?? ImageCropper();

  final ImagePicker _imagePicker;
  final ImageCropper _imageCropper;

  /// Seleccionar imágenes de la galería.
  ///
  /// Retorna una lista de [XFile] que representa los archivos de imagen comprimidos.
  Future<List<XFile>> pickPhotos({
    ImageSource source  = ImageSource.gallery,
    int imageQuality    = 100,
    bool multiple       = false,
  }) async {
    if (multiple) {
      // Si se selecciona múltiples imagenes, se utiliza `pickMultiImage` del ImagePicker.
      final List<XFile> files = await _imagePicker.pickMultiImage(imageQuality: imageQuality);
      return _compressImages(files);
    }

    // Si se selecciona solo una imagen de la galería, se utiliza `pickImage` del ImagePicker.
    final XFile? file = await _imagePicker.pickImage(source: source, imageQuality: imageQuality);
    if (file != null) {
      // Comprimir la imagen seleccionada y retornarla en una lista si se comprime correctamente.
      final compressedFile = await _compressImage(file);
      return compressedFile != null ? [compressedFile] : [];
    }
    return [];
  }

  /// Capturar una foto utilizando la cámara del dispositivo.
  ///
  /// Retorna un [XFile] que representa el archivo de imagen comprimido.
  Future<XFile?> takePhoto({
    ImageSource source  = ImageSource.camera,
    int imageQuality    = 100,
  }) async {
    final XFile? photo = await _imagePicker.pickImage(source: source,imageQuality: imageQuality);
    if (photo != null) {
      // Comprimir la foto capturada y retornarla si se comprime correctamente.
      final XFile? compressedFile = await _compressImage(photo);
      return compressedFile;
    }
    return null;
  }

  /// Recortar una imagen.
  ///
  /// Retorna un objeto [CroppedFile] que representa la imagen recortada.
  Future<CroppedFile?> cropImage({
    required XFile file,
    CropStyle cropStyle = CropStyle.rectangle,
  }) async {
    return _imageCropper.cropImage(
      cropStyle       : cropStyle,
      sourcePath      : file.path,
      compressQuality : 100,
      uiSettings      : <PlatformUiSettings>[
        IOSUiSettings(),
        AndroidUiSettings(
          toolbarTitle    : 'Recortar imagen',
          initAspectRatio : CropAspectRatioPreset.original,
          lockAspectRatio : false,
        ),
      ],
    );
  }

  /// Comprime una imagen.
  ///
  /// Retorna un [XFile] que representa el archivo de imagen comprimido.
  Future<XFile?> _compressImage(XFile file) async {
    final Directory dir     = await getTemporaryDirectory();
    final String targetPath = '${dir.absolute.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

    // Comprimir la imagen utilizando `FlutterImageCompress`.
    final XFile? result = await FlutterImageCompress.compressAndGetFile(
      file.path, targetPath,
      minWidth  : 800,
      minHeight : 800,
      quality   : 70,
    );

    return result;
  }

  /// Comprime una lista de imágenes.
  ///
  /// Retorna una lista de [XFile] que representa los archivos de imagen comprimidos.
  Future<List<XFile>> _compressImages(List<XFile> files) async {
    final List<XFile> compressedFiles = [];
    for (final XFile file in files) {
      // Comprimir cada imagen individualmente y agregarla a la lista de resultados.
      final XFile? compressedFile = await _compressImage(file);
      if (compressedFile != null) {
        compressedFiles.add(compressedFile);
      }
    }
    return compressedFiles;
  }
}
