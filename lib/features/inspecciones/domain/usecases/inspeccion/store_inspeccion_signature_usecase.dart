import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_store_signature_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/inspeccion_repository.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';

class StoreInspeccionSignatureUseCase implements UseCase<void, InspeccionStoreSignatureEntity> {
  StoreInspeccionSignatureUseCase(this._inspeccionRepository);

  final InspeccionRepository _inspeccionRepository;

  @override
  Future<void> call({required InspeccionStoreSignatureEntity params}) {
    return _inspeccionRepository.storeSignature(params);
  }
}
