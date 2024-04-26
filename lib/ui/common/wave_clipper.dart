import 'package:eos_mobile/shared/shared_libraries.dart';

class WaveClipper extends CustomClipper<Path> {
  WaveClipper({this.reverse = false});

  final bool reverse;

  @override
  Path getClip(Size size) {
    final path = Path();

    final double sizeHeight   = size.height;
    final double sizeWidth    = size.width;
    final double depthTop;
    final double depthBottom;

    Offset firstControlPoint;
    Offset firstEndPoint;
    Offset secondControlPoint;
    Offset secondEndPoint;

    if (!reverse) {
      depthTop      = 100.0;
      depthBottom   = 0.0;

      path.lineTo(0, sizeHeight - depthBottom);

      firstControlPoint   = Offset(sizeWidth * .25, sizeHeight - depthBottom * 2);
      firstEndPoint       = Offset(sizeWidth * .5, sizeHeight - depthTop - depthBottom);

      secondControlPoint  = Offset(sizeWidth * .75, sizeHeight - depthTop * 2);
      secondEndPoint      = Offset(sizeWidth, sizeHeight - depthTop);

      path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);
      path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);
      path.lineTo(sizeWidth, 0);
      path.lineTo(0, 0);
      path.close();
    } else {
      depthTop      = 0.0;
      depthBottom   = 100.0;

      path.lineTo(0, sizeHeight - depthBottom);

      firstControlPoint   = Offset(sizeWidth * .25, sizeHeight - depthBottom * 2);
      firstEndPoint       = Offset(sizeWidth * .5, sizeHeight - depthTop - depthBottom);

      secondControlPoint  = Offset(sizeWidth * .75, sizeHeight - depthTop * 2);
      secondEndPoint      = Offset(sizeWidth, sizeHeight - depthTop);

      path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);
      path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);
      path.lineTo(sizeWidth, 0);
      path.lineTo(0, 0);
      path.close();
    }
    return path;
  }

  @override
  bool shouldReclip(WaveClipper oldClipper) => oldClipper.reverse != reverse;
}
