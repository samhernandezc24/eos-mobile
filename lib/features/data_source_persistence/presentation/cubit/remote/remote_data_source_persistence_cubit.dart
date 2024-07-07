import 'package:eos_mobile/core/data/data_source/data_source_persistence.dart';
import 'package:eos_mobile/features/data_source_persistence/domain/usecases/remote/remote_update_data_source_persistence_usecase.dart';
import 'package:eos_mobile/shared/shared_libs.dart';

part 'remote_data_source_persistence_state.dart';

class RemoteDataSourcePersistenceCubit extends Cubit<RemoteDataSourcePersistenceState> {
  RemoteDataSourcePersistenceCubit(
    this._remoteUpdateDataSourcePersistenceUseCase,
  ) : super(const RemoteDataSourcePersistenceState(result: false));

  final RemoteUpdateDataSourcePersistenceUseCase _remoteUpdateDataSourcePersistenceUseCase;

  Future<bool> onUpdateDataSourcePersistence({required DataSourcePersistence varArgs}) async {
    try {
      final bool success = await _remoteUpdateDataSourcePersistenceUseCase(params: varArgs);
      emit(RemoteDataSourcePersistenceState(result: success));
      return success;
    } catch (_) {
      emit(const RemoteDataSourcePersistenceState(result: false));
      return false;
    }
  }
}
