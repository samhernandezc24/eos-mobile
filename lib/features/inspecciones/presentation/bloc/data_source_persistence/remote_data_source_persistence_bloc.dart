import 'package:eos_mobile/core/data/data_source_persistence.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/data_source_persistence/update_data_source_persistence_usecase.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

part 'remote_data_source_persistence_event.dart';
part 'remote_data_source_persistence_state.dart';

class RemoteDataSourcePersistenceBloc extends Bloc<RemoteDataSourcePersistenceEvent, RemoteDataSourcePersistenceState> {
  RemoteDataSourcePersistenceBloc(
    this._updateDataSourcePersistenceUseCase,
  ) : super(RemoteDataSourcePersistenceInitial()) {
    on<UpdateDataSourcePersistence>(onUpdateDataSourcePersistence);
  }

  // USE CASES
  final UpdateDataSourcePersistenceUseCase _updateDataSourcePersistenceUseCase;

  Future<void> onUpdateDataSourcePersistence(UpdateDataSourcePersistence event, Emitter<RemoteDataSourcePersistenceState> emit) async {
    emit(RemoteDataSourcePersistenceUpdating());

    final objDataState = await _updateDataSourcePersistenceUseCase(params: event.varArgs);

    if (objDataState is DataSuccess) {
      emit(RemoteDataSourcePersistenceUpdateSuccess(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteDataSourcePersistenceServerFailedMessage(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteDataSourcePersistenceServerFailure(objDataState.serverException));
    }
  }
}
