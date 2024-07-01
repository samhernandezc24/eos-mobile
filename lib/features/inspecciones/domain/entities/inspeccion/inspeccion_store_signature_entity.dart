import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:objectbox/objectbox.dart';

/// [InspeccionStoreSignatureEntity]
///
/// Representa los datos temporales a guardar de la firma de una inspección.
@Entity()
class InspeccionStoreSignatureEntity extends Equatable {
  const InspeccionStoreSignatureEntity({
    this.id,
    this.firmaPath,
    this.idInspeccion,
  });

  @Id(assignable: true)
  final int? id;
  final String? firmaPath;
  final String? idInspeccion;

  @override
  List<Object?> get props => [ id, firmaPath, idInspeccion ];
}
