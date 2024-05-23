import 'package:eos_mobile/shared/shared_libraries.dart';

class InspeccionIdReqEntity extends Equatable {
  const InspeccionIdReqEntity({required this.idInspeccion});

  final String idInspeccion;

  @override
  List<Object?> get props => [ idInspeccion ];
}
