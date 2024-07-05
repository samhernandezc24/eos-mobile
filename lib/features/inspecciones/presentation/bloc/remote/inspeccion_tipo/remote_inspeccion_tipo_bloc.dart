import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/remote/inspeccion_tipo/remote_delete_inspeccion_tipo_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/remote/inspeccion_tipo/remote_list_inspeccion_tipo_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/remote/inspeccion_tipo/remote_store_inspeccion_tipo_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/remote/inspeccion_tipo/remote_update_inspeccion_tipo_usecase.dart';

import 'package:eos_mobile/shared/shared_libs.dart';

part 'remote_inspeccion_tipo_event.dart';
part 'remote_inspeccion_tipo_state.dart';

class RemoteInspeccionTipoBloc extends Bloc<RemoteInspeccionTipoEvent, RemoteInspeccionTipoState> {
  RemoteInspeccionTipoBloc(
    this._remoteListInspeccionTipoUseCase,
    this._remoteStoreInspeccionTipoUseCase,
    this._remoteUpdateInspeccionTipoUseCase,
    this._remoteDeleteInspeccionTipoUseCase,
  ) : super(RemoteInspeccionTipoInit()) {
    on<ListInspeccionesTipos>(onListInspeccionesTipos);
  }

  // USE CASES
  final RemoteListInspeccionTipoUseCase _remoteListInspeccionTipoUseCase;
  final RemoteStoreInspeccionTipoUseCase _remoteStoreInspeccionTipoUseCase;
  final RemoteUpdateInspeccionTipoUseCase _remoteUpdateInspeccionTipoUseCase;
  final RemoteDeleteInspeccionTipoUseCase _remoteDeleteInspeccionTipoUseCase;

  Future<void> onListInspeccionesTipos(ListInspeccionesTipos event, Emitter<RemoteInspeccionTipoState> emit) async {
    emit(RemoteInspeccionTipoLoading());

    final objDataState = await _remoteListInspeccionTipoUseCase(params: NoParams());

    if (objDataState is DataSuccess) {
      emit(RemoteInspeccionTipoList(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteInspeccionTipoServerFailedMessageList(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteInspeccionTipoServerExceptionMessageList(objDataState.error));
    }
  }
}
