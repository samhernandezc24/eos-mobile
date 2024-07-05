import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_update_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/categoria_repository.dart';

import 'package:eos_mobile/shared/shared_libs.dart';

class RemoteUpdateCategoriaUseCase implements UseCase<DataState<IReturn>, CategoriaUpdateReqEntity> {
  RemoteUpdateCategoriaUseCase(this._categoriaRepository);

  final CategoriaRepository _categoriaRepository;

  @override
  Future<DataState<IReturn>> call({required CategoriaUpdateReqEntity params}) async {
    return _categoriaRepository.update(params);
  }
}
