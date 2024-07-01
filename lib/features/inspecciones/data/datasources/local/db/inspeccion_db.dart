import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_store_signature_entity.dart';
import 'package:eos_mobile/objectbox.g.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class InspeccionDB {
  factory InspeccionDB() => _inspeccionDB ?? InspeccionDB._instance();
  InspeccionDB._instance() {
    _inspeccionDB = this;
  }
  static InspeccionDB? _inspeccionDB;

  static Store? _store;

  Future<Store?> get store async {
    return _store ??= await _create();
  }

  Future<Store> _create() async {
    final appDir = await getApplicationDocumentsDirectory();
    final dbPath = path.join(appDir.path, '');
    final store = await openStore(directory: dbPath);
    return store;
  }

  void close() async {
    try {
      _store?.close();
    } catch (e) { return; }
  }

  Future<void> storeSignature(InspeccionStoreSignatureEntity signature) async {
    final db = await store;
    await db!.box<InspeccionStoreSignatureEntity>().putAsync(signature, mode: PutMode.insert);
  }
}
