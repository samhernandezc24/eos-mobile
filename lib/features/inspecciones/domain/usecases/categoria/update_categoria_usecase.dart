import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/categoria_repository.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

class UpdateCategoriaUseCase implements UseCase<DataState<ServerResponse>, CategoriaEntity> {
  UpdateCategoriaUseCase(this._categoriaRepository);

  final CategoriaRepository _categoriaRepository;

  @override
  Future<DataState<ServerResponse>> call({required CategoriaEntity params}) {
    return _categoriaRepository.update(params);
  }
}
