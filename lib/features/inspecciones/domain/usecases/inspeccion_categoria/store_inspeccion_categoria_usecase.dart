import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_categoria/inspeccion_categoria_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/inspeccion_categoria_repository.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

class StoreInspeccionCategoriaUseCase implements UseCase<DataState<ServerResponse>, InspeccionCategoriaStoreReqEntity> {
  StoreInspeccionCategoriaUseCase(this._inspeccionCategoriaRepository);

  final InspeccionCategoriaRepository _inspeccionCategoriaRepository;

  @override
  Future<DataState<ServerResponse>> call({required InspeccionCategoriaStoreReqEntity params}) {
    return _inspeccionCategoriaRepository.store(params);
  }
}
