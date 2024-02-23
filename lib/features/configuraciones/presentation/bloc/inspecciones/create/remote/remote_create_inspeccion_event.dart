import 'package:eos_mobile/features/configuraciones/domain/entities/inspeccion_entity.dart';
import 'package:eos_mobile/shared/shared.dart';

abstract class RemoteCreateInspeccionEvent extends Equatable {
  const RemoteCreateInspeccionEvent({this.inspeccion});

  final InspeccionEntity? inspeccion;

  @override
  List<Object> get props => [inspeccion!];
}

class CreateInspeccion extends RemoteCreateInspeccionEvent {
  const CreateInspeccion(InspeccionEntity inspeccion) : super(inspeccion: inspeccion);
}
