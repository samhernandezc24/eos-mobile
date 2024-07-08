import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_params_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/categoria_repository.dart';

import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:eos_mobile/shared/shared_models.dart';

class RemoteDeleteCategoriaUseCase implements UseCase<DataState<IReturn>, CategoriaParamsEntity> {
  RemoteDeleteCategoriaUseCase(this._categoriaRepository);

  final CategoriaRepository _categoriaRepository;

  @override
  Future<DataState<IReturn>> call({required CategoriaParamsEntity params}) async {
    return _categoriaRepository.delete(params);
  }
}
