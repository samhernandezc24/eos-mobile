import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageHelper {
  ImageHelper({
    ImagePicker? imagePicker,
    ImageCropper? imageCropper,
  }) : _imagePicker   = imagePicker ?? ImagePicker(),
       _imageCropper  = imageCropper ?? ImageCropper();

  final ImagePicker _imagePicker;
  final ImageCropper _imageCropper;

  Future<List<XFile>> pickImagesFromGallery({
    ImageSource source = ImageSource.gallery,
    int imageQuality = 100,
    bool multiple = false,
  }) async {
    if (multiple) {
      return _imagePicker.pickMultiImage(imageQuality: imageQuality);
    }
    final XFile? file = await _imagePicker.pickImage(source: source, imageQuality: imageQuality);
    if (file != null) return [file];
    return [];
  }

  Future<XFile?> takePhoto({
    ImageSource source = ImageSource.camera,
    int imageQuality = 100,
  }) async {
    final XFile? photo = await _imagePicker.pickImage(source: source,imageQuality: imageQuality);
    if (photo != null) return photo;
    return null;
  }

  Future<CroppedFile?> cropImage({
    required XFile file,
    CropStyle cropStyle = CropStyle.rectangle,
  }) async => _imageCropper.cropImage(
    cropStyle: cropStyle,
    sourcePath: file.path,
    compressQuality: 100,
    uiSettings: <PlatformUiSettings>[
      IOSUiSettings(),
      AndroidUiSettings(
        toolbarTitle: 'Recortar imagen',
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
      ),
    ],
  );
}
