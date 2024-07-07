import 'package:eos_mobile/core/data/data_source/data_source_persistence.dart';

abstract class DataSourcePersistenceRepository {
  // REMOTE OPERATIONS
  Future<bool> update(DataSourcePersistence varArgs);

  // LOCAL OPERATIONS
}
