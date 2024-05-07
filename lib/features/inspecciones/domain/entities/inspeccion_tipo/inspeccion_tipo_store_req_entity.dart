import 'package:eos_mobile/shared/shared_libraries.dart';

class InspeccionTipoStoreReqEntity extends Equatable {
  const InspeccionTipoStoreReqEntity({required this.codigo, required this.name});

  final String codigo;
  final String name;

  @override
  List<Object?> get props => [ codigo, name ];
}
