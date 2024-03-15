import 'package:eos_mobile/features/configuraciones/domain/entities/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/shared/shared.dart';

part 'remote_inspeccion_tipo_event.dart';
part 'remote_inspeccion_tipo_state.dart';

class RemoteInspeccionTipoBloc extends Bloc<RemoteInspeccionTipoEvent, RemoteInspeccionTipoState> {
  RemoteInspeccionTipoBloc(super.initialState);
}
