import 'package:eos_mobile/config/logic/common/save_load_sensitive_mixin.dart';
import 'package:eos_mobile/shared/shared.dart';

class AuthLogic with ThrottledSaveLoadSensitiveMixin {
  @override
  String get fileName => 'auth_data.dat';

  late final statesById = ValueNotifier<Map<String, dynamic>>({})..addListener(_mappingData);

  void _mappingData() {

  }

  // Future<void> _updateTokenData() async {
  //   final tokenExpiryTimestamp = DateTime.now().add(Duration(minutes: JWT_TOKEN_VALIDITY_MIS));
  //   final tokenKey = '';

  //   String imagen = '';

  //   final claims = {
  //     JwtRegisteredClaimNames.uniqueName: 'admin@workcube.com.mx',
  //     'Id': '',
  //     'Nombre': 'ADMIN MANAGER',
  //     'Imagen': imagen,
  //     'IsAdmin': 'True',

  //   };
  // }

  @override
  void copyFromJson(Map<String, dynamic> value) {
    // TODO: implement copyFromJson
  }

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
