import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_id_param_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/categoria_repository.dart';

import 'package:eos_mobile/shared/shared_libs.dart';

class RemoteDeleteCategoriaUseCase implements UseCase<DataState<IReturn>, CategoriaIdParamEntity> {
  RemoteDeleteCategoriaUseCase(this._categoriaRepository);

  final CategoriaRepository _categoriaRepository;

  @override
  Future<DataState<IReturn>> call({required CategoriaIdParamEntity params}) async {
    return _categoriaRepository.delete(params);
  }
}
