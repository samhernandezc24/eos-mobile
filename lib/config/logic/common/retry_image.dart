import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

/// Un provider de imágenes que reintenta si la carga de bytes falla.
///
/// Útil para peticiones de imágenes en red que pueden fallar transitoriamente.
@immutable
class RetryImage extends ImageProvider<Object> {
  /// Crea un objeto que utiliza [imageProvider] para obtener y decodificar una imagen,
  /// y reintenta si la búsqueda falla.
  const RetryImage(this.imageProvider, {this.scale = 1.0, this.maxRetries = 4});

  /// Un provider de imagen envuelta a utilizar.
  final ImageProvider imageProvider;

  /// El número máximo de veces a reintentar.
  final int maxRetries;

  /// La escala a colocar en el objeto [ImageInfo] de la imagen.
  ///
  /// Debe ser el mismo que el argumento de escala proporcionado a [imageProvider], si
  /// existe.
  final double scale;

  @override
  Future<Object> obtainKey(ImageConfiguration configuration) {
    Completer<Object>? completer;
    // Si el future imageProvider.obtainKey es síncrono, entonces podremos rellenar el resultado con
    // un valor antes de que `completer` se inicialice como se muestra a continuación:
    SynchronousFuture<Object>? result;
    imageProvider.obtainKey(configuration).then((Object key) {
      if (completer == null) {
        // Este future se ha completado sincrónicamente (el completer nunca fue asignado),
        // por lo que podemos crear directamente el resultado síncrono a devolver.
        result = SynchronousFuture<Object>(key);
      } else {
        // Este future no se completó sincrónicamente.
        completer.complete(key);
      }
    });
    if (result != null) {
      return result!;
    }
    // Si el código llega hasta aquí, significa que el imageProvider.obtainKey no fue
    // completado la sincronización, así que inicializamos el completer para completarlo más tarde.
    completer = Completer<Object>();
    return completer.future;
  }

  @override
  ImageStreamCompleter loadImage(Object key, ImageDecoderCallback decode) {
    final _DelegatingImageStreamCompleter completer   = _DelegatingImageStreamCompleter();
    _loadWithRetry(completer, key, decode);
    return completer;
  }

  void _loadWithRetry(
    _DelegatingImageStreamCompleter completer,
    Object key,
    ImageDecoderCallback decode, {
    int retryCount = 0,
    Duration delay = const Duration(milliseconds: 250),
  }) {
    final ImageStreamCompleter completerToWrap = imageProvider.loadImage(key, decode);
    late ImageStreamListener listener;

    listener = ImageStreamListener(
      (ImageInfo image, bool synchronousCall) {
        completer.addImage(image);
      },
      onChunk: completer._reportChunkEvent,
      onError: (Object exception, StackTrace? stackTrace) {
        completerToWrap.removeListener(listener);
        if (retryCount >= maxRetries) {
          completer.reportError(exception: exception, stack: stackTrace);
          return;
        }
        Future<void>.delayed(delay).then((_) {
          _loadWithRetry(completer, key, decode, retryCount: retryCount + 1, delay: delay * 2);
        });
      },
    );

    completerToWrap.addListener(listener);

    completer.addOnLastListenerRemovedCallback(() {
      completerToWrap.removeListener(listener);
    });
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is RetryImage && other.imageProvider == imageProvider && other.scale == scale;
  }

  @override
  int get hashCode => Object.hash(imageProvider, scale);

  @override
  String toString() => '${objectRuntimeType(this, 'RetryImage')}(imageProvider: $imageProvider, maxRetries: $maxRetries, scale: $scale)';
}

class _DelegatingImageStreamCompleter extends ImageStreamCompleter {
  void addImage(ImageInfo info) {
    setImage(info);
  }

  void _reportChunkEvent(ImageChunkEvent event) {
    reportImageChunkEvent(event);
  }
}
