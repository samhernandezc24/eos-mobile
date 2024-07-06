import 'package:eos_mobile/core/data/data_source/data_source.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_data_source_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/inspeccion_repository.dart';

import 'package:eos_mobile/shared/shared_libs.dart';

class RemoteDataSourceInspeccionUseCase implements UseCase<DataState<InspeccionDataSourceEntity>, DataSource> {
  RemoteDataSourceInspeccionUseCase(this._inspeccionRepository);

  final InspeccionRepository _inspeccionRepository;

  @override
  Future<DataState<InspeccionDataSourceEntity>> call({required DataSource params}) async {
    return _inspeccionRepository.dataSource(params);
  }
}
