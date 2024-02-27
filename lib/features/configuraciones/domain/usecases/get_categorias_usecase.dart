import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/core/usecases/usecase.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/categoria_entity.dart';
import 'package:eos_mobile/features/configuraciones/domain/repositories/categoria_repository.dart';

class GetCategoriasUseCase implements UseCase<DataState<List<CategoriaEntity>>, void> {
  GetCategoriasUseCase(this._categoriaRepository);

  final CategoriaRepository _categoriaRepository;

  @override
  Future<DataState<List<CategoriaEntity>>> call({void params}) {
    return _categoriaRepository.getCategorias();
  }
}
