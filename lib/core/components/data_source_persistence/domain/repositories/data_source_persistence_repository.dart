import 'package:eos_mobile/core/data/data_source_persistence.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';

abstract class DataSourcePersistenceRepository {
  // API METHODS
  Future<DataState<ServerResponse>> update(DataSourcePersistence varArgs);
}
