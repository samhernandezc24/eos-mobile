import 'package:eos_mobile/shared/shared.dart';

class UnidadMarcaDataModel extends UnidadMarcaDataEntity {
  const UnidadMarcaDataModel({
    String? idUnidadMarca,
    String? name,
  }) : super(
        idUnidadMarca   : idUnidadMarca,
        name            : name,
      );

  /// Constructor factory para crear la instancia de [UnidadMarcaDataModel]
  /// durante el mapeo del JSON.
  factory UnidadMarcaDataModel.fromJson(Map<String, dynamic> jsonMap) {
    return UnidadMarcaDataModel(
      idUnidadMarca   : jsonMap['idUnidadMarca'] as String? ?? '',
      name            : jsonMap['name'] as String? ?? '',
    );
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'idUnidadMarca'   : idUnidadMarca,
      'name'            : name,
    };
  }
}

@immutable
class UnidadMarcaDataEntity extends Equatable {
  const UnidadMarcaDataEntity({this.idUnidadMarca, this.name});

  final String? idUnidadMarca;
  final String? name;

  @override
  List<Object?> get props => [ idUnidadMarca, name ];
}
