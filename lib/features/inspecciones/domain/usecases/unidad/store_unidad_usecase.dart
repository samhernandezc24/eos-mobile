import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/unidad_repository.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

class StoreUnidadUseCase implements UseCase<DataState<ServerResponse>, UnidadStoreReqEntity> {
  StoreUnidadUseCase(this._unidadRepository);

  final UnidadRepository _unidadRepository;

  @override
  Future<DataState<ServerResponse>> call({required UnidadStoreReqEntity params}) {
    return _unidadRepository.store(params);
  }
}
