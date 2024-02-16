import 'package:flutter/material.dart';

/// Un widget reutilizable que crea un clipper en forma de wave.
///
/// Este widget es útil para aplicar un efecto visual de wave a widgets como
/// contenedores o imágenes. Proporciona la capacidad de controlar la dirección
/// y la intensidad del wave a través del parámetro opcional [reverse].
///
/// {@tool dartpad}
/// El siguiente ejemplo muestra cómo usar el widget [ClipPath] junto con
/// el clipper [WaveClipper] para crear un fondo con una forma de wave.
///
/// ```dart
/// ClipPath(
///   clipper: WaveClipper(),
///   child: Container(
///     padding: const EdgeInsets.only(bottom: 450),
///     color: const Colors.blue.withOpacity(0.8),
///     height: 220,
///   ),
/// ),
/// ```
///
/// {@end-tool}
///
/// Consulta también:
///
///  * [CustomClipper], que se utiliza para proporcionar clips personalizados.
///  * [ClipPath], el widget que recorta y pinta a los widgets.
class WaveClipper extends CustomClipper<Path> {
  WaveClipper({this.reverse = false});
  final bool reverse;

  @override
  Path getClip(Size size) {
    var path = Path();
    final double sizeHeight = size.height;
    final double sizeWidth = size.width;
    final double depthTop;
    final double depthBottom;
    Offset firstControlPoint, firstEndPoint, secondControlPoint, secondEndPoint;

    if (!reverse) {
      depthTop = 100.0;
      depthBottom = 0.0;

      path.lineTo(0.0, sizeHeight - depthBottom);

      firstControlPoint = Offset(sizeWidth * .25, sizeHeight - depthBottom * 2);
      firstEndPoint = Offset(sizeWidth * .5, sizeHeight - depthTop - depthBottom);

      secondControlPoint = Offset(sizeWidth * .75, sizeHeight - depthTop * 2);
      secondEndPoint = Offset(sizeWidth, sizeHeight - depthTop);

      path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);
      path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);

      path.lineTo(sizeWidth, 0.0);
      path.lineTo(0.0, 0.0);
      path.close();
    } else {
      depthTop = 0.0;
      depthBottom = 100.0;

      path.lineTo(0.0, sizeHeight - depthBottom);

      firstControlPoint = Offset(sizeWidth * .25, sizeHeight - depthBottom * 2);
      firstEndPoint = Offset(sizeWidth * .5, sizeHeight - depthTop - depthBottom);

      secondControlPoint = Offset(sizeWidth * .75, sizeHeight - depthTop * 2);
      secondEndPoint = Offset(sizeWidth, sizeHeight - depthTop);

      path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);
      path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);

      path.lineTo(sizeWidth, 0.0);
      path.lineTo(0.0, 0.0);
      path.close();
    }
    return path;
  }

  @override
  bool shouldReclip(WaveClipper oldClipper) => oldClipper.reverse != reverse;
}
