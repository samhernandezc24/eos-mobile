import 'package:eos_mobile/core/network/errors/exceptions.dart';
import 'package:eos_mobile/features/inspecciones/data/datasources/local/db/inspeccion_db.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_store_signature_entity.dart';

abstract class InspeccionLocalDataService {
  factory InspeccionLocalDataService(InspeccionDB inspeccionDB) = _InspeccionLocalDataService;

  /// GUARDAR LA FIRMA DE LA INSPECCION EN LOCAL (TEMPORALMENTE)
  Future<void> storeSignature(InspeccionStoreSignatureEntity signature);
}

class _InspeccionLocalDataService implements InspeccionLocalDataService {
  _InspeccionLocalDataService(this.inspeccionDB);
  final InspeccionDB inspeccionDB;

  @override
  Future<void> storeSignature(InspeccionStoreSignatureEntity signature) async {
    try {
      return await inspeccionDB.storeSignature(signature);
    } catch (e) {
      throw LocalDatabaseException();
    }
  }
}
