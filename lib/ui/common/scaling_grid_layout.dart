import 'package:flutter/rendering.dart';

class ScalingGridLayout extends SliverGridLayout {
  const ScalingGridLayout({
    required this.crossAxisCount,
    required this.dimension,
    required this.fullRowPeriod,
  })  : assert(crossAxisCount > 0, 'crossAxisCount debe ser mayor que 0'),
        assert(fullRowPeriod > 1, 'fullRowPeriod debe ser mayor que 1'),
        loopLength = crossAxisCount * (fullRowPeriod - 1) + 1,
        loopHeight = fullRowPeriod * dimension;

  final int crossAxisCount;
  final double dimension;
  final int fullRowPeriod;

  // Valores computados.
  final int loopLength;
  final double loopHeight;

  @override
  double computeMaxScrollOffset(int childCount) {
    // Retorna el desplazamiento del end side del childCount.
    // Si se establece un `itemCount` en el GridView, esta función se
    // utilizaría para determinar hasta dónde permitir al usuario desplace.
    if (childCount == 0 || dimension == 0) return 0;
    return (childCount ~/ loopLength) * loopHeight + ((childCount % loopLength) ~/ crossAxisCount) * dimension;
  }

  @override
  SliverGridGeometry getGeometryForChildIndex(int index) {
    // Retorna la posición del index.
    //
    // El objeto SliverGridGeometry retornado por este método tiene cuatro
    // propiedades. Para un grid que se desplaza hacia abajo, como lo es aquí,
    // las cuatro propiedades son equivalentes a x, y, width, height. Sin embargo,
    // dado que el GridView es agnóstico en cuanto a la dirección, los nombres
    // utilizados para SliverGridGeometry son también agnósticos a la dirección.
    //
    // Intenta cambiar las propiedades scrollDirection y reverse en el GridView para
    // ver cómo funciona el algoritmo en cualquier dirección.
    final int loop      = index ~/ loopLength;
    final int loopIndex = index % loopLength;
    if (loopIndex == loopLength - 1) {
      // Full width case.
      return SliverGridGeometry(
        scrollOffset    : (loop + 1) * loopHeight - dimension,    // y
        crossAxisOffset : 0,                                      // x
        mainAxisExtent  : dimension,                              // height
        crossAxisExtent : crossAxisCount * dimension,             // width
      );
    }
    // Square case.
    final int rowIndex    = loopIndex ~/ crossAxisCount;
    final int columnIndex = loopIndex % crossAxisCount;
    return SliverGridGeometry(
      scrollOffset    : (loop * loopHeight) + (rowIndex * dimension),    // y
      crossAxisOffset : columnIndex * dimension,                         // x
      mainAxisExtent  : dimension,                                       // height
      crossAxisExtent : dimension,                                       // width
    );
  }

  @override
  int getMinChildIndexForScrollOffset(double scrollOffset) {
    // Retorna el primer index que es visible para un scrollOffset dado.
    //
    // El GridView sólo pregunta por la geometría de las hijos que son visibles
    // entre el desplazamiento pasado a getMinChildIndexForScrollOffset y el
    // desplazamiento pasado a getMaxChildIndexForScrollOffset.
    //
    // Es responsabilidad del SliverGridLayout asegurarse de que getGeometryForChildIndex
    // sea consistente con getMinChildIndexForScrollOffset y getMaxChildIndexForScrollOffset.
    final int rows    = scrollOffset ~/ dimension;
    final int loops   = rows ~/ fullRowPeriod;
    final int extra   = rows % fullRowPeriod;
    return loops * loopLength + extra * crossAxisCount;
  }

  @override
  int getMaxChildIndexForScrollOffset(double scrollOffset) {
    // (Checa el comentario anterior.)
    final int rows    = scrollOffset ~/ dimension;
    final int loops   = rows ~/ fullRowPeriod;
    final int extra   = rows % fullRowPeriod;
    final int count   = loops * loopLength + extra * crossAxisCount;
    if (extra == fullRowPeriod - 1) return count;
    return count + crossAxisCount - 1;
  }
}
