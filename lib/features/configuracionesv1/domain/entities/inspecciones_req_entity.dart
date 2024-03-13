import 'package:eos_mobile/shared/shared.dart';

class InspeccionReqEntity extends Equatable {
  const InspeccionReqEntity({
    required this.idInspeccion,
  });

  final String idInspeccion;

  @override
  List<Object?> get props => [idInspeccion];
}
