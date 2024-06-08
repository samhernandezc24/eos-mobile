import 'package:eos_mobile/core/components/data_source_persistence/domain/repositories/data_source_persistence_repository.dart';
import 'package:eos_mobile/core/data/data_source_persistence.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

class UpdateDataSourcePersistenceUseCase implements UseCase<DataState<ServerResponse>, DataSourcePersistence> {
  UpdateDataSourcePersistenceUseCase(this._dataSourcePersistenceRepository);

  final DataSourcePersistenceRepository _dataSourcePersistenceRepository;

  @override
  Future<DataState<ServerResponse>> call({required DataSourcePersistence params}) {
    return _dataSourcePersistenceRepository.update(params);
  }
}
