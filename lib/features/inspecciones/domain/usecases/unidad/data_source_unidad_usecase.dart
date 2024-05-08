import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_data_source_res_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/unidad_repository.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

class DataSourceUnidadUseCase implements UseCase<DataState<UnidadDataSourceResEntity>, Map<String, dynamic>> {
  DataSourceUnidadUseCase(this._unidadRepository);

  final UnidadRepository _unidadRepository;

  @override
  Future<DataState<UnidadDataSourceResEntity>> call({required Map<String, dynamic> params}) {
    return _unidadRepository.dataSource(params);
  }
}
