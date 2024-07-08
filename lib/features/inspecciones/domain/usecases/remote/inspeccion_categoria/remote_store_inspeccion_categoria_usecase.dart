import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_categoria/inspeccion_categoria_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/inspeccion_categoria_repository.dart';

import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:eos_mobile/shared/shared_models.dart';

class RemoteStoreInspeccionCategoriaUseCase implements UseCase<DataState<IReturn>, InspeccionCategoriaStoreReqEntity> {
  RemoteStoreInspeccionCategoriaUseCase(this._inspeccionCategoriaRepository);

  final InspeccionCategoriaRepository _inspeccionCategoriaRepository;

  @override
  Future<DataState<IReturn>> call({required InspeccionCategoriaStoreReqEntity params}) async {
    return _inspeccionCategoriaRepository.store(params);
  }
}
