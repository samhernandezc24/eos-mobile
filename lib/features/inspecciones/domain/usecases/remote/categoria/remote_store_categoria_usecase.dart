import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/categoria_repository.dart';

import 'package:eos_mobile/shared/shared_libs.dart';

class RemoteStoreCategoriaUseCase implements UseCase<DataState<IReturn>, CategoriaStoreReqEntity> {
  RemoteStoreCategoriaUseCase(this._categoriaRepository);

  final CategoriaRepository _categoriaRepository;

  @override
  Future<DataState<IReturn>> call({required CategoriaStoreReqEntity params}) async {
    return _categoriaRepository.store(params);
  }
}
