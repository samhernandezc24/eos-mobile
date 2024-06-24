import 'package:eos_mobile/config/logic/common/retry_image.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:eos_mobile/ui/common/image_fade.dart';
import 'package:flutter/foundation.dart';

class AppImage extends StatefulWidget {
  const AppImage({
    required this.image,
    Key? key,
    this.fit            = BoxFit.scaleDown,
    this.alignment      = Alignment.center,
    this.duration,
    this.syncDuration,
    this.distractor     = false,
    this.progress       = false,
    this.color,
    this.scale,
  }) : super(key: key);

  final ImageProvider? image;
  final BoxFit fit;
  final Alignment alignment;
  final Duration? duration;
  final Duration? syncDuration;
  final bool distractor;
  final bool progress;
  final Color? color;
  final double? scale;

  @override
  State<AppImage> createState() => _AppImageState();
}

class _AppImageState extends State<AppImage> {
  // PROPERTIES
  ImageProvider? _displayImage;
  ImageProvider? _sourceImage;

  // STATE
  @override
  void didChangeDependencies() {
    _updateImage();
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(AppImage oldWidget) {
    _updateImage();
    super.didUpdateWidget(oldWidget);
  }

  // METHODS
  void _updateImage() {
    if (widget.image == _sourceImage) return;
    _sourceImage  = widget.image;
    _displayImage = _capImageSize(_addRetry(_sourceImage));
  }

  @override
  Widget build(BuildContext context) {
    return ImageFade(
      image           : _displayImage,
      fit             : widget.fit,
      alignment       : widget.alignment,
      duration        : widget.duration ?? $styles.times.fast,
      syncDuration    : widget.syncDuration ?? 0.ms,
      loadingBuilder  : (_, value, ___) {
        if (!widget.distractor && !widget.progress) return const SizedBox();
        return Center(child: AppLoadingIndicator(value: widget.progress ? value : null, color: widget.color));
      },
      errorBuilder: (_, __) => Container(
        padding   : EdgeInsets.all($styles.insets.xs),
        alignment : Alignment.center,
        child     : LayoutBuilder(builder: (_, constraints) {
          final double size = min(constraints.biggest.width, constraints.biggest.height);
          if (size < 16) return const SizedBox();
          return Icon(
            Icons.image_not_supported,
            color : Colors.white.withOpacity(0.1),
            size  : min(size, $styles.insets.lg),
          );
        }),
      ),
    );
  }

  ImageProvider? _addRetry(ImageProvider? image) {
    return image == null ? image : RetryImage(image);
  }

  ImageProvider? _capImageSize(ImageProvider? image) {
    // Deshabilitar el redimensionamiento para la web, ya que actualmente es de un solo hilo y hace que la interfaz
    // de usuario se bloquee cuando se redimensionan imágenes grandes.
    if (kIsWeb) {
      // TODO(samhernandezc24): Eliminar esto cuando el motor web se actualice para soportar el redimensionamiento de imágenes sin bloqueo.
      return image;
    }
    if (image == null || widget.scale == null) return image;
    final MediaQueryData mq   = MediaQuery.of(context);
    final Size screenSize     = mq.size * mq.devicePixelRatio * widget.scale!;
    return ResizeImage(image, width: screenSize.width.round());
  }
}
