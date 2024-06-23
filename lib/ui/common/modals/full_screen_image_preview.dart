import 'dart:io';

import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

/// TODO(samhernandezc24): Modificar este widget para las operaciones del Stream para la carga de [imageFiles] tanto como ImageFile como NetworkImage.
class FullScreenImagePreview extends StatefulWidget {
  const FullScreenImagePreview({required this.imageFiles, required this.initialIndex, Key? key}) : super(key: key);

  final List<File> imageFiles;
  final int initialIndex;

  @override
  State<FullScreenImagePreview> createState() => _FullScreenImagePreviewState();
}

class _FullScreenImagePreviewState extends State<FullScreenImagePreview> {
  // CONTROLLERS
  late PageController _pageController;

  // PROPERTIES
  int _currentIndex = 0;

  // STATE
  @override
  void initState() {
    super.initState();
    _currentIndex     = widget.initialIndex;
    _pageController   = PageController(initialPage: widget.initialIndex);
  }

  // EVENTS
  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Foto ${_currentIndex + 1} de ${widget.imageFiles.length}', style: $styles.textStyles.h3),
      ),
      body: PhotoViewGallery.builder(
        scrollPhysics         : const BouncingScrollPhysics(),
        builder               : (BuildContext context, int index) {
          return PhotoViewGalleryPageOptions(
            imageProvider   : FileImage(widget.imageFiles[index]),
            initialScale    : PhotoViewComputedScale.contained * 0.8,
            minScale        : PhotoViewComputedScale.contained,
            maxScale        : PhotoViewComputedScale.covered * 1.1,
          );
        },
        itemCount             : widget.imageFiles.length,
        loadingBuilder        : (context, event) => _buildLoading(event),
        backgroundDecoration  : BoxDecoration(color: Theme.of(context).splashColor.withOpacity(0.1)),
        pageController        : _pageController,
        onPageChanged         : _onPageChanged,
      ),
    );
  }

  Center _buildLoading(ImageChunkEvent? event) {
    final double value = event == null || event.expectedTotalBytes == null
        ? 0
        : event.cumulativeBytesLoaded / event.expectedTotalBytes!;
    return Center(
      child: SizedBox(
        width   : 30,
        height  : 30,
        child   : CircularProgressIndicator(
          color       : Theme.of(context).primaryColor,
          strokeWidth : 3,
          value       : value,
        ),
      ),
    );
  }
}
