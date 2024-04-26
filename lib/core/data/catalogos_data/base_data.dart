import 'package:eos_mobile/shared/shared_libraries.dart';

class BaseDataModel extends BaseDataEntity {
  const BaseDataModel({
    String? idBase,
    String? name,
    String? codigo,
  }) : super(
        idBase  : idBase,
        name    : name,
        codigo  : codigo,
      );

  /// Constructor factory para crear la instancia de [BaseDataModel]
  /// durante el mapeo del JSON.
  factory BaseDataModel.fromJson(Map<String, dynamic> jsonMap) {
    return BaseDataModel(
      idBase  : jsonMap['idBase'] as String? ?? '',
      name    : jsonMap['name'] as String? ?? '',
      codigo  : jsonMap['codigo'] as String? ?? '',
    );
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'idBase'  : idBase,
      'name'    : name,
      'codigo'  : codigo,
    };
  }
}

@immutable
class BaseDataEntity extends Equatable {
  const BaseDataEntity({this.idBase, this.name, this.codigo});

  final String? idBase;
  final String? name;
  final String? codigo;

  @override
  List<Object?> get props => [ idBase, name, codigo ];
}
