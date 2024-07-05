import 'package:eos_mobile/shared/shared_libs.dart';

/// [CategoriaItemUpdateReqEntity]
///
/// Representa la información para actualizar una pregunta, su propósito es transportar
/// la información requerida para su actualización.
class CategoriaItemUpdateReqEntity extends Equatable {
  const CategoriaItemUpdateReqEntity({
    required this.idCategoriaItem,
    required this.name,
    required this.idFormularioTipo,
    required this.formularioTipoName,
    required this.formularioValor,
  });

  final String idCategoriaItem;
  final String name;
  final String idFormularioTipo;
  final String formularioTipoName;
  final String formularioValor;

  @override
  List<Object?> get props => [
        idCategoriaItem,
        name,
        idFormularioTipo,
        formularioTipoName,
        formularioValor,
      ];
}
