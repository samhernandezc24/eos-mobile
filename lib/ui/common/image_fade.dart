import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';

/// Signature utilizada por [ImageFade.errorBuilder] para construir el widget que se mostrará
/// si se produce un error al cargar una imagen.
typedef ImageFadeErrorBuilder = Widget Function(
  BuildContext context,
  Object exception,
);

/// Signature utilizada por [ImageFade.loadingBuilder] para construir el widget que se mostrará
/// mientras se carga una imagen. `progress` devuelve un valor entre 0 y 1 indicando el progreso de la carga.
typedef ImageFadeLoadingBuilder = Widget Function(
  BuildContext context,
  double progress,
  ImageChunkEvent? chunkEvent,
);

/// Un widget que muestra un widget [placeholder] mientras se carga una [image] especificada,
/// y luego muestra la imagen cargada. Opcionalmente puede mostrar el progreso de carga
/// y errores.
///
/// Si la [image] se cambia posteriormente, se mostrará la nueva imagen una vez que termine de cargarse.
/// termine de cargarse.
///
/// Si la [image] es null, se volverá a [placeholder].
///
/// ```dart
/// ImageFade(
///   placeholder: Image.asset('assets/myPlaceholder.png'),
///   image: NetworkImage('https://backend.example.com/image.png'),
/// )
/// ```
class ImageFade extends StatefulWidget {
  /// Crea un widget que muestra un widget [placeholder] mientras se carga una [image] especificada,
  /// y luego muestra la imagen cargada.
  const ImageFade({
    Key? key,
    this.placeholder,
    this.image,
    this.curve                  = Curves.linear,
    this.duration               = const Duration(milliseconds: 300),
    this.syncDuration,
    this.width,
    this.height,
    this.scale                  = 1,
    this.fit                    = BoxFit.scaleDown,
    this.alignment              = Alignment.center,
    this.repeat                 = ImageRepeat.noRepeat,
    this.matchTextDirection     = false,
    this.excludeFromSemantics   = false,
    this.semanticLabel,
    this.loadingBuilder,
    this.errorBuilder,
  }) : super(key: key);

  /// Widget situado detrás de las imágenes cargadas. Se muestra cuando [image] es null o se está cargando inicialmente.
  final Widget? placeholder;

  /// La imgen a mostrar. si se cambia la imagen posteriormente, la nueva imagen se desvanecerá sobre la anterior.
  final ImageProvider? image;

  /// La curva de la animación fade-in.
  final Curve curve;

  /// La duración de la animación fade-in.
  final Duration duration;

  /// Una duración opcional para el fading de una imagen cargada sincrónicamente (ej. desde la memoria), un error o un
  /// placeholder.
  /// Por ejemplo, puedes establecer esto a `Duration.zero` para mostrar inmediatamente imágenes que ya están cargadas.
  /// Si se omite, se utilizará [duration].
  final Duration? syncDuration;

  /// El ancho a mostrar. Ver [Image.width] para más información.
  final double? width;

  /// La altura de la imagen. Ver [Image.height] para más información.
  final double? height;

  /// El factor de escala para dibujar esta imagen al tamaño deseado. Ver [RawImage.scale] para más información.
  final double scale;

  /// Cómo dibujar la imagen dentro de sus límites. Por defecto es [BoxFit.scaleDown]. Ver [Image.fit] para más información.
  final BoxFit fit;

  /// Cómo alinear la imagen dentro de sus límites. Ver [Image.alignment] para más información.
  final Alignment alignment;

  /// Cómo pintar las partes de los límites del layout no cubiertas por la imagen. Ver [Image.repeat] para más información.
  final ImageRepeat repeat;

  /// Cómo pintar la imagen en la dirección de [TextDirection]. Ver [Image.matchTextDirection] para más información.
  final bool matchTextDirection;

  /// Si excluir esta imagen de la semántica. Ver [Image.excludeFromSemantics] para más información.
  final bool excludeFromSemantics;

  /// Una descripción semántica de la imagen. Ver [Image.semanticLabel] para más información.
  final String? semanticLabel;

  /// Un constructor que especifica el widget a mostrar mientras se carga una imagen.
  /// Ver [ImageFadeLoadingBuilder] para más información.
  final ImageFadeLoadingBuilder? loadingBuilder;

  /// Un constructor que especifica el widget a mostrar si se produce un error mientras se carga una imagen.
  /// Se mostrará sobre el contenido anterior, por lo que se recomienda establecer un fondo opaco.
  final ImageFadeErrorBuilder? errorBuilder;

  @override
  State<StatefulWidget> createState() => _ImageFadeState();
}

class _ImageFadeState extends State<ImageFade> with TickerProviderStateMixin {
  _ImageResolver? _resolver;
  Widget? _front;
  Widget? _back;

  late final AnimationController _controller;
  Widget? _fadeFront;
  Widget? _fadeBack;

  bool? _sync;                    // podría usar onImage synchronousCall, pero esto es más flexible
  bool _shouldBuildFront = false;

  // STATE
  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // No se puede llamar esto en initState porque createLocalImageConfiguration arroja errores:
    _update(context);
  }

  @override
  void didUpdateWidget(ImageFade old) {
    super.didUpdateWidget(old);
    _update(context, old);
  }

  void _update(BuildContext context, [ImageFade? old]) {
    final ImageProvider? image = widget.image;
    final ImageProvider? oldImage = old?.image;
    if (image == oldImage) return;

    _back = null;
    _shouldBuildFront = false;

    if (_resolver != null) {
      // Mover la imagen cargada anteriormente hacia atrás y cancelar cualquier carga activa.
      if (_resolver!.complete) _back = _fadeBack = _front;
      _resolver!.dispose();
    }

    // Cargar la nueva imagen:
    _front      = _sync = null;
    _resolver   = image == null
        ? null
        : _ImageResolver(image, context, onError: _handleComplete, onComplete: _handleComplete, width: widget.width, height: widget.height);
    // Comenzar transición a placeholder si no hay nueva imagen:
    if (_back != null && _resolver == null) _buildTransition();
  }

  void _handleComplete(_ImageResolver resolver) {
    _sync ??= true;
    setState(() => _shouldBuildFront = true);
  }

  void _buildFront(BuildContext context) {
    _shouldBuildFront = false;
    final _ImageResolver resolver = _resolver!;
    _front = resolver.error
        ? widget.errorBuilder?.call(context, resolver.exception!)
        : _getImage(resolver.image);
    _buildTransition();
  }

  void _buildTransition() {
    final bool out = _front == null;    // no hay nueva imagen

    // Utilizar la duración "fast" si es la carga de sincronización, error, o placeholder:
    final bool fast           = (_sync ?? false) || (_resolver?.error ?? false) || out;
    final Duration duration   = (fast ? widget.syncDuration : null) ?? widget.duration;

    // Fade-in por duración, de salida por 1/2 de duración:
    _controller.duration = duration * (out ? 1 : 3 / 2);

    _fadeFront = _buildFade(
      child   : _front,
      opacity : CurvedAnimation(parent: _controller, curve: Interval(0, 2 / 3, curve: widget.curve)),
    );

    _fadeBack = _buildFade(
      child   : _back,
      opacity : Tween<double>(begin: 1, end: 0).animate(
        CurvedAnimation(parent: _controller, curve: Interval(out ? 0.0 : 2 / 3, 1)),
      ),
    );

    if (_front != null || _back != null) _controller.forward(from: 0);
  }

  Widget? _buildFade({required Animation<double> opacity, Widget? child}) {
    if (child == null) return null;
    // Si el hijo es una imagen cargada, podemos aplicar el fade a su opacidad directamente para un mejor rendimiento:
    return (child is RawImage)
        ? _getImage(child.image, opacity: opacity)
        : FadeTransition(opacity: opacity, child: child);
  }

  RawImage _getImage(ui.Image? image, {Animation<double>? opacity}) {
    return RawImage(
      image               : image,
      width               : widget.width,
      height              : widget.height,
      scale               : widget.scale,
      fit                 : widget.fit,
      alignment           : widget.alignment,
      repeat              : widget.repeat,
      matchTextDirection  : widget.matchTextDirection,
      opacity             : opacity,
    );
  }

  @override
  Widget build(BuildContext context) {
    _sync ??= false;
    if (_shouldBuildFront) _buildFront(context);
    Widget? front       = _fadeFront;
    final Widget? back  = _fadeBack;

    final bool inLoad = _resolver != null && !_resolver!.complete;
    if (inLoad && widget.loadingBuilder != null) {
      final _ImageResolver resolver = _resolver!;

      front = AnimatedBuilder(
        animation : resolver.notifier,
        builder   : (_, __) => widget.loadingBuilder!(context, resolver.notifier.value, resolver.chunkEvent),
      );
    }

    final List<Widget> kids = [];
    if (widget.placeholder != null) kids.add(widget.placeholder!);
    if (back != null) kids.add(back);
    if (front != null) kids.add(front);

    final Widget content = SizedBox(
      width: widget.width,
      height: widget.height,
      child: kids.isEmpty
          ? null
          : Stack(fit: StackFit.passthrough, children: kids),
    );

    if (widget.excludeFromSemantics) return content;

    final String? label = widget.semanticLabel;
    return Semantics(
      container : label != null,
      image     : true,
      label     : label ?? '',
      child     : content,
    );
  }

  @override
  void dispose() {
    _resolver?.dispose();
    _controller.dispose();
    super.dispose();
  }
}

// Simplifica el trabajo con eventos y estados de carga de imágenes.
class _ImageResolver {
  _ImageResolver(
    ImageProvider provider,
    BuildContext context, {
    required this.onComplete,
    required this.onError,
    double? width,
    double? height,
  }) {
    final Size? size = width != null && height != null ? Size(width, height) : null;
    final ImageConfiguration config = createLocalImageConfiguration(context, size: size);
    _listener = ImageStreamListener(
      _handleComplete,
      onChunk: _handleProgress,
      onError: _handleError,
    );
    _stream = provider.resolve(config);
    _stream.addListener(_listener);     // Callback de sincronización si ya se ha completado.
    notifier = ValueNotifier(0);
  }

  // PROPERTIES
  Object? exception;
  ImageChunkEvent? chunkEvent;
  late final ValueNotifier<double> notifier;

  final void Function(_ImageResolver resolver) onComplete;
  final void Function(_ImageResolver resolver) onError;

  late final ImageStream _stream;
  late final ImageStreamListener _listener;
  ImageInfo? _imageInfo;
  bool _complete = false;

  ui.Image? get image => _imageInfo?.image;
  bool get complete   => _complete;
  bool get error      => exception != null;

  // EVENTS
  void _handleComplete(ImageInfo imageInfo, bool sync) {
    _imageInfo = imageInfo;
    _complete = true;
    onComplete(this);
  }

  void _handleProgress(ImageChunkEvent event) {
    chunkEvent = event;
    notifier.value = event.expectedTotalBytes != null
        ? event.cumulativeBytesLoaded / event.expectedTotalBytes!
        : 0.0;
  }

  void _handleError(Object exc, StackTrace? _) {
    exception = exc;
    _complete = true;
    onError(this);
  }

  void dispose() {
    _stream.removeListener(_listener);
  }
}
