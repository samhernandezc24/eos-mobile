import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/categoria_repository.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

class StoreCategoriaUseCase implements UseCase<DataState<ServerResponse>, CategoriaStoreReqEntity> {
  StoreCategoriaUseCase(this._categoriaRepository);

  final CategoriaRepository _categoriaRepository;

  @override
  Future<DataState<ServerResponse>> call({required CategoriaStoreReqEntity params}) {
    return _categoriaRepository.store(params);
  }
}
