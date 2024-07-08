import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/unidad_repository.dart';

import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:eos_mobile/shared/shared_models.dart';

class RemoteStoreUnidadUseCase implements UseCase<DataState<IReturn>, UnidadStoreReqEntity> {
  RemoteStoreUnidadUseCase(this._unidadRepository);

  final UnidadRepository _unidadRepository;

  @override
  Future<DataState<IReturn>> call({required UnidadStoreReqEntity params}) async {
    return _unidadRepository.store(params);
  }
}
