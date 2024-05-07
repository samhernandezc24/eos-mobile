import 'package:eos_mobile/core/network/data/server_response.dart';
import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/core/usecases/usecase.dart';

import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/inspeccion_repository.dart';

class StoreInspeccionUseCase implements UseCase<DataState<ServerResponse>, InspeccionStoreReqEntity> {
  StoreInspeccionUseCase(this._inspeccionRepository);

  final InspeccionRepository _inspeccionRepository;

  @override
  Future<DataState<ServerResponse>> call({required InspeccionStoreReqEntity params}) {
    return _inspeccionRepository.store(params);
  }
}
