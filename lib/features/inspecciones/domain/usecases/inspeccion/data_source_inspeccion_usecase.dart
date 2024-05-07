import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/core/usecases/usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_data_source_res_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/repositories/inspeccion_repository.dart';

class DataSourceInspeccionUseCase implements UseCase<DataState<InspeccionDataSourceResEntity>, Map<String, dynamic>> {
  DataSourceInspeccionUseCase(this._inspeccionRepository);

  final InspeccionRepository _inspeccionRepository;

  @override
  Future<DataState<InspeccionDataSourceResEntity>> call({required Map<String, dynamic> params}) {
    return _inspeccionRepository.dataSource(params);
  }
}
