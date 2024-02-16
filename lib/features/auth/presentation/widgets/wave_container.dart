import 'package:eos_mobile/ui/common/wave_clipper.dart';
import 'package:flutter/material.dart';

class WaveContainer extends StatelessWidget {
  const WaveContainer({
    required this.reverse,
    required this.waveHeight,
    required this.containerHeight,
    required this.containerColor,
    super.key,
  });

  final bool reverse;
  final double waveHeight;
  final double containerHeight;
  final Color containerColor;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: WaveClipper(reverse: reverse),
      child: Container(
        padding: EdgeInsets.only(bottom: waveHeight),
        color: containerColor,
        height: containerHeight,
        alignment: Alignment.center,
      ),
    );
  }
}
