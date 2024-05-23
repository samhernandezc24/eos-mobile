import 'package:eos_mobile/core/data/inspeccion/categoria.dart';
import 'package:eos_mobile/core/data/inspeccion/inspeccion.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

class InspeccionCategoriaChecklistEntity extends Equatable {
  const InspeccionCategoriaChecklistEntity({this.inspeccion, this.categorias});

  final Inspeccion? inspeccion;
  final List<Categoria>? categorias;

  @override
  List<Object?> get props => [ inspeccion, categorias ];
}
