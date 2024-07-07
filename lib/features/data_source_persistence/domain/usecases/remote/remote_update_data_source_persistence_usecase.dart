import 'package:eos_mobile/core/data/data_source/data_source_persistence.dart';
import 'package:eos_mobile/features/data_source_persistence/domain/repositories/data_source_persistence_repository.dart';
import 'package:eos_mobile/shared/shared_libs.dart';

class RemoteUpdateDataSourcePersistenceUseCase implements UseCase<bool, DataSourcePersistence> {
  RemoteUpdateDataSourcePersistenceUseCase(this._dataSourcePersistenceRepository);

  final DataSourcePersistenceRepository _dataSourcePersistenceRepository;

  @override
  Future<bool> call({required DataSourcePersistence params}) async {
    return _dataSourcePersistenceRepository.update(params);
  }
}
