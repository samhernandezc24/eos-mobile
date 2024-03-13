import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/features/configuraciones/domain/usecases/create_inspeccion_usecase.dart';
import 'package:eos_mobile/features/configuraciones/domain/usecases/get_inspecciones_usecase.dart';
import 'package:eos_mobile/features/configuraciones/domain/usecases/remove_inspeccion_usecase.dart';
import 'package:eos_mobile/features/configuraciones/presentation/bloc/inspecciones/remote/remote_inspecciones_event.dart';
import 'package:eos_mobile/features/configuraciones/presentation/bloc/inspecciones/remote/remote_inspecciones_state.dart';
import 'package:eos_mobile/shared/shared.dart';

// class RemoteInspeccionesBloc extends Bloc<RemoteInspeccionesEvent, RemoteInspeccionesState> {

//   RemoteInspeccionesBloc(
//     this._getInspeccionesUseCase,
//     this._createInspeccionUseCase,
//     this._removeInspeccionUseCase,
//   ) : super(const RemoteInspeccionesLoading()) {
//     on<GetInspecciones> (onGetInspecciones);
//     on<CreateInspeccion> (onCreateInspeccion);
//     on<RemoveInspeccion> (onRemoveInspeccion);
//     on<RefreshInspecciones> (onRefreshInspecciones);
//   }

//   final GetInspeccionesUseCase _getInspeccionesUseCase;
//   final CreateInspeccionUseCase _createInspeccionUseCase;
//   final RemoveInspeccionUseCase _removeInspeccionUseCase;

//   Future<void> onGetInspecciones(GetInspecciones event, Emitter<RemoteInspeccionesState> emit) async {
//     final dataState = await _getInspeccionesUseCase();

//     if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
//       // print(dataState.data!);
//       emit(
//         RemoteInspeccionesDone(dataState.data!),
//       );
//     }

//     if (dataState is DataFailed) {
//       // print(dataState.exception!.message);
//       emit(RemoteInspeccionesFailure(dataState.exception!));
//     }
//   }

//   Future<void> onCreateInspeccion(CreateInspeccion event, Emitter<RemoteInspeccionesState> emit) async {
//     final dataState = await _createInspeccionUseCase(params: event.inspeccion);

//     if (dataState is DataSuccess) {
//       emit(RemoteInspeccionesCreateDone(dataState.data!));
//       final inspecciones = await _getInspeccionesUseCase();
//       emit(RemoteInspeccionesDone(inspecciones.data!));
//     }

//     if (dataState is DataFailed) {
//       emit(RemoteInspeccionesFailure(dataState.exception!));
//     }
//   }

//   Future<void> onRemoveInspeccion(RemoveInspeccion removeInspeccion, Emitter<RemoteInspeccionesState> emit) async {
//     await _removeInspeccionUseCase(params: removeInspeccion.idInspeccion);
//     final inspecciones = await _getInspeccionesUseCase();

//     emit(RemoteInspeccionesDone(inspecciones.data!));
//   }

//   Future<void> onRefreshInspecciones(RefreshInspecciones event, Emitter<RemoteInspeccionesState> emit) async {
//     final dataState = await _getInspeccionesUseCase();

//     if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
//       emit(
//         RemoteInspeccionesDone(dataState.data!),
//       );
//     }

//     if (dataState is DataFailed) {
//       emit(RemoteInspeccionesFailure(dataState.exception!));
//     }
//   }
// }
