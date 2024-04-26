import 'package:eos_mobile/shared/shared_libraries.dart';

class UnidadTipoDataModel extends UnidadTipoDataEntity {
  const UnidadTipoDataModel({
    String? idUnidadTipo,
    String? name,
    String? seccion,
  }) : super(
        idUnidadTipo  : idUnidadTipo,
        name          : name,
        seccion       : seccion,
      );

  /// Constructor factory para crear la instancia de [UnidadTipoDataModel]
  /// durante el mapeo del JSON.
  factory UnidadTipoDataModel.fromJson(Map<String, dynamic> jsonMap) {
    return UnidadTipoDataModel(
      idUnidadTipo  : jsonMap['idUnidadTipo'] as String? ?? '',
      name          : jsonMap['name'] as String? ?? '',
      seccion       : jsonMap['seccion'] as String? ?? '',
    );
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'idUnidadTipo'  : idUnidadTipo,
      'name'          : name,
      'seccion'       : seccion,
    };
  }
}

@immutable
class UnidadTipoDataEntity extends Equatable {
  const UnidadTipoDataEntity({this.idUnidadTipo, this.name, this.seccion});

  final String? idUnidadTipo;
  final String? name;
  final String? seccion;

  @override
  List<Object?> get props => [ idUnidadTipo, name, seccion ];
}
