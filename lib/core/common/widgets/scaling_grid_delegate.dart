import 'package:eos_mobile/core/common/widgets/scaling_grid_layout.dart';
import 'package:flutter/rendering.dart';

class ScalingGridDelegate extends SliverGridDelegate {
  ScalingGridDelegate({required this.dimension});

  final double dimension;

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    // Determina cuántos cuadrados no caben por fila.
    int count = constraints.crossAxisExtent ~/ dimension;
    if (count < 1) {
      count = 1;    // siempre hay que colocar al menos uno
    }
    final double squareDimension = constraints.crossAxisExtent / count;
    return ScalingGridLayout(
      crossAxisCount: count,
      fullRowPeriod: 3,           // numero de filas por bloque
      dimension: squareDimension,
    );
  }

  @override
  bool shouldRelayout(ScalingGridDelegate oldDelegate) {
    return dimension != oldDelegate.dimension;
  }
}
