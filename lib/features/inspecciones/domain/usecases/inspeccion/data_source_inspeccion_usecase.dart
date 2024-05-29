import 'package:eos_mobile/core/data/data_source.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_data_source_res_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/inspeccion_repository.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

class DataSourceInspeccionUseCase implements UseCase<DataState<InspeccionDataSourceResEntity>, DataSource> {
  DataSourceInspeccionUseCase(this._inspeccionRepository);

  final InspeccionRepository _inspeccionRepository;

  @override
  Future<DataState<InspeccionDataSourceResEntity>> call({required DataSource params}) {
    return _inspeccionRepository.dataSource(params);
  }
}
